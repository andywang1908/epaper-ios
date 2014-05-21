//
//  PubController.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-07.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "PubController.h"
#import "CollectionPub.h"
#import "SettingController.h"
#import "LogController.h"

@interface PubController ()

@end

@implementation PubController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.keep = [NSMutableArray new];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btSettingTap {
    //LogController *nextController = [[LogController alloc] init];
    SettingController *nextController = [[SettingController alloc] init];
    //[self.navigationController pushViewController:easyView1 animated:YES];
    [self presentModalViewController:nextController animated:YES];
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
    
    self.toBar = [[UIView alloc] init];
    [self.view addSubview:self.toBar];
    
    self.toolRight = [[UIView alloc] init];
    [self.toBar addSubview:self.toolRight];
    
    UIView *button = [self getButton:@"setting" :@selector(btSettingTap)];
    //TODO 动态
    button.frame = [self getFrameRela:50 :20 :40 :40];
    [self.toolRight addSubview:button];
    self.btSetting = button;
    
    
    //CGRect frame = self.view.frame;
    //CollectionPub *collectionDelegate = [[CollectionPub alloc] init];
    //[self.keep addObject:collectionDelegate];
    
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    
    int count = self.app.params.pubArray.count;
    CollectionPub * collectionView;
    for (int i=0;i<count;i++) {
        if (i%16==0) {
            //这里的frame无所谓
            collectionView = [[CollectionPub alloc] initWithFrame:self.view.frame];
            collectionView.controller = self;
            collectionView.fromNo = [NSNumber numberWithInt:i];
            [self.keep addObject:collectionView];
            
            [self.scrollView addSubview:collectionView];
        } else if (i%16==15 || i==(count-1)) {
            collectionView.toNo = [NSNumber numberWithInt:i];
        }
    }
    
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
    
    CGRect rect;
    float top;
    float height;
    float left;
    float width;
    
    left = 0;
    width = widthReal;
    
    top = 0;
    height = 880;
    if (ratate) {//横屏
        height = 680;
    }
    self.scrollView.frame = [self getFrame:left :top :width :height];
    int count = self.keep.count;
    CollectionPub * collectionView;
    UICollectionViewFlowLayout * collectionLayout;
    self.scrollView.contentSize = CGSizeMake(width*count, height);
    
    for (int i=0;i<count;i++) {
        collectionView = [self.keep objectAtIndex:i];
        collectionView.frame = [self getFrameRela:(left+width*i) :0 :width :height];
        collectionLayout= collectionView.collectionViewLayout;
        if (ratate) {//横屏
            collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bookshelf"]];
            
            //layout.itemSize = CGSizeMake(450, 450);
            collectionLayout.minimumLineSpacing = 38;
            collectionLayout.minimumInteritemSpacing = 62*2;
            collectionLayout.sectionInset = UIEdgeInsetsMake(38, 40, 0, 40);
        } else {
            collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bookshelf1"]];
            
            collectionLayout.minimumLineSpacing = 88;
            collectionLayout.minimumInteritemSpacing = 30*2;
            collectionLayout.sectionInset = UIEdgeInsetsMake(88, 30, 0, 30);
            
        }
    }
    
    top += height;
    height = heightReal-top;
    self.toBar.frame = [self getFrame:left :top :width :height];
    /**/
    if (ratate) {//横屏
        self.toBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"titleYellow"]];
    } else {
        self.toBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"titleYellow1"]];
    }
    
    //self.toolBar.backgroundColor = [UIColor blueColor];
    
    if (1==1) {//计算X轴
        width = 200;
        left = widthReal-width;
        self.toolRight.frame = [self getFrameRela:left :0 :width :height];
        //self.toolRight.backgroundColor = [UIColor yellowColor];
        self.btSetting.frame = [self getFrameRela:50 :(height-40)/2 :40 :40];
    }
    
}


@end
