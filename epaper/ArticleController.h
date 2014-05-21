//
//  ArticleController.h
//  epaper
//
//  Created by LegoGreen2 on 2014-03-07.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "ParentController.h"

#import "ParamsIssue.h"
#import "Reachability.h"

@interface ArticleController : ParentController<UIScrollViewDelegate> {
    NSMutableDictionary * articleDic;
    bool threadStop;
    
    int previewWidth;
    int previewSpace;
    int currentNo;
}



@property (strong, nonatomic) UIScrollView *zoomView;
@property (strong, nonatomic) UIView *zoomGroup;
@property (strong, nonatomic) UIImageView *leftView;
@property (strong, nonatomic) UIImageView *rightView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIView *btUp;
@property (strong, nonatomic) UIView *btLeft;
@property (strong, nonatomic) UIView *btRight;
@property (strong, nonatomic) UIView *btDown;

@property (strong, nonatomic) UIScrollView *scrollView;//preview
@property (strong, nonatomic) UIScrollView *sectionView;
@property (strong, nonatomic) NSMutableArray * keep;
@property (strong, nonatomic) NSMutableArray * previewImage;

@property (strong, nonatomic) NSMutableDictionary * pubDic;
@property (strong, nonatomic) NSMutableDictionary * issueDic;
@property (strong, nonatomic) NSString* fullname;// for params init in this level
@property (strong, nonatomic) ParamsIssue *paramsIssue;


@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) UIView *spinnerLayer;
@property (strong, nonatomic) UILabel *spinnerLabel;

@property (strong, nonatomic) UILabel *floatAlert;

@property (strong, nonatomic) Reachability * reach;



@end

