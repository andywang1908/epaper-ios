//
//  AppDelegate.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-07.
//  Copyright (c) 2014 ait. All rights reserved.
//

/*
 However, NSWorkspace can easily move files to the Trash, which NSFileManager can't do.
 
 [[NSWorkspace sharedWorkspace] performFileOperation:NSWorkspaceRecycleOperation source:foldername destination:@"" files:filenamesArray tag:&tag];
 
 */

#import "AppDelegate.h"
#import "PubController.h"
#import "Params.h"
#import "SSZipArchive.h"

@implementation AppDelegate

-(BOOL)shouldSub:(NSString *) filename {
    bool re = false;
    if ( [filename containsString:@"."] || [filename isEqualToString:@"thumbnail"] ) {
    } else {
        re = true;
    }
    return re;
}

//从文件系统出发
//发现目录,检查是否在前3,是则检查是否有zip有就解压缩,否则删除(考虑favor issue情况)
//依赖pub 和 param加载完成
-(void)clearDownload
{
    //N
    NSError * error;
    NSString * filename;
    NSString * str;
    
    NSString * pubPath;
    NSString * pubName;
    NSString * pubNameSwitch;
    NSString * issuePath;
    NSString * issueName;
    NSArray *directorySub;//issueArray
    NSArray *directorySubSub;//jpg
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.local error:&error];
    
    NSMutableDictionary *pubDic;
    NSString *fullname;
    
    if ( !self.pubFavor ) {
        self.pubFavor = [NSMutableDictionary new];
    }
    if ( !self.pubPre ) {
        self.pubPre = [NSMutableDictionary new];
    }
    if ( !self.pubNew ) {
        self.pubNew = [NSMutableDictionary new];
        
        for ( int i=0;i<self.params.pubArray.count;i++ ) {
            //此处线性不安全
            pubDic = self.params.pubArray[i];
            pubName = [pubDic objectForKey:@"code"];
            
            //检查改期刊是否需要下载 in pubSwith
            pubNameSwitch = [self.pubSwitch objectForKey:[pubDic objectForKey:@"name"]];
            if ( pubNameSwitch && [pubNameSwitch isEqualToString:@"Y"] ) {
            } else {
                //不载入
                continue;
            }
            
            
            
            int max = [self.pubMaxKept intValue];
            
            self.params.issueArray = [pubDic objectForKey:@"children"];
            
            //TODO 考虑favor的情况
            for ( int j=0;j<max && j<self.params.issueArray.count;j++ ) {
                fullname = [NSString stringWithFormat:@"%@/%@",pubName, [self.params.issueArray[j] objectForKey:@"date"]];
                [self.pubNew setObject:@"new" forKey:fullname];
            }
            
        }

    }
    
    
    
    
    //这里先解压缩,以免删除了目录后有解压进去,注意创建目录
    pubPath = [self.local stringByAppendingPathComponent:@"thumbnail"];
    directorySub = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pubPath error:&error];
    for (int j = 0; j < (int)[directorySub count]; j++) {
        
        filename = [directorySub objectAtIndex:j];
        issueName = filename;
        NSLog(@"File File %d: %@", (j + 1), filename);
        
        if ( [self shouldSub:filename] ) {
            issuePath = [pubPath stringByAppendingPathComponent:filename];
            directorySubSub = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:issuePath error:&error];
            
            for (int k = 0; k < (int)[directorySubSub count]; k++) {
                
                filename = [directorySubSub objectAtIndex:k];
                NSLog(@"File File File %d: %@", (k + 1), filename);
                
                if ( [filename containsString:@".zip"] ) {
                    fullname = [NSString stringWithFormat:@"thumbnail/%@/%@",issueName,filename];
                    [self upzipFileLocal:fullname from:nil];
                    NSLog(@"try to unzip file %@",fullname);
                    
                }
            }
            
            //检查后,如果不是favor ,如果favor不是放在和pre平级而是在config中,就不用遍历了
            //如果不是favor 不是param 前N个,直接删除
        }
        
    }
    //解压缩后,删除目录
    
    for (int i = 0; i < (int)[directoryContent count]; i++)
    {
        filename = [directoryContent objectAtIndex:i];
        pubName = filename;
        NSLog(@"File %d: %@", (i + 1), filename);
        
        if ( [self shouldSub:filename] ) {
            
            //是目录,今天检查
            pubPath = [self.local stringByAppendingPathComponent:filename];
            directorySub = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pubPath error:&error];
            
            for (int j = 0; j < (int)[directorySub count]; j++) {
                filename = [directorySub objectAtIndex:j];
                issueName = filename;
                
                NSLog(@"File File %d: %@", (j + 1), filename);
                
                if ( [self shouldSub:filename] ) {
                    
                    NSString *fullname = [pubName stringByAppendingPathComponent:issueName];
                    issuePath = [pubPath stringByAppendingPathComponent:filename];
                    
                    /*
                    
                    directorySubSub = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:issuePath error:&error];
                    
                    for (int k = 0; k < (int)[directorySubSub count]; k++) {
                        
                        filename = [directorySubSub objectAtIndex:k];
                        
                        if ( [self shouldSub:filename] ) {
                            NSLog(@"File File File %d: %@", (k + 1), filename);
                        }
                    }*/
                    
                    //不用遍历,耗费资源,直接查找目录或者从config中读取
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    str = [issuePath stringByAppendingPathComponent:@"/Pre"];
                    BOOL isPre = [fileManager fileExistsAtPath:str];
                    
                    fileManager = [NSFileManager defaultManager];
                    str = [issuePath stringByAppendingPathComponent:@"/Favor"];
                    BOOL isFavor = [fileManager fileExistsAtPath:str];
                    if ( isFavor ) {
                        [self.pubFavor setObject:@"favor" forKey:fullname];
                    }
                    
                    BOOL isNew = false;
                    if ([self.pubNew objectForKey:fullname]) {
                        isNew = true;
                    }
                    //依赖params
                    
                    
                    if ( isNew || isFavor) {
                        //文件夹保留
                        if ( isPre ) {
                            //下载完成了
                            //检查是否是favar,同步favor列表,由于这里每次load app都会做,就不保存到config中了
                            //下载完成了
                            [self.pubPre setObject:@"pre" forKey:fullname];
                        }
                    } else {
                        //文件夹删除
                        [self deleteFile:fullname];
                    }
                    
                    
                    
                }
                
            }
        }
        
    }
    
    NSLog(@"pubNew %@",self.pubNew);
    NSLog(@"pubFavor %@",self.pubFavor);
    NSLog(@"pubPre %@",self.pubPre);

}

- (void)redirectNSLogToDocumentFolder
{
    //如果已经连接Xcode调试则不输出到文件
    if(isatty(STDOUT_FILENO) &&1==1) {
        return;
    }
    
    UIDevice *device = [UIDevice currentDevice];
    if([[device model] hasSuffix:@"Simulator"] &&1==1){ //在模拟器不保存到文件中
        return;
    }
    
    //将NSlog打印信息保存到Document目录下的Log文件夹下
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL fileExists = [fileManager fileExistsAtPath:logDirectory];
    if (!fileExists) {
		[fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
	}
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd"]; //每天启动后都保存一个新的日志文件中
    // HH:mm:ss
    self.dateStr = [formatter stringFromDate:[NSDate date]];
    //dateStr = @"2014";
    NSString *logFilePath = [logDirectory stringByAppendingFormat:@"/%@.log",self.dateStr];
    
    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    
    //未捕获的Objective-C异常日志
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
}

void UncaughtExceptionHandler(NSException* exception)
{
    NSString* name = [ exception name ];
    NSString* reason = [ exception reason ];
    NSArray* symbols = [ exception callStackSymbols ]; // 异常发生时的调用栈
    NSMutableString* strSymbols = [ [ NSMutableString alloc ] init ]; //将调用栈拼成输出日志的字符串
    for ( NSString* item in symbols )
    {
        [ strSymbols appendString: item ];
        [ strSymbols appendString: @"\r\n" ];
    }
    
    //将crash日志保存到Document目录下的Log文件夹下
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logDirectory]) {
		[fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
	}
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];// HH:mm:ss
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    //NSString *logFilePath = [logDirectory stringByAppendingPathComponent:@"UncaughtException.log"];
    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.log",dateStr ]];
    //2014
    
    NSString *crashString = [NSString stringWithFormat:@"<- %@ ->[ Uncaught Exception ]\r\nName: %@, Reason: %@\r\n[ Fe Symbols Start ]\r\n%@[ Fe Symbols End ]\r\n\r\n", dateStr, name, reason, strSymbols];
    //把错误日志写到文件中
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [crashString writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }else{
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        [outFile seekToEndOfFile];
        [outFile writeData:[crashString dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile closeFile];
    }
    
    //把错误日志发送到邮箱
    //    NSString *urlStr = [NSString stringWithFormat:@"mailto://test@163.com?subject=bug报告&body=感谢您的配合!<br><br><br>错误详情:<br>%@",crashString ];
    //    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //    [[UIApplication sharedApplication] openURL:url];
}

-(NSString*)convertDate:(NSString *) from {
    NSString * re = from;
    NSDate *date = [dfFrom dateFromString:from];
    if (date) {
        re = [dfTo stringFromDate:date];
    }
    return re;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    dfFrom = [[NSDateFormatter alloc] init];
    //[formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dfFrom setDateFormat:@"yyyyMMdd"];
    dfTo = [[NSDateFormatter alloc] init];
    [dfTo setDateFormat:@"yyyy-MM-dd"];
    
    //管理日志
    //[self redirectNSLogToDocumentFolder];
    
    /*
    NSString * zipPath = @"/Users/legogreen2/Library/Application Support/iPhone Simulator/7.0.3/Applications/DB1D97FC-8F72-40D5-AFD4-805324969F8A/Documents/thumbnail/0065_ccp/0065_ccp_20021107.zip";
    NSString * destinationPath = @"/Users/legogreen2/Library/Application Support/iPhone Simulator/7.0.3/Applications/DB1D97FC-8F72-40D5-AFD4-805324969F8A/Documents/0065_ccp/20021107";
    [self listFileAtPath:destinationPath];
    [self listFileAtPath:@"/Users/legogreen2/Library/Application Support/iPhone Simulator/7.0.3/Applications/DB1D97FC-8F72-40D5-AFD4-805324969F8A/Documents/thumbnail/0065_ccp"];
    
    NSString *yourPath = @"/Users/legogreen2/Library/Application Support/iPhone Simulator/7.0.3/Applications/DB1D97FC-8F72-40D5-AFD4-805324969F8A/Documents/thumbnail/0065_ccp/0065_ccp_20021107.zip";
    NSFileManager *man = [NSFileManager defaultManager];
    NSDictionary *attrs = [man attributesOfItemAtPath: yourPath error: NULL];
    //UInt32 result = ;
    NSLog(@"size %l",[attrs fileSize]);
    
    //[self listFileAtPath:zipPath];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:zipPath] && [[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        [self notificate:[NSString stringWithFormat:@"zip from %@",zipPath]];
        [self notificate:[NSString stringWithFormat:@"zip to %@",destinationPath]];
        bool zipOk = [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath];
        if ( zipOk ) {
            [self notificate:[NSString stringWithFormat:@"zip success"]];
        } else {
            [self notificate:[NSString stringWithFormat:@"zip fail"]];
        }
    }
    [self listFileAtPath:destinationPath];*/
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.domain = @"http://epaper.pages.dushi.ca/";
    
    //self.session = [self backgroundSession];
    
    sysVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (sysVersion>=7) {
        NSTimeInterval theTimeInterval = 60*15;
        //UIApplicationBackgroundFetchIntervalMinimum
        [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    }
    
    //NSLibraryDirectory NSDocumentDirectory NSCachesDirectory NSApplicationSupportDirectory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,NSUserDomainMask, YES);
    self.local = [paths objectAtIndex:0];
    self.local = [self.local stringByAppendingPathComponent:@"MyData"];
    
    
    NSString *directory = self.local;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:directory] == NO) {
        NSError *error;
        if ([fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error] == NO) {
            NSLog(@"Error: Unable to create directory: %@", error);
        }
        
        NSURL *url = [NSURL fileURLWithPath:directory];
        // exclude downloads from iCloud backup
        if ([url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error] == NO) {
            NSLog(@"Error: Unable to exclude directory from backup: %@", error);
        }
    }
    
    
    
    
    PubController  *mainController = [[PubController alloc] init];
    [self.window setRootViewController:mainController];
    
    //解析本地xml,储存pub和issue级别的数据
    self.params = [Params new];
    self.params.controller = mainController;//充当util用
    [self.params start];
    //NSLog(@"params %@",self.params.pubArray);
    
    
    
    //setting
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.defaultZips = [NSMutableDictionary new];
    
    self.pubSwitch = [[self.defaults objectForKey:@"pubSwitch"] mutableCopy];
    if ( !self.pubSwitch ) {
        self.pubSwitch = [NSMutableDictionary new];
    }
    //修正里面的子项目,将修正的逻辑集中在此处
    for (int i=0;i<self.params.pubArray.count;i++) {
        //注意,这里用到是name,因为设置用的是name
        NSString * pubName = [self.params.pubArray[i] objectForKey:@"name"];
        NSString * on = [self.pubSwitch objectForKey:pubName];
        if ( !on ) {
            on = @"Y";//没有赋值过就是开
            [self.pubSwitch setObject:on forKey:pubName];
        }
    }
    //表示 1.业务上面的数值  2.setting的第几项   应该用1,否则业务多处调用的时候无法管理
    self.pubMaxKept = [self.defaults objectForKey:@"pubMaxKept" ];
    if ( !self.pubMaxKept ) {
        self.pubMaxKept = [[NSNumber alloc] initWithInt:2];
    }
    self.pubMaxFavor = [self.defaults objectForKey:@"pubMaxFavor" ];
    if ( !self.pubMaxFavor ) {
        self.pubMaxFavor = [[NSNumber alloc] initWithInt:5];
    }
    self.pub3G = [self.defaults objectForKey:@"pub3G" ];
    if ( !self.pub3G ) {
        self.pub3G = [[NSNumber alloc] initWithInt:0];
    }
    //默认值是个修正的过程,修改了就要保存,这里不保存了,不影响使用
    
    
    //preload 的复制和解压缩   注意cache的删除,zip的删除
    /* 下面是将 下载copy完成后的数值记录下来,这时候来解压缩
     self.defaultZips = [[self.defaults objectForKey:@"defaultZips" ] mutableCopy];
     
     //NSLog( @"download list %@",self.defaultZips );
     
     
     NSURL * location;
     for( NSString *aKey in [self.defaultZips allKeys] )
     {
     //aKey = fullanme;
     location = [[NSURL alloc] initWithString: [self.defaultZips objectForKey:aKey]];
     
     [self upzipFileLocal:aKey from:nil];//location
     
     [self.defaultZips removeObjectForKey:aKey];
     }
     
     [self.defaults setObject:self.defaultZips forKey:@"defaultZips"];//保持到setting
     [self.defaults synchronize];*/
    
    //拿到param和setting之后可以进行清理
    
    
    [self clearDownload];
    [self preDownLoad];
    
    //[[NSDictionary alloc] initWithObjectsAndKeys: @"", @"收藏", @"", @"设置", nil]
    /*
     self.menu = @{@"设置": @[@"",@""]
     , @"收藏": @""};*/
    //setting menu data
    
    NSMutableArray *pubArray = [NSMutableArray new ];
    [pubArray addObject:@"預約下載期數上限"];
    NSString * pubName = @"";
    for ( int i=0;i<self.params.pubArray.count;i++ ) {
        pubName = [self.params.pubArray[i] objectForKey:@"name"];
        [pubArray addObject:pubName];
    }
    
    self.menu = @[ @[@"收藏期數上限",@"允許使用流動網絡下載多媒體內容",@"佔用空間",@"剩餘空間"],pubArray ];
    
    //
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"fetch called");
    [self preDownLoad];
    
    //TODO 干嘛的
    completionHandler(UIBackgroundFetchResultNewData);
    //completionHandler(UIBackgroundFetchResultNoData);
    //completionHandler(UIBackgroundFetchResultFailed);
    //completionHandler(UIBackgroundFetchResultFailed);
}


-(void)saveFileLocal:(NSData *) data :(NSString *) fullname {
    if ( !fullname ) {
        return;//这里会导致死循环
    }
    NSString *localPath=[self.local stringByAppendingPathComponent:fullname];
    
    NSArray* foo = [fullname componentsSeparatedByString: @"/"];
    NSString * dicName = @"";
    for (int i=0;i<foo.count-1;i++) {
        if ([foo[i] isEqual:@""]) {
            
        } else {
            //   /thumbnail /thumbnail/0065_ccp
            dicName = [NSString stringWithFormat:@"%@/%@",dicName,foo[i]];
            //创建目录
            
            NSString *dataPath = [self.local stringByAppendingPathComponent:dicName];
            
            if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
                [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
            }
        }
    }
    
    bool finished = [data writeToFile:localPath atomically:YES];
    if ( finished ) {
        NSLog(@"%@ is saved",fullname);
        [self notificate:[NSString stringWithFormat:@"%@ is saved",fullname]];
    }
    
}
-(NSData *)getFileRemote:(NSString*) fullname
{
    NSData * re;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.domain,fullname ]];
    
    if (url) {
        re = [NSData dataWithContentsOfURL:url];
    }
    
    return re;
}
-(NSData *)getFileLocal:(NSString*) fullname
{
    NSData * re;
    NSString *localPath=[self.local stringByAppendingPathComponent:fullname];
    re = [NSData dataWithContentsOfFile:localPath];
    return re;
}

-(NSArray *)listFileAtPath:(NSString *)path
{
    //-----> LIST ALL FILES <-----//
    NSLog(@"LISTING ALL FILES FOUND");
    
    int count;
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    for (count = 0; count < (int)[directoryContent count]; count++)
    {
        NSLog(@"File %d: %@", (count + 1), [directoryContent objectAtIndex:count]);
    }
    return directoryContent;
}

//远处为准,本地缓存容错
//检查,容错交给background task,这里只负责解压缩和检查创建目录
-(NSData *)upzipFileLocal:(NSString *)fullname from:(NSURL *) zipfile
{
    NSData * re;
    
    if (zipfile) {
        re = [NSData dataWithContentsOfURL:zipfile];
    } else {
        re = [self getFileLocal:fullname];
    }
    
    if (!re) {
        return nil;
    }
    
    /*
    if ( re ) {//本地存在
    } else {//试图从远端获取
        re = [self getFileRemote:fullname];
        
        [self saveFileLocal:re :fullname];
    }*/
    
    
    //thumbnail/0065_ccp/0065_ccp_20021105.zip
    //0065_ccp/20021103/HouseAd/A_FP.jpg
    
    
    //NSString *localPath=[self.local stringByAppendingPathComponent:fullname];
    
    NSArray* foo = [fullname componentsSeparatedByString: @"/"];
    NSString * checkDic;
    if ( foo.count==3 ) {
        NSString * code = foo[1];
        int from = code.length+1;
        NSString * date = [foo[2] substringFromIndex:from];
        date = [date substringToIndex:8];
        
        //创建目录
        NSString * dicName = [NSString stringWithFormat:@"%@",code];
        NSString * dataPath = [self.local stringByAppendingPathComponent:dicName];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        dicName = [NSString stringWithFormat:@"%@/%@",code,date];
        dataPath = [self.local stringByAppendingPathComponent:dicName];
        checkDic = dataPath;
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        //表示已经preload过了
        dicName = [NSString stringWithFormat:@"%@/%@/Pre",code,date];
        dataPath = [self.local stringByAppendingPathComponent:dicName];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        dicName = [NSString stringWithFormat:@"%@/%@",code,date];
        dataPath = [self.local stringByAppendingPathComponent:dicName];
        
        
        //NSString *fullname = [NSString stringWithFormat:@"%@/%@/%@%@-paper.xml",code,date,code,date];
        if ( re ) {//并且没有解压过
            //解压缩
            
            
            NSLog(@"%@ has been downloaded",fullname);
            
            
            NSString *localPath=[self.local stringByAppendingPathComponent:fullname];
            NSString *zipPath = localPath;
            NSString *destinationPath = dataPath;
            
            NSError * error;
            
            //走的走台任务模式,这里需要copy
            if ( zipfile ) {//从cache中拿zip
                
                //删除老的文件,避免因为上次下载的文件不正确,却无法更新,以及垃圾文件的处理
                //暫時不刪除,保證可以離線瀏覽
                [self deleteFile:fullname];
                
                [self notificate:@"write zip to local from cache0"];
                //截取file://   这个不用考虑了
                //zipPath = [[zipfile absoluteString] substringFromIndex:7];
                
                //将data写入 localPath
                if (1==1) {
                    //NSString *localPath=[self.local stringByAppendingPathComponent:fullname];
                    //[NSString stringWithFormat:@"file://%@/aaa.zip", localPath]
                    NSString * localURL = [localPath stringByReplacingOccurrencesOfString: @" " withString:@"%20"];
                    NSURL * destination = [[NSURL alloc] initWithString: [NSString stringWithFormat:@"file://%@",localURL]];
                    
                    [self notificate: [NSString stringWithFormat:@"write zip to local from cache0 %i %@ %i %@",(zipfile==nil),zipfile,(destination==nil),destination]];
                    
                    bool writeIn = [[NSFileManager defaultManager] copyItemAtURL:zipfile toURL:destination error:&error];
                    if ( writeIn ) {
                        NSLog(@"file copy success");
                    } else {
                        NSLog(@"file copy error:%@",error);
                    }
                } else {
                    [re writeToFile:zipPath atomically:true];
                }
                
                [self notificate:@"write zip to local from cache"];
            }
            
            
            [self notificate:@"zip from0"];
            NSLog(@"zip from %@ to %@",zipPath,destinationPath);
            if ([[NSFileManager defaultManager] fileExistsAtPath:zipPath]) {
                bool zipOk = [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath];
                if ( zipOk ) {
                    [self notificate:[NSString stringWithFormat:@"zip success"]];
                    //[self listFileAtPath:checkDic];
                    //更新pubPre
                    [self.pubPre setObject:@"pre" forKey:dicName];
                } else {
                    [self notificate:[NSString stringWithFormat:@"zip fail"]];
                }
            } else {
                [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath];
            }
            
            
            
        }

    }
    
    //解压缩后删除
    [self deleteFile:fullname];
    NSLog(@"delete zip file %@ after unzip",fullname);
    
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


//本地为准,远处缓存容错
-(void)deleteFile:(NSString *)fullname
{
    NSError *error;
    NSString *localPath=[self.local stringByAppendingPathComponent:fullname];
    
    //删除老的文件,避免因为上次下载的文件不正确,却无法更新,以及垃圾文件的处理
    if ([[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
        BOOL success = [[NSFileManager defaultManager] removeItemAtPath:localPath error:&error];
        if (success) {
            NSLog(@"delete file success ");
        }
        else
        {
            NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
        }
    } else {
        NSLog(@"There is no old file to delete");
    }
}


//在fetch的时候call,考虑放在第一次运行程序的时候
//不能依赖 clear来产生 pubNew,pubNew不一定有数据,算法到时可以共享出来
//最好放到clear之后
//由此param已经存在可以断定,app其实是call起来了  pubNew也是有数据的
//?? 不需要判斷版本?
-(void)preDownLoad
{
    int count = self.params.pubArray.count;
    NSMutableDictionary *pub;
    NSMutableDictionary *issue;
    NSMutableArray *issueArray;
    NSString * fullname;
    NSString * tmp;
    NSString * code;
    NSString * date;
    NSString * dicName;
    NSString * pubNameSwitch;
    
    int max = [self.pubMaxKept intValue];
    //这里遍历 pubNew就可以了  pubNew还会用来删除老的文件
    for (int i=0;i<count && i<100;i++) {//先调试一个
        //根據 self.pubSwitch 判斷是否需要預先下載
        pub = self.params.pubArray[i];
        pubNameSwitch = [self.pubSwitch objectForKey:[pub objectForKey:@"name"]];
        if ( pubNameSwitch && [pubNameSwitch isEqualToString:@"Y"] ) {
        } else {
            //不载入
            continue;
        }
        
        code = [pub objectForKey:@"code"];
        issueArray = [pub objectForKey:@"children"];
        
        for ( int j=0;j<issueArray.count && j<max;j++ ) {
            issue = issueArray[j];
            date = [issue objectForKey:@"date"];
            dicName = [NSString stringWithFormat:@"%@/%@",code,date];
            fullname = [issue objectForKey:@"zip"];
            
            if (fullname) {
                //下載zip
                NSData * re = [self getFileLocal:fullname];
                //TODO 如果在下载完成列表中了 就不要下载了
                //从self.pubPre,注意self.pubPre的更新
                //问题 增加任务第一次,但是还没有下载完成,又增加一次,这个问题貌似由session可以控制
                
                tmp = [self.pubPre objectForKey:dicName];
                //zip解压缩中断的情况不在这里处理,太费时了,不过可以优化下,不再下载,等app解压
                if ( tmp || re ) {//本地存在 不再下载
                    continue;
                } else {//试图从远端获取
                    NSURLSessionDownloadTask *downloadTask;
                    
                    NSString * DownloadURLString =  [NSString stringWithFormat:@"%@%@",self.domain,fullname];
                    //DownloadURLString = @"http://s420225015.onlinehome.us/apps-bastillepost/size0.zip";
                    NSURL *downloadURL = [NSURL URLWithString:DownloadURLString];
                    NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];
                    //TODO 检查目标文件的唯一性和删除(路径)
                    //self.session = [NSURLSession sharedSession];
                    self.session = [self backgroundSession];
                    downloadTask = [self.session downloadTaskWithRequest:request];
                    if ( !downloadTask ) {
                        [self notificate:@"downloadTask can not get called"];
                        
                    } else {
                        
                        [self notificate:@"downloadTask can get called"];
                        
                        
                        /*
                         downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                         
                         NSLog(@"handle success from task %@",location);
                         }];*/
                        
                        downloadTask.taskDescription = fullname;
                        
                        
                        [downloadTask resume];
                        NSLog(@"background(%@) downlaod begin,wait....",fullname);
                    }
                }
                
                
                
            }
        }
        
    }
    
}

-(void) notificate:(NSString*) msg {
    NSLog(msg);
    return;
    
    //local notification
    //notification.repeatInterval = NSDayCalendarUnit;
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        //NSLog(@">> fetch get called");
        NSDate *now=[NSDate new];
        notification.fireDate=now;//[now addTimeInterval:1];
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.alertBody=msg;
        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
    }
}

- (NSURLSession *)backgroundSession
{
    //Use dispatch_once_t to create only one background session. If you want more than one session, do with different identifier
    /**/
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //注意,这里发布的时候要改
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfiguration:@"com.ccuecmi.epaper.ent.BackgroundSession"];
        configuration.timeoutIntervalForRequest = 60*120;
        configuration.timeoutIntervalForResource = 60*120;
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
     });
    return session;
    
    /*
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfiguration:@"com.ccuecmi.epaper.ent.BackgroundSession"];
    configuration.timeoutIntervalForResource = 60*200;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    return session;*/
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier
  completionHandler:(void (^)())completionHandler
{
    //Check if all transfers are done, and update UI
    //Then tell system background transfer over, so it can take new snapshot to show in App Switcher
    NSLog(@"handle success from app");
    //completionHandler();
    
    //You can also pop up a local notification to remind the user
    //...
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    //[self notificate:@"download finish"];
    
    //[self listFileAtPath:@"/Users/legogreen2/Library/Application Support/iPhone Simulator/7.0.3/Applications/F5A85A7A-2013-4402-A78A-3ACD1287B106/Library/Caches/com.apple.nsnetworkd/"];
    
    NSLog(@"%@ is finished in %@",downloadTask.taskDescription,location);
    
    NSString *fullname = downloadTask.taskDescription;
    
    //这里必须把临时文件写到document
    //if ( [[NSFileManager defaultManager] isReadableFileAtPath:source] )
    /*
    NSString *localPath=[self.local stringByAppendingPathComponent:fullname];
    NSURL * destination = [[NSURL alloc] initWithString:localPath];
    NSError * error;
    [[NSFileManager defaultManager] copyItemAtURL:location toURL:destination error:&error];
    NSLog(@"file copy error:%@",error);
    
    
    self.defaultZips = [[self.defaults objectForKey:@"defaultZips" ] mutableCopy];
    if ( !self.defaultZips ) {
        self.defaultZips = [NSMutableDictionary new];
    }
    [self.defaultZips setObject:location.absoluteString forKey:fullname];
    
    [self.defaults setObject:self.defaultZips forKey:@"defaultZips"];//保持到setting
    [self.defaults synchronize];
     
     */
    
    //这里要复制和解压缩,时间不够,将location的路径保存起来
    //app启动的时候用
    if (1==2) {
        //-(void)saveFileLocal:(NSData *) data :(NSString *) fullname
        
        NSData * re;
        
        re = [NSData dataWithContentsOfURL:location];
        [self saveFileLocal:re :fullname];
    } else {
        [self upzipFileLocal:fullname from:location];
    }
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    if ( !error ) {
        return;
    }
    
    [self notificate:[NSString stringWithFormat:@"%@ download fail for %@",task,error]];
    
    NSLog(@"%@ is fail because of %@",task,error);
}

@end
