//
//  LogController.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-25.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "LogController.h"

@interface LogController ()

@end

@implementation LogController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSError * error;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.log",logDirectory,self.app.dateStr];
    NSString *txtContent = [[NSString alloc]
                            initWithContentsOfFile:filePath
                            encoding:NSUTF8StringEncoding
                            error:&error];
    
    self.textView.text = txtContent;
}


//由parent发起调用
- (void)drawView {
    self.toolBar = [[UIView alloc] init];
    self.toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"titleGrey"]];
    [self.view addSubview:self.toolBar];
    
    UIView *button = [self getButton:@"back" :@selector(btBack)];
    button.frame = [self getFrameRela:10 :0 :30 :30];
    [self.toolBar addSubview:button];
    
    self.toolRight = [[UIView alloc] init];
    //self.toolRight.backgroundColor = [UIColor yellowColor];
    [self.toolBar addSubview:self.toolRight];
    
    button = [self getButton:@"index" :@selector(mailTap)];
    button.frame = [self getFrameRela:120-40 :0 :30 :30];
    [self.toolRight addSubview:button];
    
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.textView];
}
-(void)mailTap {
    
    NSString *urlStr = [NSString stringWithFormat:@"mailto://andy.wang@aitsolution.ca?subject=log detail&body=Thank you for your help!<br><br><br>%@",self.textView.text ];
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [[UIApplication sharedApplication] openURL:url];
}

//认定可操作面积是从statusbar往下的
- (void)drawLayout:(int) type
{
    [super drawLayout:type];
    
    int ratate = [self getRotate:type];
    
    //真实宽高 base on ratate,从而计算rest
    float widthReal;
    float heightReal;
    if (ratate) {//横屏
        widthReal = sysScreen.height;
        heightReal = sysScreen.width;
    } else {//竖屏
        widthReal = sysScreen.width;
        heightReal = sysScreen.height;
    }
    heightReal = heightReal-20;
    
    float top;
    float height;
    float left;
    float width;
    
    left = 0;
    width = widthReal;
    
    top = 0;
    height = 0;
    
    top += height;
    height = 30;
    self.toolBar.frame = [self getFrame:left :top :width :height];
    
    if (1==1) {
        width = 120;
        left = widthReal-width;
        self.toolRight.frame = [self getFrameRela:left :0 :width :height];
    }
    width = widthReal;
    left = 0;
    
    top += height;
    height = heightReal-30;
    self.textView.frame = [self getFrame:left :top :width :height];
    self.textView.contentOffset = CGPointMake(0.0, self.textView.contentSize.height);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
