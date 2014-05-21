//
//  Params.h
//  epaper
//
//  Created by LegoGreen2 on 2014-03-11.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import <Foundation/Foundation.h>

//负责取哪个xml,如何缓存xml
@interface Params : NSObject<NSXMLParserDelegate> {
    NSMutableDictionary *pubDic;
    NSMutableDictionary *issueDic;
}


@property (strong, nonatomic) NSMutableArray *pubArray;
@property (strong, nonatomic) NSMutableArray *issueArray;//这个其实外部不会用到
@property (strong, nonatomic) NSObject *controller;//由于被app引用,不能引用controller


-(void)start;
-(BOOL)isNew:(NSString *) pubName issue:(NSString *) issueName;

@end
