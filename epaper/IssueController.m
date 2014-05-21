//
//  IssueController.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-07.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "IssueController.h"
#import "CollectionIssue.h"
#import "WebController.h"
#import "FavorController.h"

@interface IssueController ()

@end

@implementation IssueController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.keep = [NSMutableArray new];
        self.monthArray = [NSMutableArray new];
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

-(void)btFacebookTap {
    
    WebController *nextController = [[WebController alloc] init];
    nextController.webUrl = @"https://www.facebook.com/andy.wang.7568";
    
    [self presentModalViewController:nextController animated:YES];
}
-(void)btCalendarTap {
    BOOL to = !self.sliderLabel.hidden;
    [self.sliderLabel setHidden: to ];
    [self.slider setHidden:to];
}
-(void)favorTap{
    
    FavorController *nextController = [[FavorController alloc] init];
    
    [self presentModalViewController:nextController animated:YES];

}

//由parent发起调用
- (void)drawView {    
    self.toolBar = [[UIView alloc] init];
    self.toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"titleGrey"]];
    [self.view addSubview:self.toolBar];
    
    UIView *button = [self getButton:@"back" :@selector(btBack)];
    button.frame = [self getFrameRela:10 :0 :30 :30];
    [self.toolBar addSubview:button];
    
    button = [self getButton:@"calendar" :@selector(btCalendarTap)];
    button.frame = [self getFrameRela:10+40 :0 :30 :30];
    [self.toolBar addSubview:button];
    
    button = [self getButton:@"downloaded" :@selector(favorTap)];
    button.frame = [self getFrameRela:10+40+40 :0 :30 :30];
    [self.toolBar addSubview:button];
    
    self.toolRight = [[UIView alloc] init];
    //self.toolRight.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.toolRight];
    
    button = [self getButton:@"facebook" :@selector(btFacebookTap)];
    button.frame = [self getFrameRela:200-40 :0 :30 :30];
    [self.toolRight addSubview:button];
    
    //CGRect frame = self.view.frame;
    //CollectionPub *collectionDelegate = [[CollectionPub alloc] init];
    //[self.keep addObject:collectionDelegate];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];
    
    NSMutableArray * issueArray = [self.pub objectForKey:@"children"];
    int count = [issueArray count];
    CollectionIssue * collectionView;
    NSMutableDictionary * issue;
    NSString * displayMonth = @"";
    for (int i=0;i<count;i++) {
        issue = [issueArray objectAtIndex:i];
        if ( [[issue objectForKey:@"displayMonth"] isEqual:displayMonth] ) {
        } else {
            //新的一页
            displayMonth = [issue objectForKey:@"displayMonth"];
            [self.monthArray addObject:displayMonth];
            //这里的frame无所谓
            collectionView = [[CollectionIssue alloc] initWithFrame:self.view.frame];
            collectionView.controller = self;
            collectionView.fromNo = [NSNumber numberWithInt:i];
            [self.keep addObject:collectionView];
            
            [self.scrollView addSubview:collectionView];
        }
        collectionView.toNo = [NSNumber numberWithInt:i];
    }
    
    self.tipView = [UIView new];
    [self.view addSubview:self.tipView];
    
    
    //self.slider=[[UISlider alloc] initWithFrame:CGRectMake(0, 40, 200, 40)];
    self.slider = [UISlider new];
    self.slider.maximumValue=self.monthArray.count;
    self.slider.minimumValue=0;
    [self.view addSubview:self.self.slider];
    [self.slider addTarget:self action:@selector(sliderHandler:) forControlEvents:UIControlEventValueChanged];
    
    self.sliderLabel = [UILabel new];
    self.sliderLabel.text = @"拖动选择月份";
    self.sliderLabel.textAlignment = NSTextAlignmentCenter;
    self.sliderLabel.textColor = [UIColor whiteColor];
    self.sliderLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.sliderLabel];
    [self btCalendarTap];
}


- (void) sliderHandler: (UISlider *)sender {
    int x = sender.value;
    
    self.sliderLabel.text = self.monthArray[x];
    //[self.sliderLabel setText:[NSString stringWithFormat:@"%d",x]];
    
    
    [self scrollTo:x];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int ratate = [self getRotate:0];
    
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
    
    float x = scrollView.contentOffset.x;
    int pageno = (int)(x/widthReal+0.5);
    
    //NSLog(@" current position x %f y %f  pageno %i ",scrollView.contentOffset.x,scrollView.contentOffset.y, pageno);
    
    
    [self scrollTo:pageno];
}

-(void)scrollTo:(int) pageno {
    
    int ratate = [self getRotate:0];
    
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

    
    CGRect frame = CGRectMake(pageno*widthReal, 0, widthReal, 20); //wherever you want to scroll
    [self.scrollView scrollRectToVisible:frame animated:YES];
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
    
    if (1==1) {//计算X轴
        width = 200;
        left = widthReal-width;
        self.toolRight.frame = [self getFrame:left :top :width :height];
    }
    
    width = widthReal;
    left = 0;
    
    top += height;
    height = 30;
    self.tipView.frame = [self getFrame:left :top :width :height];
    self.tipView.backgroundColor = [UIColor blackColor];
    
    CGRect cg = [self getFrame:left :top :width :height];
    self.sliderLabel.frame = cg;
    
    cg = [self getFrame:left :top+30 :width :30];
    self.slider.frame = cg;
    //self.tipView.backgroundColor = [UIColor redColor];
    
    top += height;
    height = heightReal-30;
    self.scrollView.frame = [self getFrame:left :top :width :height];
    int count = self.keep.count;
    CollectionIssue * collectionView;
    UICollectionViewFlowLayout * collectionLayout;
    self.scrollView.contentSize = CGSizeMake(width*count, height);
    self.scrollView.delegate = self;
    for (int i=0;i<count;i++) {
        collectionView = [self.keep objectAtIndex:i];
        //TODO 每页内容过多怎么办,纵向滚动条?
        collectionView.frame = [self getFrameRela:(left+width*i) :0 :width :height];
        collectionLayout= collectionView.collectionViewLayout;
        collectionLayout.minimumLineSpacing = 50;
        if (ratate) {//横屏
            //layout.itemSize = CGSizeMake(450, 450);
            collectionLayout.minimumInteritemSpacing = 52*2;
            collectionLayout.sectionInset = UIEdgeInsetsMake(50, 52+40, 0, 52+40);
        } else {
            collectionLayout.minimumInteritemSpacing = 49*2;
            collectionLayout.sectionInset = UIEdgeInsetsMake(50, 49+39, 0, 49+39);
            
        }
    }
    
}

@end
