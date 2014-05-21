//
//  NSString+AitString.m
//  epaper
//
//  Created by LegoGreen2 on 2014-03-26.
//  Copyright (c) 2014 ait. All rights reserved.
//

#import "NSString+AitString.h"

@implementation NSString (AitString)

- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions)options {
    NSRange rng = [self rangeOfString:string options:options];
    return rng.location != NSNotFound;
}

- (BOOL)containsString:(NSString *)string {
    return [self containsString:string options:0];
}

@end
