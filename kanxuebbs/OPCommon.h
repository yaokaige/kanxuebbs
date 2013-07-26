//
//  OPCommon.h
//
//  Created by sgl on 12-3-12.
//  Copyright (c) 2012年 sgl. All rights reserved.
//

#ifndef OPCommon_h
#define OPCommon_h

#define OPErrorDomain   @"com.sunix.app"

#ifdef DEBUG
    #define OPLog(xx, ...)          NSLog(@"(%s)(line=%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
    #define OPLogMethodName()       NSLog(@"(%s)(line=%d): ", __PRETTY_FUNCTION__, __LINE__)
    #define OPSimpleLog(xx, ...)    NSLog(@xx, ##__VA_ARGS__)
#else
    #define OPLog(xx, ...)          ((void)0)
    #define OPLogMethodName()       ((void)0)
    #define OPSimpleLog(xx, ...)    ((void)0)
#endif

#define OPLogErr(xx, ...)      NSLog(@"[%s](line=%d)(%s): " xx, __FILE__, __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__)

#define OPGetViewFrameX(xx) xx.frame.origin.x
#define OPGetViewFrameY(xx) xx.frame.origin.y
#define OPGetViewFrameWidth(xx) xx.frame.size.width
#define OPGetViewFrameHeight(xx) xx.frame.size.height

#define OPGetControllerFrameX(xx) xx.view.frame.origin.x
#define OPGetControllerFrameY(xx) xx.view.frame.origin.y
#define OPGetControllerFrameWidth(xx) xx.view.frame.size.width
#define OPGetControllerFrameHeight(xx) xx.view.frame.size.height

#endif
