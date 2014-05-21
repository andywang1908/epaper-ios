//
//  NSString+AitString.h
//  epaper
//
//  Created by LegoGreen2 on 2014-03-26.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AitString)

- (BOOL)containsString:(NSString *)string;
- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions)options;
@end
