//
//  ArticleController.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-07.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "ArticleController.h"

#define ZOOM_STEP 4 //1.5 4
#define kDuration 0.3
#define kDuration1 1.3
@interface ArticleController ()

@end

@implementation ArticleController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.keep = [NSMutableArray new];
        self.previewImage = [NSMutableArray new];
        
        threadStop = false;
        previewWidth = 140;
        previewSpace = 10;
        currentNo = 0;
        
        //TODO http://witcheryne.iteye.com/blog/1879827 實時更新
        self.reach = [Reachability reachabilityWithHostName:@"www.google.com" ];

    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"thread got cancelled");
    threadStop = true;
}

- (void)realDownload{
    //檢查是否3G網絡
    
    bool realDownloading = true;
    NetworkStatus netStatus = [self.reach currentReachabilityStatus];
    //netStatus = ReachableViaWWAN;//模擬3g
    switch (netStatus)
    {
        case NotReachable:
        {
            //NSLog(@"Access Not Available");
            
            [self showFloatAlert:@"無網絡可用,無法下載"];
            realDownloading = false;
            //return;//不要return 只是不再下載了
            break;
        }
            
        case ReachableViaWWAN:
        {
            NSLog(@"Reachable WWAN");
            
            //檢查是否可以使用3G
            int g3 = [self.app.pub3G intValue];
            if ( g3==0 ) {
                [self showFloatAlert:@"設置了禁止使用流動網絡下載"];
                realDownloading = false;
                //return;//不要return 只是不再下載了
            } else {
                [self showFloatAlert:@"當前正在使用流動網絡下載"];
            }
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"Reachable WiFi");
            break;
        }
    }
    
    [self.spinner startAnimating];
    [self.spinnerLayer setHidden:false];
    
    //TODO 终止
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        int count = self.paramsIssue.articleArray.count;
        NSString * fullname ;
        NSData * iconData;
        NSData * jpgData;
        for (int i=0;i<count && !threadStop ;i++) {
            articleDic = self.paramsIssue.articleArray[i];
            
            /* 使用预览图 */
            fullname = [articleDic objectForKey:@"icon"];
            
            if ( fullname ) {
                if ( realDownloading ) {
                    iconData = [self loadFileLocal:fullname];
                } else {
                    //只從本地拿數據
                    iconData = [self getFileLocal:fullname];
                }
                
            } else {
                iconData = nil;
            }
            
            fullname = [articleDic objectForKey:@"jpg"];
            
            if ( fullname ) {
                if ( realDownloading ) {
                    jpgData = [self loadFileLocal:fullname];
                } else {
                    //只從本地拿數據
                    jpgData = [self getFileLocal:fullname];
                }
            } else {
                jpgData = nil;
            }
            
            float progress = (float)i/(float)count*100;
            
            //NSLog(@"percent %f",progress);
            dispatch_async(dispatch_get_main_queue(), ^{
                /* 使用预览图  注意,不使用会导致preview占用的内存大一些,并且加载时间长一些,但是下载时间减小*/
                if ( iconData ) {
                    ((UIImageView *)self.previewImage[i]).image = [[UIImage alloc] initWithData:iconData];
                }
                /*
                if ( jpgData ) {
                    ((UIImageView *)self.previewImage[i]).image = [[UIImage alloc] initWithData:jpgData];
                }*/
                
                if (i==0 && jpgData) {
                    self.leftView.image = [[UIImage alloc] initWithData:jpgData];
                } else if (i==1 && jpgData) {
                    self.rightView.image = [[UIImage alloc] initWithData:jpgData];
                }
                
                self.spinnerLabel.text = [NSString stringWithFormat:@"下載中 %i%%",(int)progress];
            });
            
        }
        
        //TODO 更新到主线程进度 or 更新一个变量
        dispatch_async(dispatch_get_main_queue(), ^{
            //
            [self.spinner stopAnimating];
            [self.spinnerLayer setHidden:true];
        });
    });
    
}

- (void)viewDidLoad
{
    
    
    /*
     NSString* path = [[NSBundle mainBundle] pathForResource:@"note" ofType:@"xml"];
     NSURL *url = [NSURL fileURLWithPath:path];
     NSData *mockData = [NSData dataWithContentsOfURL:url];*/
    //不能放到init中,fullname还没有数值
    NSData *data = [self loadFileRemote:self.fullname];
    self.paramsIssue = [[ParamsIssue alloc] initWithData:data];//mockData  data
    
    //开始解析XML
    //解析结果 保存到哪里由delegate说了算
    self.paramsIssue.delegate = self.paramsIssue;
    [self.paramsIssue parse];
    
    
    //修正previewWidth from self.paramsIssue
    if ( self.paramsIssue.issueDic ) {
        NSLog(@"%@",self.paramsIssue.issueDic);
        float tmp = [[self.paramsIssue.issueDic objectForKey:@"width"] floatValue];
        previewWidth = tmp*190/13.5;
    }
    
    //这样才能转起来,子线程才能访问到
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    
    
    //注意这里super是放在了后面,不然没有数据
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //解析完了才能开始下载
    //view创建完了,才能开始更新image
    [self realDownload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)swipe:(UISwipeGestureRecognizer *)g{
    
    if (g.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self swipeImage:1];
    } else {
        [self swipeImage:0];
    }
}
-(void)swipeImage:(int) type{
    int result = currentNo;
    int ratate = [self getRotate:0];
    int differ = 1;
    if (ratate) {
        differ = 2;
    }
    
    //UISwipeGestureRecognizerDirectionLeft
    if (type) {
        result += differ;
    } else {
        result -= differ;
    }
    if ( result<0 ) {
        result = 0;
    } else if ( result>=self.paramsIssue.articleArray.count ) {
        result = self.paramsIssue.articleArray.count-1;
    }
    
    
    
    
    [self loadImage:result type:type];
    
    
}



- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.zoomView.zoomScale==1) {
        bool btShow = self.btUp.hidden;
        btShow = !btShow;
        
        self.btUp.hidden = btShow;
        self.btDown.hidden = btShow;
        self.btLeft.hidden = btShow;
        self.btRight.hidden = btShow;
    } else {
        self.btUp.hidden = true;
        self.btDown.hidden = true;
        self.btLeft.hidden = true;
        self.btRight.hidden = true;
    }
    
    self.sectionView.hidden =true;
    self.toolBar.hidden =true;
    self.scrollView.hidden =true;
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    // zoom in
    float newScale = [self.zoomView zoomScale] * ZOOM_STEP;
    
    NSLog(@"%f %f",[self.zoomView zoomScale],self.zoomView.maximumZoomScale);
    
    if (newScale > self.zoomView.maximumZoomScale){
        newScale = self.zoomView.minimumZoomScale;
    }
    
    if (1==1) {
        CGRect zoomRect = [self zoomRectForScale2:newScale
                                      withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [self.zoomView zoomToRect:zoomRect animated:YES];
    } else {
        //newScale = self.zoomView.maximumZoomScale;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        
        [self.zoomView zoomToRect:zoomRect animated:YES];
    }
    
    
    [self switchToolBar];
}

//center一定要用 locationInView:gestureRecognizer.view  不能zoom.frame 寬高比不一樣的
//統一換算成1倍時候的比例  不是圖片一倍 而是imageView一倍
//這個會切換到中間
- (CGRect)zoomRectForScale1:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    //NSLog(@"frame unchanged %f %f ",[self.zoomView frame].size.width,[self.zoomView frame].size.height);
    //NSLog(@"changed %f %f ",center.x,center.y);
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.width  = [self.zoomView frame].size.width  / scale;
    zoomRect.size.height = [self.zoomView frame].size.height / scale;
    
    // choose an origin so as to get the right center.
    float xOri = center.x / self.zoomView.zoomScale;
    float yOri = center.y / self.zoomView.zoomScale;
    //NSLog(@"Ori %f %f ",xOri,yOri);
    
    zoomRect.origin.x    = xOri - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = yOri - (zoomRect.size.height / 2.0);
    
    //NSLog(@"XY %f %f ",zoomRect.origin.x,zoomRect.origin.y);
    
    return zoomRect;
}

//center一定要用 locationInView:gestureRecognizer.view  不能zoom.frame 寬高比不一樣的
//統一換算成1倍時候的比例  不是圖片一倍 而是imageView一倍
//這個保持位置不變
- (CGRect)zoomRectForScale2:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    //NSLog(@"frame unchanged %f %f ",[self.zoomView frame].size.width,[self.zoomView frame].size.height);
    //NSLog(@"changed %f %f ",center.x,center.y);
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.width  = [self.zoomView frame].size.width  / scale;
    zoomRect.size.height = [self.zoomView frame].size.height / scale;
    
    // choose an origin so as to get the right center.
    float xOri = center.x / self.zoomView.zoomScale;
    float yOri = center.y / self.zoomView.zoomScale;
    //NSLog(@"Ori %f %f ",xOri,yOri);
    
    zoomRect.origin.x    = xOri - (xOri/scale);
    zoomRect.origin.y    = yOri - (yOri/scale);
    
    //NSLog(@"XY %f %f ",zoomRect.origin.x,zoomRect.origin.y);
    
    return zoomRect;
}


- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    //NSLog(@"%f %f ",[self.zoomView frame].size.width,[self.zoomView frame].size.height);
    //NSLog(@"%f %f ",center.x,center.y);
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.width  = [self.zoomView frame].size.width  / scale;
    zoomRect.size.height = [self.zoomView frame].size.height / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    // two-finger tap zooms out
    float newScale = [self.zoomView zoomScale] / ZOOM_STEP;
    NSLog( @"%f %f",newScale,[self.zoomView zoomScale]  );
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [self.zoomView zoomToRect:zoomRect animated:YES];
    
    [self switchToolBar];
}

-(void)switchToolBar {
    if ( self.zoomView.zoomScale<=1 ) {
        [self.toolBar setHidden:false];
    } else {
        [self.toolBar setHidden:true];
    }
}

- (void)btUpTap {
    //[self.toolBar setHidden:false];
    [self switchToolBar];
}

- (void)btDownTap {
    [self.scrollView setHidden:false];
    [self.sectionView setHidden:false];
}

- (void)btLeftTap {
    
    [self swipeImage:0];
}

- (void)btRightTap {
    
    [self swipeImage:1];
}
-(void) setTitleLabel {
    self.titleLabel.text = [self getTitleLabel];
}
-(NSString *) getTitleLabel {
    NSString * title;
    NSString * pubName = [self.pubDic objectForKey:@"name"];
    NSString * issueName = [self.issueDic objectForKey:@"display"];
    issueName = [self.app convertDate:issueName];
    title = [NSString stringWithFormat:@"%@         %@         第%i頁 共%i頁",issueName,pubName,currentNo, self.paramsIssue.articleArray.count ];//+1
    return title;
}

-(void)showFloatAlert:(NSString *) msg
{
    self.floatAlert.text = msg;
    [self.floatAlert setHidden:false];
    
    [self performSelector:@selector(hideFloatAlert) withObject:nil afterDelay:2];
}

-(void)hideFloatAlert {
    [self.floatAlert setHidden:true];
}

-(void)favorTap {
    ///0065_ccp/20021107/0065_ccp20021107-paper.xml
    NSArray* foo = [self.fullname componentsSeparatedByString: @"/"];
    if ( foo.count==3 ) {
        NSString * code = foo[0];
        
        NSString * date = foo[1];
        
        NSString * fullname = [NSString stringWithFormat:@"%@/%@",code,date];
        
        //检查是否已经收藏 /Favor
        //[self.app.local stringByAppendingPathComponent:fullname]
        NSString *localPath=[NSString stringWithFormat:@"%@/%@/%@",self.app.local,fullname,@"Favor"];
        
        //删除老的文件,避免因为上次下载的文件不正确,却无法更新,以及垃圾文件的处理
        if ([[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
            [self.app.pubFavor removeObjectForKey:fullname];
            [[NSFileManager defaultManager] removeItemAtPath:localPath error:nil];
            [self showFloatAlert:@"取消收藏成功"];
        } else {
            //准备收藏
            //检查上限
            int max = [self.app.pubMaxFavor intValue];
            int now = [self.app.pubFavor allKeys].count;
            if ( now>=(max) ) {
                [self showFloatAlert:@"超过收藏期数上限"];
                return;
            }
            
            [self.app.pubFavor setObject:@"favor" forKey:fullname];
            [[NSFileManager defaultManager] createDirectoryAtPath:localPath  withIntermediateDirectories:YES attributes:nil error:nil];
            [self showFloatAlert:@"收藏成功"];
        }

    }
}


//由parent发起调用
- (void)drawView {
    
    //self.view.backgroundColor= [UIColor colorWithRed:(255.0 / 255.0) green:(255.0 / 255.0) blue:(255.0 / 255.0) alpha: 0];
    
    self.zoomView = [[UIScrollView alloc] init];
    self.zoomGroup = [[UIView alloc] init];
    self.leftView = [UIImageView new];
    self.rightView = [UIImageView new];
    self.leftView.contentMode= UIViewContentModeScaleAspectFit;
    self.leftView.backgroundColor = [UIColor whiteColor];
    self.rightView.backgroundColor = [UIColor whiteColor];
    self.rightView.contentMode= UIViewContentModeScaleAspectFit;
    
    self.zoomView.bouncesZoom = YES;
    self.zoomView.delegate = self;
    self.zoomView.clipsToBounds = YES;
    /*
    self.zoomView.userInteractionEnabled = YES;
    self.zoomGroup.userInteractionEnabled = YES;*/
    float minimumScale = 1.0;//This is the minimum scale, set it to whatever you want. 1.0 = default
    self.zoomView.maximumZoomScale = ZOOM_STEP;// 4  ZOOM_STEP
    self.zoomView.minimumZoomScale = minimumScale;
    self.zoomView.zoomScale = 1;
    [self.zoomView setContentMode:UIViewContentModeScaleAspectFit];
    //[imageView sizeToFit];
    //[self.zoomView setContentSize:CGSizeMake(imageView.frame.size.width, imageView.frame.size.height)];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    //UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
    //[singleTap setNumberOfTapsRequired:1];
    [doubleTap setNumberOfTapsRequired:2];
    //[twoFingerTap setNumberOfTouchesRequired:2];
    
    //Adding gesture recognizer
    [self.zoomView addGestureRecognizer:singleTap];
    [self.zoomView addGestureRecognizer:doubleTap];
    //[self.zoomView addGestureRecognizer:twoFingerTap];
    
    
    UISwipeGestureRecognizer  *swipeRight;
    UISwipeGestureRecognizer  *swipeLeft;
    
    //增加左右滑動首飾
    swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.zoomView addGestureRecognizer:swipeLeft];
    [self.zoomView addGestureRecognizer:swipeRight];
    
    
    [self.zoomGroup addSubview:self.rightView];
    [self.zoomGroup addSubview:self.leftView];
    [self.zoomView addSubview:self.zoomGroup];
    [self.view addSubview:self.zoomView];
    
    //最下面,最先加的是zoomView,然后是button
    self.btUp = [self getButton:@"arrowDown" :@selector(btUpTap)];
    self.btRight = [self getButton:@"arrowRight" :@selector(btRightTap)];
    self.btLeft = [self getButton:@"arrowLeft" :@selector(btLeftTap)];
    self.btDown = [self getButton:@"arrowUp" :@selector(btDownTap)];
    [self.view addSubview:self.btUp];
    [self.view addSubview:self.btRight];
    [self.view addSubview:self.btLeft];
    [self.view addSubview:self.btDown];
    
    
    
    self.toolBar = [[UIView alloc] init];
    self.toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"titleGrey"]];
    //self.toolBar.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.toolBar];
    
    self.toolCenter = [[UIView alloc] init];
    //self.toolCenter.backgroundColor = [UIColor blueColor];
    [self.toolBar addSubview:self.toolCenter];
    
    self.toolRight = [[UIView alloc] init];
    //self.toolRight.backgroundColor = [UIColor yellowColor];
    [self.toolBar addSubview:self.toolRight];
    
    UIView *button = [self getButton:@"back" :@selector(btBack)];
    button.frame = [self getFrameRela:10 :0 :30 :30];
    [self.toolBar addSubview:button];
    
    button = [self getButton:@"index" :@selector(favorTap)];
    button.frame = [self getFrameRela:120-40 :0 :30 :30];
    [self.toolRight addSubview:button];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = [self getFrameRela:0 :0 :400 :30];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.toolCenter addSubview:self.titleLabel];
    
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.scrollView];
    
    int count = [self.paramsIssue.articleArray count];
    NSMutableDictionary * articel;
    //NSString * fullname;
    UIImage *image;
    UIImageView * imageView;
    UILabel * label;
    for (int i=0;i<count;i++) {
        articel = [self.paramsIssue.articleArray objectAtIndex:i];
        //fullname = [articel objectForKey:@"icon"];
        /*
        if (fullname) {
            NSData *imageData = [self getFileLocal:fullname];
            if ( imageData ) {
                image = [[UIImage alloc] initWithData:imageData];
            } else {
                image = [UIImage imageNamed:@"placeholder"];
            }
            
        } else {
            //不这样,目前就是在frame上空出来了
            image = [UIImage imageNamed:@"placeholder"];
        }*/
        //全部用placeholder 子线程下载/检查的时候去更新
        image = [UIImage imageNamed:@"placeholder"];
        
        imageView = [[UIImageView alloc] initWithImage:image];
        [self.previewImage addObject:imageView];
        
        imageView.contentMode= UIViewContentModeScaleAspectFit;
        imageView.tag = i;
        imageView.layer.borderColor = [UIColor blackColor].CGColor;
        imageView.layer.borderWidth = 1.0f;
        
        [self setTap:imageView :@selector(previewTap:)];
        
        imageView.frame = [self getFrameRela:(previewWidth*(i)+i/2*previewSpace) :10 :previewWidth :190];
        [self.scrollView addSubview:imageView];
        
        label = [[UILabel alloc] init];
        label.frame = [self getFrameRela:(previewWidth*(i)+i/2*previewSpace) :200 :previewWidth :25];
        label.backgroundColor = [UIColor redColor];//不過不設置 ios 6 為百色
        label.text = [NSString stringWithFormat:@"%i",i];//+1
        label.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:label];
        
    }
    
    self.sectionView = [[UIScrollView alloc] init];
    self.sectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.sectionView];
    
    count = [self.paramsIssue.sectionArray count];
    for (int i=0;i<count;i++) {
        articel = [self.paramsIssue.sectionArray objectAtIndex:i];
        
        label = [[UILabel alloc] init];
        label.frame = [self getFrameRela:(previewWidth*(i)) :0 :previewWidth :25];
        label.text = [articel objectForKey:@"name"];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = i;
        [self.sectionView addSubview:label];
        
        [self setTap:label :@selector(sectionTap:)];
        
    }
    
    self.spinnerLayer = [UIView new];
    self.spinner.frame = [self getFrameRela:0 :0 :120 :60];
    
    self.spinnerLabel = [[UILabel alloc] initWithFrame:[self getFrameRela:0 :60 :120 :20]];
    self.spinnerLabel.text = @"下載中 0%";
    self.spinnerLabel.textAlignment = NSTextAlignmentCenter;
    self.spinnerLabel.backgroundColor = [UIColor clearColor];
    self.spinnerLabel.textColor = [UIColor whiteColor];
    
    [self.spinnerLayer addSubview:self.spinner];
    [self.spinnerLayer addSubview:self.spinnerLabel];
    [self.view addSubview:self.spinnerLayer];
    self.spinnerLayer.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:0.5];
    self.spinnerLayer.layer.cornerRadius = 5.5; // 圓角的弧度
    self.spinnerLayer.layer.masksToBounds = YES;
    //self.spinnerLayer.backgroundColor = [UIColor clearColor];
    //self.spinner.center = self.view.center;//不准确,尤其横屏的时候
    
    //[self.toolBar setHidden:true];
    [self switchToolBar];
    [self.scrollView setHidden:true];
    [self.sectionView setHidden:true];
    
    self.floatAlert = [[UILabel alloc] init];
    //self.floatAlert.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:0.5];
    [self.floatAlert setHidden:true];
    self.floatAlert.backgroundColor = [UIColor blackColor];
    self.floatAlert.textColor = [UIColor whiteColor];
    self.floatAlert.textAlignment = NSTextAlignmentCenter;
    self.floatAlert.layer.cornerRadius = 10.5; // 圓角的弧度
    //self.floatAlert.layer.masksToBounds = YES;
    //self.floatAlert.text = @"下载中 0%";
    //一定要在最后,这样才能确保显示
    [self.view addSubview:self.floatAlert];
    
    
    //由子线程来载入图片 like preview   但是还是要靠他来加载title
    /**/
    if ( currentNo<self.paramsIssue.articleArray.count ) {
        [self loadImage:currentNo type:-2];
    }
    
    //最上面是一个全屏的arrowView
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.zoomGroup;
}

-(void) setOrder:(UIView*) viewUp :(UIView*) viewDown
{
    int idxUp = [viewUp.superview.subviews indexOfObject:viewUp];
    int idxDown = [viewUp.superview.subviews indexOfObject:viewDown];
    
    if ( idxUp<idxDown ) {
        [viewUp.superview exchangeSubviewAtIndex:idxUp withSubviewAtIndex:idxDown];
    }
    
    //NSLog(@"up %i down %i",idxUp,idxDown);
    //
}

- (void) switchSection:(int) secIdx {
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
    
    int articleIdx=0;
    NSMutableDictionary *section;
    for ( int i=0; i<secIdx && i<self.paramsIssue.sectionArray.count;i++ ) {
        section = self.paramsIssue.sectionArray[i];
        articleIdx += [[section objectForKey:@"pagenum"] intValue];
    }
    //articleIdx;
    
    CGRect frame = CGRectMake((previewWidth*(articleIdx)+articleIdx/2*previewSpace), 0, widthReal, 20); //wherever you want to scroll
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (void) sectionTap:(UITapGestureRecognizer *)gr {
    UILabel *label = (UILabel *)gr.view;
    //NSLog(@"%i is clicked",image.tag);
    [self switchSection:label.tag];
}

- (void) previewTap:(UITapGestureRecognizer *)gr {
    UIImageView *image = (UIImageView *)gr.view;
    //NSLog(@"%i is clicked",image.tag);
    // 將該頁面滾到前面
    
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
    
    int i = image.tag;
    
    CGRect frame = CGRectMake(previewWidth*(i)+i/2*previewSpace, 0, widthReal, 20); //wherever you want to scroll
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    
    [self loadImage:image.tag type:-1];
}

-(void)leftDelay:(NSData *) imgData {
    self.leftView.image = [[UIImage alloc] initWithData:imgData];
}
-(void)rightDelay:(NSData *) imgData {
    self.rightView.image = [[UIImage alloc] initWithData:imgData];
}
//由於要判讀是否能夠載入新的圖片,這裡就就要求傳入切換效果(type)
//type -2 表示第一次載入
- (void)loadImage:(int) idx type:(int) type {
    
    if ( idx==0 && currentNo==0 && type!=-2 ) {
        [self showFloatAlert:@"前面沒有內容了!"];
        return;
    } else if ( idx>=(self.paramsIssue.articleArray.count-1) && currentNo>=(self.paramsIssue.articleArray.count-1) && type!=-2 ) {
        [self showFloatAlert:@"後面沒有內容了!"];
        return;
    }
    
    //检查下面一张/两张图片是否存在,不存在就不动
    int idxLeft = 0;
    int idxRight = 0;
    NSString * artilceName;
    NSData * leftData;
    NSData * rightData;
    NSData * leftDataTmp;
    NSData * rightDataTmp;
    
    if (idx%2==0) {//左边
        idxLeft = idx;
        idxRight = idx+1;
        
    } else {//右边
        idxLeft = idx-1;
        idxRight = idx;
    }
    //idxLeft 一定小于idxRight?
    if ( idxLeft<0 ) {
        idxLeft = 0;
    }
    if ( idxRight<0 ) {
        idxRight = 0;
    }
    if ( idxLeft>=self.paramsIssue.articleArray.count ) {
        idxLeft = self.paramsIssue.articleArray.count-1;
    }
    if ( idxRight>=self.paramsIssue.articleArray.count ) {
        idxRight = self.paramsIssue.articleArray.count-1;
    }
    
    
    articleDic = self.paramsIssue.articleArray[idxLeft];
    artilceName = [articleDic objectForKey:@"jpg"];
    leftData = [self getFileLocal:artilceName];
    artilceName = [articleDic objectForKey:@"icon"];
    leftDataTmp = [self getFileLocal:artilceName];
    
    articleDic = self.paramsIssue.articleArray[idxRight];
    artilceName = [articleDic objectForKey:@"jpg"];
    rightData = [self getFileLocal:artilceName];
    artilceName = [articleDic objectForKey:@"icon"];
    rightDataTmp = [self getFileLocal:artilceName];
    
    if ( leftData==nil || rightData==nil ) {
        [self showFloatAlert:@"載入中,請稍候"];
        return;
    }
    
    currentNo = idx;
    [self setTitleLabel];
    
    //[self setTitleLabel:nil];
    self.zoomView.zoomScale = 1;
    if (idx%2==0) {//左边
        [self setOrder:self.leftView :self.rightView];
        
    } else {//右边
        [self setOrder:self.rightView :self.leftView];
        
    }
    
    
    
    
    
    /* 还是用HMGLTransitions 注意不同方向的效果要一致*/
    /*
     __block CGRect frame = self.view.frame;
     frame.origin.y = - 320;
     [self.view setFrame:frame];
     [UIView animateWithDuration:0.75 animations:^{
     frame.origin.y = -20;
     //frame.size.width = 310.0f;
     [self.view setFrame:frame];
     }];
     
     
     [UIView beginAnimations:nil context:nil];//@"View Flip"
     //动画持续时间
     [UIView setAnimationDuration:0.75];
     //设置动画的回调函数，设置后可以使用回调方法
     [UIView setAnimationDelegate:self];
     //设置动画曲线，控制动画速度
     [UIView  setAnimationCurve: UIViewAnimationCurveEaseInOut];
     //设置动画方式，并指出动画发生的位置
     [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view  cache:YES];
     //提交UIView动画
     [UIView commitAnimations];
     
     */
    
    
    self.leftView.image = [[UIImage alloc] initWithData:leftData];
    
    self.rightView.image = [[UIImage alloc] initWithData:rightData];
    
    //[self performSelector:@selector(leftDelay:) withObject:leftData afterDelay:kDuration];
    
    //[self performSelector:@selector(rightDelay:) withObject:rightData afterDelay:kDuration];
    
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeBoth;// kCAFillModeBoth kCAFillModeForwards
    
    /*
     animation.type = kCATransitionPush;
     animation.type = kCATransitionReveal;
     animation.type = kCATransitionFade;
     animation.type = kCATransitionMoveIn;
     animation.type = @"cube";
     animation.type = @"suckEffect";
     animation.type = @"oglFlip";
     animation.type = @"rippleEffect";
     animation.type = @"pageCurl";
     animation.type = @"pageUnCurl";
     animation.type = @"cameraIrisHollowOpen";
     animation.type = @"cameraIrisHollowClose";*/
    
    //全屏動畫時候才需要調整方向
    //UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (type==1) {//由於下一篇的圖片太大,這裡要載入png后在刷新
        
        animation.type = kCATransitionMoveIn;
        
        animation.subtype = kCATransitionFromRight;
        
        /*
        if(orientation == UIInterfaceOrientationPortrait) {
            animation.subtype = kCATransitionFromRight;
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            animation.subtype = kCATransitionFromLeft;
        } else if (orientation == UIInterfaceOrientationLandscapeLeft) {
            animation.subtype = kCATransitionFromBottom;
        } else {
            animation.subtype = kCATransitionFromTop;
            // UIInterfaceOrientationLandscapeRight
        }*/
        
    } else if (type==0) {
        
        
        animation.type = kCATransitionMoveIn;
        
        animation.subtype = kCATransitionFromLeft;
        
        /*
        if(orientation == UIInterfaceOrientationPortrait) {
            animation.subtype = kCATransitionFromLeft;
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            animation.subtype = kCATransitionFromRight;
        } else if (orientation == UIInterfaceOrientationLandscapeLeft) {
            animation.subtype = kCATransitionFromTop;
        } else {
            animation.subtype = kCATransitionFromBottom;
            // UIInterfaceOrientationLandscapeRight
        }*/
    } else if (type==-1) {
        
        animation.type = kCATransitionFade;
        
    } else {
    
    }
    
    //animation.subtype = kCATransitionFromLeft;
    //animation.subtype = kCATransitionFromBottom;
    //animation.subtype = kCATransitionFromRight;
    //animation.subtype = kCATransitionFromTop;
    
    
    
    
    
    [[self.zoomView layer] addAnimation:animation forKey:@"animation"];
    
    
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
    heightReal = heightReal-20;//全部切换到ios6的概念,不用新概念
    
    CGRect rect;
    float top;
    float height;
    float left;
    float width;
    
    left = 0;
    width = widthReal;
    
    self.spinnerLayer.frame = [self getFrame:(widthReal-120) :(heightReal-80) :120 :80];
    
    //正中
    self.floatAlert.frame = [self getFrame:(widthReal-280)/2 :(heightReal-80)/2 :280 :80];
    
    self.zoomView.zoomScale = 1;
    self.zoomView.frame = [self getFrame:0 :0 :widthReal :heightReal];
    self.zoomGroup.frame = [self getFrameRela:0 :0 :widthReal :heightReal];
    //要设置,否则翻转后,无法翻页
    [self.zoomView setContentSize:CGSizeMake(widthReal, heightReal)];
    if (ratate) {//横屏	
        
        self.leftView.frame = [self getFrameRela:0 :0 :widthReal/2 :heightReal];
        self.rightView.frame = [self getFrameRela:widthReal/2 :0 :widthReal/2 :heightReal];
    } else {//竖屏
        
        self.leftView.frame = [self getFrameRela:0 :0 :widthReal :heightReal];
        self.rightView.frame = [self getFrameRela:0 :0 :widthReal :heightReal];
    }
    
    float btBorder = 40;
    self.btUp.frame = [self getFrame:(widthReal-btBorder)/2 :0 :btBorder :btBorder];
    self.btDown.frame = [self getFrame:(widthReal-btBorder)/2 :(heightReal-btBorder) :btBorder :btBorder];
    self.btLeft.frame = [self getFrame:0 :(heightReal-btBorder)/2 :btBorder :btBorder];
    self.btRight.frame = [self getFrame:(widthReal-btBorder) :(heightReal-btBorder)/2 :btBorder :btBorder];
    
    
    top = 0;
    //top += sysTopFix; 这个放到了getFrame里面,getFrameRela没有
    height = 0;
    
    top += height;
    height = 30;
    self.toolBar.frame = [self getFrame:left :top :width :height];
    
    if (1==1) {//计算X轴
        width = 400;
        left = (widthReal-width)/2;
        self.toolCenter.frame = [self getFrameRela:left :0 :width :height];
        
        width = 120;
        left = widthReal-width;
        self.toolRight.frame = [self getFrameRela:left :0 :width :height];
    }
    width = widthReal;
    left = 0;
    
    //空挡
    top += height;
    height = heightReal-30-225-25;
    
    top += height;
    height = 225;
    self.scrollView.frame = [self getFrame:left :top :width :height];
    self.scrollView.contentSize = CGSizeMake(previewWidth*(self.paramsIssue.articleArray.count)+self.paramsIssue.articleArray.count/2*previewSpace, height);
    
    top += height;
    height = 25;
    self.sectionView.frame = [self getFrame:left :top :width :height];
    self.sectionView.contentSize = CGSizeMake(previewWidth*(self.paramsIssue.sectionArray.count), height);
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    //NSLog(@"scrollViewDidZoom %f",self.zoomView.zoomScale);
    
    
        [self switchToolBar];
}

@end
