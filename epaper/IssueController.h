//
//  IssueController.h
//  epaper
//
//  Created by LegoGreen2 on 2014-03-07.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "ParentController.h"

@interface IssueController : ParentController<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray * keep;
@property (strong, nonatomic) NSMutableDictionary *pub;

@property (strong, nonatomic) NSMutableArray * articleArray;
@property (strong, nonatomic) NSMutableArray * monthArray;

@property (strong, nonatomic) UIView * tipView;
@property (strong, nonatomic) UISlider * slider;
@property (strong, nonatomic) UILabel * sliderLabel;



@end
