//
//  FavorController.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-27.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "FavorController.h"
#import "ArticleController.h"

@interface FavorController ()

@end

@implementation FavorController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


//由parent发起调用
- (void)drawView {
    //这样会把状态条覆盖掉
    //self.view.backgroundColor = [UIColor blackColor];
    
    self.toolBar = [[UIView alloc] init];
    self.toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"titleGrey"]];
    [self.view addSubview:self.toolBar];
    
    UIView *button = [self getButton:@"back" :@selector(btBack)];
    button.frame = [self getFrameRela:10 :0 :30 :30];
    [self.toolBar addSubview:button];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    if ( section==0 ) {
        
        
        return  [[self.app.pubFavor allKeys] count];
        
        
    } else if ( section==1 ) {
        int i = 0;
        
        return  [[self.app.pubPre allKeys] count];
        
    }
    
    return 0;
}
-(void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"clicked");
    
    NSString * fullname ;
    if ( indexPath.section==0 ) {
        
        int i = 0;
        for (id keyInDictionary in [self.app.pubFavor allKeys]){
            id objectForKey = [self.app.pubFavor objectForKey:keyInDictionary];
            //NSLog(@"Key = %@, Object For Key = %@", keyInDictionary, objectForKey);
            if (i==indexPath.row) {
                fullname = [NSString stringWithFormat:@"%@",keyInDictionary];
                break;
            }
            
            i++;
        }
        
        
    } else if ( indexPath.section==1 ) {
        int i = 0;
        for (id keyInDictionary in [self.app.pubPre allKeys]){
            id objectForKey = [self.app.pubPre objectForKey:keyInDictionary];
            //NSLog(@"Key = %@, Object For Key = %@", keyInDictionary, objectForKey);
            if (i==indexPath.row) {
                fullname = [NSString stringWithFormat:@"%@",keyInDictionary];
                break;
            }
            
            i++;
        }
        
    }
    
    //open article
    
    
    
    ///0065_ccp/20021107/0065_ccp20021107-paper.xml
    NSArray* foo = [fullname componentsSeparatedByString: @"/"];
    if ( foo.count==2 ) {
        NSString * code = foo[0];
        
        NSString * date = foo[1];
        
        
        
        NSMutableDictionary *pub;
        for ( int i=0;i<= self.app.params.pubArray.count;i++ ) {
        
            pub = self.app.params.pubArray[i];
            if ( [code isEqualToString:[pub objectForKey:@"code"]] ) {
                break;
            }
        }
        NSMutableDictionary *issue;
        NSMutableArray * array = [pub objectForKey:@"children"];
        for ( int i=0;i<= array.count;i++ ) {
            
            issue = array[i];
            if ( [date isEqualToString:[issue objectForKey:@"date"]] ) {
                break;
            }
        }
        
        
        ArticleController *nextController = [[ArticleController alloc] init];
        
        NSString *fullnameXML = [NSString stringWithFormat:@"%@/%@/%@%@-paper.xml",code,date,code,date];
        
        nextController.pubDic = pub;
        nextController.issueDic = issue;
        nextController.fullname = fullnameXML;//@"0065_ccp/20021103/0065_ccp20021103-paper.xml";
        //[self.navigationController pushViewController:easyView1 animated:YES];
        [self presentModalViewController:nextController animated:YES];
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    
    if (cell == nil) {
        
        /*
         *   Actually create a new cell (with an identifier so that it can be dequeued).
         */
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"settingCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
    }
    
    /*
     *   Now that we have a cell we can configure it to display the data corresponding to
     *   this row/section
     */
    
    //NSArray * menuSub = self.app.menu[indexPath.section];
    //NSString * pubName = menuSub[indexPath.row];
    //[self.pubSwitch setObject:false forKey:pubName];
    
    NSString * fullname;
    
    //收藏
    if ( indexPath.section==0 ) {
        
        int i = 0;
        for (id keyInDictionary in [self.app.pubFavor allKeys]){
            id objectForKey = [self.app.pubFavor objectForKey:keyInDictionary];
            //NSLog(@"Key = %@, Object For Key = %@", keyInDictionary, objectForKey);
            if (i==indexPath.row) {
                
                fullname = keyInDictionary;

                break;
            }
            
            i++;
        }
        
        
    } else if ( indexPath.section==1 ) {
        int i = 0;
        for (id keyInDictionary in [self.app.pubPre allKeys]){
            id objectForKey = [self.app.pubPre objectForKey:keyInDictionary];
            //NSLog(@"Key = %@, Object For Key = %@", keyInDictionary, objectForKey);
            if (i==indexPath.row) {
                
                fullname = keyInDictionary;
                
                break;
            }
            
            i++;
        }
        
    }
    
    
    
    
    NSArray* foo = [fullname componentsSeparatedByString: @"/"];
    if ( foo.count==2 ) {
        NSString * code = foo[0];
        
        NSString * date = foo[1];
        
        
        
        NSMutableDictionary *pub;
        for ( int i=0;i<= self.app.params.pubArray.count;i++ ) {
            
            pub = self.app.params.pubArray[i];
            if ( [code isEqualToString:[pub objectForKey:@"code"]] ) {
                break;
            }
        }
        NSMutableDictionary *issue;
        NSMutableArray * array = [pub objectForKey:@"children"];
        for ( int i=0;i<= array.count;i++ ) {
            
            issue = array[i];
            if ( [date isEqualToString:[issue objectForKey:@"date"]] ) {
                break;
            }
        }
        ;
        
        
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",[pub objectForKey:@"name"],[issue objectForKey:@"display"]];
        
    }
    
    return cell;
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    float sysVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if ( sysVersion<7 ) {
        return self.app.menu.count-1;
    }
    
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section  {
    NSString * re;
    if ( section==0 ) {
        re= @"收藏列表";
        if ( self.app.pubFavor.count==0 ) {
            re = [re stringByAppendingString:@"(空)"];
        }
    } else {
        re= @"預約下載完成";
        if ( self.app.pubPre.count==0 ) {
            re = [re stringByAppendingString:@"(空)"];
        }
    }
    
    return re;
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
    self.tableView.frame = [self getFrame:left :top :width :height];
    
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

@end
