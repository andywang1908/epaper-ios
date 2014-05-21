//
//  CollectionIssue.h
//  epaper
//
//  Created by LegoGreen2 on 2014-03-13.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentController.h"

@interface CollectionIssue : UICollectionView

@property (strong, nonatomic) NSNumber *fromNo;
@property (strong, nonatomic) NSNumber *toNo;
@property (strong, nonatomic) ParentController *controller;


- (id)initWithFrame:(CGRect)frame;
@end
