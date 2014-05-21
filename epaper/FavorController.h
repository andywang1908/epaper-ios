//
//  FavorController.h
//  epaper
//
//  Created by LegoGreen2 on 2014-03-27.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "ParentController.h"

@interface FavorController : ParentController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end
