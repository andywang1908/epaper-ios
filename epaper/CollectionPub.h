//
//  CollectionPub.h
//  epaper
//
//  Created by LegoGreen2 on 2014-03-12.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParentController.h"

//UICollectionViewDelegateFlowLayout
@interface CollectionPub : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) NSNumber *fromNo;
@property (strong, nonatomic) NSNumber *toNo;
@property (strong, nonatomic) ParentController *controller;


- (id)initWithFrame:(CGRect)frame;
@end
