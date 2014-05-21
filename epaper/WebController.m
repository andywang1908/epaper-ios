//
//  WebController.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-20.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "WebController.h"

@interface WebController ()

@end

@implementation WebController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//由parent发起调用
- (void)drawView {
    
    /*
     self.toBar = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 400, 200)];
     self.toBar.backgroundColor = [UIColor redColor];
     [self.view addSubview:self.toBar];
     self.toRight = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 200, 200)];
     self.toRight.backgroundColor = [UIColor greenColor];
     [self.toBar addSubview:self.toRight];*/
    
    self.toolBar = [[UIView alloc] init];
    [self.view addSubview:self.toolBar];
    
    UIView *button = [self getButton:@"back" :@selector(btBack)];
    //TODO 动态
    button.frame = [self getFrameRela:10 :0 :30 :30];
    [self.toolBar addSubview:button];
    
    self.webView = [UIWebView new];
    NSURL *url = [[NSURL alloc] initWithString:self.webUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
    
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
    
    //CGRect rect;
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
    
    top += height;
    height = heightReal-top;
    self.webView.frame = [self getFrame:left :top :width :height];
    
}


@end
