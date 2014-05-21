//
//  ParentController.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-07.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "ParentController.h"

@interface ParentController ()

@end

@implementation ParentController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        //考慮拿 self.view 試試
        sysScreen = rect.size;
        
        sysVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        
        sysStatusHeight = 20;
        if (sysVersion >= 7.0)
        {
            sysTopFix = 20;
        } else {
            sysTopFix = 0;
        }
        
        self.app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self drawView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //这里一定要call一次,case 用户在界面切换后有翻屏操作
    [self drawLayout:0];
}

-(void)btBack {
    [self dismissModalViewControllerAnimated:YES];
}

//@selector(goBack)
-(UIView *)getButton :(NSString*) img :(SEL)action{
    UIImageView *button = [[UIImageView alloc] init];
    button.contentMode= UIViewContentModeScaleAspectFit;
    button.image = [UIImage imageNamed:img];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    [button addGestureRecognizer:tap];
    [button setUserInteractionEnabled:YES];
    
    return  button;
}
-(void)setTap :(UIView *) view :(SEL)action{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    [view addGestureRecognizer:tap];
    [view setUserInteractionEnabled:YES];
}

//:(int) type 靠左,居中,靠右--->x

//规则1,ios7的界面不覆盖statusbar
//规则2,time是指x轴的次数,并且是整数倍
//依赖全局变量sysSreen  sysVersion

//针对ios7进行top修正
//生成最终结果
- (CGRect)getFrame:(float) left :(float) top :(float) width :(float) height
{
    CGRect re;
    
    //top修正 base on sysVersion
    //sysStatusHeight 用来计算rest(0)
    top += sysTopFix;
    
    re = CGRectMake(left, top, width, height);
    return re;
}
//和statusbar无关,不用修正
- (CGRect)getFrameRela:(float) left :(float) top :(float) width :(float) height
{
    CGRect re;
    
    re = CGRectMake(left, top, width, height);
    return re;
}
//0 竖屏 1 横屏
//type 0 旋转完成 1 将要旋转
- (int)getRotate:(int) type {
    int re = 0;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(orientation == UIInterfaceOrientationPortraitUpsideDown || orientation == UIInterfaceOrientationPortrait) {
    } else {
        //UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight
        re = 1;
    }
    
    //将要旋转,当前的颠倒过来
    if (type==1) {
        if ( re ) {
            re = 0;
        } else {
            re = 1;
        }
    }
    
    return re;
}

//这里直接覆盖
//TODO 注意检查目录是否存在
//TODO 检查写的权限
// thumbnail/0065_ccp/CPG20140227A01-PREVIEW.jpg  pubissue.xml
-(void)saveFileLocal1:(NSData *) data :(NSString *) fullname {
    if ( !fullname ) {
        return;//这里会导致死循环
    }
    NSString *localPath=[self.app.local stringByAppendingPathComponent:fullname];
    
    NSArray* foo = [fullname componentsSeparatedByString: @"/"];
    NSString * dicName = @"";
    for (int i=0;i<foo.count-1;i++) {
        if ([foo[i] isEqual:@""]) {

        } else {
            //   /thumbnail /thumbnail/0065_ccp
            dicName = [NSString stringWithFormat:@"%@/%@",dicName,foo[i]];
            //创建目录
            
            NSString *dataPath = [self.app.local stringByAppendingPathComponent:dicName];
            
            if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
                [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
            }
        }
    }
    
    [data writeToFile:localPath atomically:YES];
}

-(void)saveFileLocal:(NSData *) data :(NSString *) fullname {
    if ( !fullname ) {
        return;//这里会导致死循环
    }
    NSString *localPath=[self.app.local stringByAppendingPathComponent:fullname];
    
    NSArray* foo = [fullname componentsSeparatedByString: @"/"];
    NSString * dicName = @"";
    for (int i=0;i<foo.count-1;i++) {
        if ([foo[i] isEqual:@""]) {
            
        } else {
            //   /thumbnail /thumbnail/0065_ccp
            dicName = [NSString stringWithFormat:@"%@/%@",dicName,foo[i]];
            //创建目录
            
            NSString *dataPath = [self.app.local stringByAppendingPathComponent:dicName];
            
            if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
                [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
            }
        }
    }
    
    bool finished = [data writeToFile:localPath atomically:YES];
    if ( finished ) {
        NSLog(@"%@ is saved",fullname);
        //[self notificate:[NSString stringWithFormat:@"%@ is saved",fullname]];
    }
    
}
-(NSData *)getFileRemote:(NSString*) fullname
{
    NSData * re;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.app.domain,fullname ]];
    
    if (url) {
        NSLog(@"get new data from %@",url);
        re = [NSData dataWithContentsOfURL:url];
    }
    
    return re;
}
-(NSData *)getFileLocal:(NSString*) fullname
{
    NSData * re;
    NSString *localPath=[self.app.local stringByAppendingPathComponent:fullname];
    re = [NSData dataWithContentsOfFile:localPath];
    return re;
}

//远处为准,本地缓存容错
-(NSData *)loadFileRemote:(NSString*) fullname
{
    NSData * re;
    
    re = [self getFileRemote:fullname];
    if ( re ) {//url存在
        //保存到本地,注意创建目录
        [self saveFileLocal:re :fullname];
    } else {//试图从本地获取
        re = [self getFileLocal:fullname];
    }
    
    //此处可能仍然为空,这样就是nil,外部需要检查
    return re;
}

//本地为准,远处缓存容错
-(NSData *)loadFileLocal:(NSString *)fullname
{
    NSData * re;
    
    re = [self getFileLocal:fullname];
    if ( re ) {//本地存在
    } else {//试图从远端获取
        re = [self getFileRemote:fullname];
        
        [self saveFileLocal:re :fullname];
    }
    
    //此处可能仍然为空,这样就是nil,外部需要检查
    return re;
}


- (void)drawView {
    NSLog(@"father drawView");
}

- (void)drawLayout:(int) type
{
    NSLog(@"father drawLayout");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
}

- (void)willRotateToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation duration: (NSTimeInterval)duration {
    
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self drawLayout:1];
    
    /*
    if ( toInterfaceOrientation==UIInterfaceOrientationPortrait ||  toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
        
    */
}


@end
