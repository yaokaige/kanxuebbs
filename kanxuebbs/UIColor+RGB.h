//
//  UIColor+RGB.h
//  kanxuebbs
//
//  Created by sgl on 13-7-26.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGB)

+ (id)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;
+ (id)colorWithHex:(NSString *)hex;

@end
