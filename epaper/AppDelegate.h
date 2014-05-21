//
//  AppDelegate.h
//  epaper
//
//  Created by LegoGreen2 on 2014-03-07.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Params.h"
#import "ParamsIssue.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,NSURLSessionDelegate> {
    float sysVersion;
    
    NSDateFormatter *dfFrom;
    NSDateFormatter *dfTo;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Params *params;
@property (strong, nonatomic) NSString *domain;
@property (strong, nonatomic) NSString *local;

@property (strong, nonatomic) NSArray *menu;

@property (strong, nonatomic) NSURLSession *session;

@property (strong, nonatomic) NSUserDefaults *defaults;
@property (strong, nonatomic) NSMutableDictionary *defaultZips;
//setting
@property (strong, nonatomic) NSMutableDictionary * pubSwitch;//setting 要预先下载的列表
@property (strong, nonatomic) NSNumber * pubMaxKept;
@property (strong, nonatomic) NSNumber * pubMaxFavor;
@property (strong, nonatomic) NSNumber * pub3G;

//下面三個不是保存在註冊表,而是由目錄決定
@property (strong, nonatomic) NSMutableDictionary * pubFavor;//收藏的列表
@property (strong, nonatomic) NSMutableDictionary * pubPre;//下载完成列表
@property (strong, nonatomic) NSMutableDictionary * pubNew;//新的issue

//用來解析issue,一個個下載圖片
@property (strong, nonatomic) ParamsIssue *paramsIssue;

//读日志会用到该属性
@property (strong, nonatomic) NSString *dateStr;


-(NSString*)convertDate:(NSString *) from;

@end
