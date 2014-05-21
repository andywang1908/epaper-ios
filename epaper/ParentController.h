//
//  ParentController.h
//  epaper
//
//  Created by LegoGreen2 on 2014-03-07.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ParentController : UIViewController{
    float sysVersion;
    float sysTopFix;
    float sysStatusHeight;//写到define里面可能会快些
    CGSize sysScreen;
}


@property (strong, nonatomic) AppDelegate *app;

@property (strong, nonatomic) UIView *toolBar;
@property (strong, nonatomic) UIView *toolCenter;
@property (strong, nonatomic) UIView *toolRight;



-(void)btBack;
-(UIView *)getButton :(NSString*) img :(SEL)action;
-(void)setTap :(UIView *) view :(SEL)action;

- (void)drawLayout:(int) type;
- (void)drawView;


- (CGRect)getFrame:(float) left :(float) top :(float) width :(float) height;
- (CGRect)getFrameRela:(float) left :(float) top :(float) width :(float) height;
- (int)getRotate:(int) type;//0 竖屏 1 横屏

-(NSData *)loadFileRemote:(NSString*) fullname;
-(NSData *)loadFileLocal:(NSString*) fullname;

//下面3个方法,只负责文件,不管什么类型的文件,也不负责容错
-(void)saveFileLocal:(NSData *) data :(NSString *) fullname;
-(NSData *)getFileRemote:(NSString*) fullname;
-(NSData *)getFileLocal:(NSString*) fullname;



@end
