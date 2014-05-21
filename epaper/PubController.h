//
//  PubController.h
//  epaper
//
//  Created by LegoGreen2 on 2014-03-07.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "ParentController.h"
#import "NSString+AitString.h"

@interface PubController : ParentController{
    
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray * keep;

@property (strong, nonatomic) UIView *toBar;
@property (strong, nonatomic) UIView *btSetting;

@end
