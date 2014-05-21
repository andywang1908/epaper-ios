//
//  ParamsIssue.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-14.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "ParamsIssue.h"

@implementation ParamsIssue



//文档开始的时候触发

- (void)parserDidStartDocument:(NSXMLParser *)parser

{
    self.articleArray = [NSMutableArray new];
    self.sectionArray = [NSMutableArray new];
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
    
    if ([elementName isEqualToString:@"AI_PAGE"]) {
        articleDic = [NSMutableDictionary new];
        [self.articleArray addObject:articleDic];
        
        //TODO to method
        NSString *value;
        
        value = [attributeDict objectForKey:@"pageno"];
        [articleDic setObject:value forKey:@"pageno"];
        
        value = [attributeDict objectForKey:@"name"];
        [articleDic setObject:value forKey:@"name"];
        
        value = [attributeDict objectForKey:@"isPage"];
        [articleDic setObject:value forKey:@"isPage"];
        
        //注意,这里不一定有
        value = [attributeDict objectForKey:@"icon"];
        if ( value )
        [articleDic setObject:value forKey:@"icon"];
        
        value = [attributeDict objectForKey:@"jpg"];
        [articleDic setObject:value forKey:@"jpg"];
    } else if ([elementName isEqualToString:@"AI_SECTION"]) {
        sectionDic = [NSMutableDictionary new];
        //这里不取正文,就不用等end了
        [self.sectionArray addObject:sectionDic];
        
        //暂时不对articleArray缓存,就不增加了
        
        //TODO to method
        NSString *value;
        
        value = [attributeDict objectForKey:@"sectioncode"];
        [sectionDic setObject:value forKey:@"sectioncode"];
        
        value = [attributeDict objectForKey:@"name"];
        [sectionDic setObject:value forKey:@"name"];
        
        value = [attributeDict objectForKey:@"pagenum"];
        [sectionDic setObject:value forKey:@"pagenum"];
    }
    else if ([elementName isEqualToString:@"AI_PUBLICATION"]) {
        self.issueDic = [NSMutableDictionary new];
        
        //暂时不对articleArray缓存,就不增加了
        
        //TODO to method
        NSString *value;
        
        value = [attributeDict objectForKey:@"width"];
        [self.issueDic setObject:value forKey:@"width"];
        
        value = [attributeDict objectForKey:@"height"];
        [self.issueDic setObject:value forKey:@"height"];
        
        value = [attributeDict objectForKey:@"unit"];
        [self.issueDic setObject:value forKey:@"unit"];
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


@end
