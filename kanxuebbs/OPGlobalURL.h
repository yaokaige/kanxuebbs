//
//  OPGlobalURL.h
//
//  Created by sgl on 13-5-25.
//  Copyright (c) 2013年 sgl. All rights reserved.
//
//  Ref: http://bbs.pediy.com/showthread.php?t=163280

#import <Foundation/Foundation.h>

#define kOPSecurityToken        @"OPSecurityToken"
#define kOPUserLogin            @"OPUserLogin"
#define kOPUserLogout           @"OPUserLogout"
#define kOPUserInfo             @"OPUserInfo"
#define kOPBoardList            @"OPBoardList"
#define kOPThreadList           @"OPThreadList"
#define kOPThreadPost           @"OPThreadPost"
#define kOPNewThread            @"OPNewThread"
#define kOPNewReply             @"OPNewReply"
#define kOPBoardStatus          @"OPBoardStatus"
#define kOPThreadStatus         @"OPThreadStatus"
#define kOPUserAvstar           @"OPUserAvstar"
#define kOPAttachment           @"OPAttachment"
#define kOPPostDetail           @"OPPostDetail" 

@interface OPGlobalURL : NSObject
@property (nonatomic, strong) NSDictionary *urls;

+ (id)sharedInstance;
+ (NSString *)URLForKey:(NSString *)key;

@end
