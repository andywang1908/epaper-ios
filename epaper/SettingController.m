//
//  SettingController.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-18.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "SettingController.h"
#import "LogController.h"
#import<malloc/malloc.h>

@interface SettingController ()

@end

@implementation SettingController

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
    
    self.toolRight = [[UIView alloc] init];
    //self.toolRight.backgroundColor = [UIColor yellowColor];
    [self.toolBar addSubview:self.toolRight];
    
    button = [self getButton:@"index" :@selector(logTap)];
    button.frame = [self getFrameRela:120-40 :0 :30 :30];
    //[self.toolRight addSubview:button];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    
    
}

-(void)logTap {
    LogController *nextController = [[LogController alloc] init];
    //[self.navigationController pushViewController:easyView1 animated:YES];
    [self presentModalViewController:nextController animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *menuSub = self.app.menu[section];
    
    
    return menuSub.count;
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
    
    NSArray * menuSub = self.app.menu[indexPath.section];
    NSString * pubName = menuSub[indexPath.row];
    //[self.pubSwitch setObject:false forKey:pubName];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",menuSub[indexPath.row]];
    
    //這裡要從config賦值
    if ( indexPath.section==1 ) {
        
        if ( indexPath.row==0 ) {
            UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"1", @"2", @"3", nil]];
            segmentedControl.frame = CGRectMake(0, 0, 80, 35);//for ios 6
            [segmentedControl addTarget:self action:@selector(segChanged:) forControlEvents:UIControlEventValueChanged];
            int tmp = [self.app.pubMaxKept intValue];
            //这里的对应逻辑 读出 和写入由setting控制
            segmentedControl.selectedSegmentIndex = (tmp-1);
            //[segmentedControl setSelected:maxKept];
            cell.accessoryView = segmentedControl;
        } else {
            NSString * on = [self.app.pubSwitch objectForKey:pubName];
            
            UISwitch *aSwitch = [[UISwitch alloc] init];
            [aSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = aSwitch;
            if ( [on isEqual:@"N"] ) {
                aSwitch.on = false;
            } else {
                aSwitch.on = true;
            }
            aSwitch.tag = [indexPath row];
        }
        
        //Pub
        
        //[self.pubSwitch addObject:aSwitch];
        
        
        
        //[cell.contentView addSubview:aSwitch];
    } else if ( indexPath.section==0 ) {
        
        if ( indexPath.row==0 ) {
            UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"3", @"5", @"8", nil]];
            segmentedControl.frame = CGRectMake(0, 0, 80, 35);//for ios 6
            [segmentedControl addTarget:self action:@selector(segFavorChanged:) forControlEvents:UIControlEventValueChanged];
            int tmp = [self.app.pubMaxFavor intValue];
            //这里的对应逻辑 读出 和写入由setting控制
            int idx = 0;
            if (tmp==3) {
                idx = 0;
            } else if (tmp==5) {
                idx = 1;
            } else if (tmp==8) {
                idx = 2;
            }
            
            segmentedControl.selectedSegmentIndex = idx;
            //[segmentedControl setSelected:maxKept];
            cell.accessoryView = segmentedControl;
        } else if ( indexPath.row==1 ) {//使用3G
            int on = [self.app.pub3G intValue];
            
            UISwitch *aSwitch = [[UISwitch alloc] init];
            [aSwitch addTarget:self action:@selector(g3Changed:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = aSwitch;
            if ( on==0 ) {
                aSwitch.on = false;
            } else {
                aSwitch.on = true;
            }
            aSwitch.tag = [indexPath row];
        } else if ( indexPath.row==2 ) {//占用
            UILabel *label = [UILabel new];
            label.backgroundColor = [UIColor clearColor];
            label.frame = CGRectMake(0, 0, 80, 50);
            label.textAlignment = UITextAlignmentRight;
            
            
            //+self.app.pubFavor.count
            //ios6 沒有預先下載 但還是有佔用空間的
            label.text = [NSString stringWithFormat:@"%0.1fG  ",0.1*(self.app.pubPre.count+1)];
            
            cell.accessoryView = label;
        } else if ( indexPath.row==3 ) {//剩余空间
            UILabel *label = [UILabel new];
            label.backgroundColor = [UIColor clearColor];
            label.frame = CGRectMake(0, 0, 80, 50);
            label.textAlignment = UITextAlignmentRight;
            
            NSString* path = self.app.local ;
            NSFileManager* fileManager = [[NSFileManager alloc ]init];
            NSDictionary *fileSysAttributes = [fileManager attributesOfFileSystemForPath:path error:nil];
            NSNumber *freeSpace = [fileSysAttributes objectForKey:NSFileSystemFreeSize];
            NSNumber *totalSpace = [fileSysAttributes objectForKey:NSFileSystemSize];
            //NSString  * str= [NSString stringWithFormat:@"已占用%0.1fG/剩余%0.1fG",([totalSpace longLongValue] - [freeSpace longLongValue])/1024.0/1024.0/1024.0,[freeSpace longLongValue]/1024.0/1024.0/1024.0];
            //NSLog(@"--------%@",str);
            
            label.text = [NSString stringWithFormat:@"%0.1fG  ",[freeSpace longLongValue]/1024.0/1024.0/1024.0];
            
            cell.accessoryView = label;
        }
    }
    return cell;
    
    
    /* Now that the cell is configured we return it to the table view so that it can display it */
    
    return cell;
    
}

-(void)g3Changed:(id)sender
{
    UISwitch *view = (UISwitch *)sender;
    NSLog(@"switch to %i",view.on);
    
    //注意这里是写死的第二个
    
    NSString * on;
    if (view.on) {
        self.app.pub3G= [[NSNumber alloc] initWithInt:1];
    } else {
        self.app.pub3G= [[NSNumber alloc] initWithInt:0];
    }
    
    [self.app.defaults setObject:self.app.pub3G forKey:@"pub3G"];//保持到setting
    //[self.app.defaults removeObjectForKey:@"pubSwitch"];
    [self.app.defaults synchronize];
}

-(void)switchChanged:(id)sender
{
    UISwitch *view = (UISwitch *)sender;
    NSLog(@"switch to %i",view.on);
    
    //注意这里是写死的第二个
    NSArray * menuSub = self.app.menu[1];
    NSString * pubName = menuSub[view.tag];
    NSString * on;
    if (view.on) {
        on = @"Y";
    } else {
        on = @"N";
    }
    [self.app.pubSwitch setObject:on forKey:pubName];
    
    [self.app.defaults setObject:self.app.pubSwitch forKey:@"pubSwitch"];//保持到setting
    //[self.app.defaults removeObjectForKey:@"pubSwitch"];
    [self.app.defaults synchronize];
}

-(void)segChanged:(id)sender
{
    UISegmentedControl *view = (UISegmentedControl *)sender;
    //NSLog(@"switch to %i",view.selectedSegmentIndex);
    
    //self.app.defaults;
    
    self.app.pubMaxKept = [[NSNumber alloc] initWithInt:view.selectedSegmentIndex+1];
    [self.app.defaults setObject:self.app.pubMaxKept forKey:@"pubMaxKept"];//保持到setting
    [self.app.defaults synchronize];
}

-(void)segFavorChanged:(id)sender
{
    UISegmentedControl *view = (UISegmentedControl *)sender;
    //NSLog(@"switch to %i",view.selectedSegmentIndex);
    
    //self.app.defaults;
    int idx = view.selectedSegmentIndex;
    int tmp = 3;
    if ( idx==0 ) {
        tmp = 3;
    } else if ( idx==1 ) {
        tmp = 5;
    } else if ( idx==2 ) {
        tmp = 8;
    }
    
    self.app.pubMaxFavor = [[NSNumber alloc] initWithInt:tmp];
    [self.app.defaults setObject:self.app.pubMaxFavor forKey:@"pubMaxFavor"];//保持到setting
    [self.app.defaults synchronize];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //ios 6 沒有預先下載功能
    float sysVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if ( sysVersion<7.0 ) {
        return self.app.menu.count-1;
    }
    return self.app.menu.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section  {
    if ( section==0 ) {
        return @"设置";
    } else {
        return @"预约下载";
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
