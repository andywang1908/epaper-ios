//
//  SettingController.h
//  epaper
//
//  Created by LegoGreen2 on 2014-03-18.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "ParentController.h"

@interface SettingController : ParentController<UITableViewDataSource,UITableViewDelegate> {

}

@property (strong, nonatomic) UITableView *tableView;

@end
