//
//  UIColor+RGB.m
//  kanxuebbs
//
//  Created by sgl on 13-7-26.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import "UIColor+RGB.h"

@implementation UIColor (RGB)

+ (id)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha
{
    NSAssert(7 == hex.length, @"Hex color format error!");
    
    unsigned color = 0;
    NSScanner *hexValueScanner = [NSScanner scannerWithString:[hex substringFromIndex:1]];
    [hexValueScanner scanHexInt:&color];

    int blue = color & 0xFF;
    int green = (color >> 8) & 0xFF;
    int red = (color >> 16) & 0xFF;
        
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

+ (id)colorWithHex:(NSString *)hex
{
    return [[self class] colorWithHex:hex alpha:1.0];
}

@end
