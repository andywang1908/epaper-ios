//
//  Params.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-11.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "Params.h"
#import "ParentController.h"

@implementation Params

-(void)start
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"note" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSData *mockData = [NSData dataWithContentsOfURL:url];
    
    ParentController *controller = (ParentController *) self.controller;
    NSData *data = [controller loadFileRemote:@"pubissue.xml"];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];//mockData  data
    
    //开始解析XML
    //解析结果 保存到哪里由delegate说了算
    parser.delegate = self;
    [parser parse];
}



//文档开始的时候触发

- (void)parserDidStartDocument:(NSXMLParser *)parser

{
    self.pubArray = [NSMutableArray new];
}


//文档出错的时候触发
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"parse xml error: %@",parseError);
    
}



//遇到一个开始标签时候触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName

  namespaceURI:(NSString *)namespaceURI

 qualifiedName:(NSString *)qualifiedName

    attributes:(NSDictionary *)attributeDict

{
    
    //_currentTagName = elementName;
    
    if ([elementName isEqualToString:@"pub"]) {
        pubDic = [NSMutableDictionary new];
        [self.pubArray addObject:pubDic];
        
        self.issueArray = [NSMutableArray new];
        [pubDic setObject:self.issueArray forKey:@"children"];
        
        //TODO to method
        NSString *value;
        
        value = [attributeDict objectForKey:@"code"];
        [pubDic setObject:value forKey:@"code"];
        
        value = [attributeDict objectForKey:@"name"];
        [pubDic setObject:value forKey:@"name"];
    } else if ([elementName isEqualToString:@"issue"]) {
        issueDic = [NSMutableDictionary new];
        //这里不取正文,就不用等end了
        [self.issueArray addObject:issueDic];
        
        //暂时不对articleArray缓存,就不增加了
        
        //TODO to method
        NSString *value;
        
        value = [attributeDict objectForKey:@"display"];
        
        //display直接覆盖只取8位
        if ([value length]>8) {
            value = [value substringToIndex:8];
        }
        [issueDic setObject:value forKey:@"display"];
        //另外取6位分页用
        if ([value length]>6) {
            value = [value substringToIndex:6];
        }
        [issueDic setObject:value forKey:@"displayMonth"];
        
        value = [attributeDict objectForKey:@"icon"];
        [issueDic setObject:value forKey:@"icon"];
        
        value = [attributeDict objectForKey:@"date"];
        [issueDic setObject:value forKey:@"date"];
        
        value = [attributeDict objectForKey:@"zip"];
        [issueDic setObject:value forKey:@"zip"];
    }
    
    
    
}



//遇到字符串时候触发

/* 处理正文
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string

{
    
    
    
    
	string =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //替换回车符和空格
    
    if ([string isEqualToString:@""]) {
        
        return;
        
    }
    
    NSMutableDictionary *dict = [_notes lastObject];
    
    
    
	if ([_currentTagName isEqualToString:@"CDate"] && dict) {
        
        [dict setObject:string forKey:@"CDate"];
        
	}
    
    
 
    
}*/



//遇到结束标签时候出发

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName

  namespaceURI:(NSString *)namespaceURI

 qualifiedName:(NSString *)qName;

{
    
    //self.currentTagName = nil;
    
}





//遇到文档结束时候触发

- (void)parserDidEndDocument:(NSXMLParser *)parser

{
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.notes userInfo:nil];
    
    //self.notes = nil;
    
}


-(BOOL)isNew:(NSString *) pubName issue:(NSString *) issueName {
    for ( int i=0;i<self.pubArray.count;i++ ) {
        //此处线性不安全
        pubDic = self.pubArray[i];
        
        if ( [[pubDic objectForKey:@"code"] isEqualToString:pubName] ) {
            ParentController * abc =  (ParentController *)self.controller;
            int max = [abc.app.pubMaxKept intValue];
            
            self.issueArray = [pubDic objectForKey:@"children"];
            
            for ( int j=0;j<max && j<self.issueArray.count;j++ ) {
                issueDic = self.issueArray[j];
                
                if ( [[issueDic objectForKey:@"date"] isEqualToString:issueName] ) {
                    return true;
                }
            }
            
            
            break;
        }
        
    }
    
    return false;
}

@end
