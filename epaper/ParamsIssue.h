//
//  ParamsIssue.h
//  epaper
//
//  Created by LegoGreen2 on 2014-03-14.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParamsIssue : NSXMLParser<NSXMLParserDelegate>{
    NSMutableDictionary *articleDic;
    NSMutableDictionary *sectionDic;
}

@property (strong, nonatomic) NSMutableDictionary *issueDic;//这个和controller的issueDic数据来源不一样
@property (strong, nonatomic) NSMutableArray *sectionArray;//暂时不存在children数据
@property (strong, nonatomic) NSMutableArray *articleArray;//避免客户端根据sectionArray再去计算
@property (strong, nonatomic) NSObject *controller;//由于被app引用,不能引用controller

@end
