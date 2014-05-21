//
//  WebController.h
//  epaper
//
//  Created by LegoGreen2 on 2014-03-20.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "ParentController.h"

@interface WebController : ParentController


@property (strong, nonatomic) NSString *webUrl;
@property (strong, nonatomic) UIWebView *webView;

@end
