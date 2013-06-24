//
//  OPGlobalURL.m
//
//  Created by sgl on 13-5-25.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import "OPGlobalURL.h"

@implementation OPGlobalURL

- (id)init
{
    self = [super init];
    if (self) {
        [self defaultURLS];
    }
    return self;
}

- (void)defaultURLS
{
    self.urls = @{kOPSecurityToken : @"http://bbs.pediy.com/getsecuritytoken.php?styleid=12",
                  kOPUserLogin     : @"http://bbs.pediy.com/login.php??do=login&styleid=12",
                  kOPUserLogout    : @"http://bbs.pediy.com/login.php??do=logout&logouthash=%@&styleid=12",
                  kOPUserInfo      : @"http://bbs.pediy.com/member.php?u=%@&styleid=12",
                  kOPBoardList     : @"http://bbs.pediy.com/index.php?styleid=12",
                  kOPThreadList    : @"http://bbs.pediy.com/forumdisplay.php?f=%d?styleid=12",
                  kOPThreadPost    : @"http://bbs.pediy.com/showthread.php?t=%d?styleid=12",
                  kOPNewThread     : @"http://bbs.peidy.com/newthread.php?styleid=12",
                  kOPNewReply      : @"http://bbs.pediy.com/newreply.php?styleid=12",
                  kOPBoardStatus   : @"http://bbs.pediy.com/forumdisplay.php?f=%d&getnewpost=%d&styleid=12",
                  kOPThreadStatus  : @"http://bbs.pediy.com/showthread.php?t=%d&styleid=12&getnewpost=%d",
                  kOPUserAvstar    : @"http://bbs.pediy.com/image.php?u=%@",
                  kOPAttachment    : @"http://bbs.pediy.com/attachment.php?attachmentid=%@&thumb=1&styleid=12",
                  kOPPostDetail    : @"http://bbs.pediy.com/showpost.php?styleid=12&p=%@"
                  };
}

+ (id)sharedInstance
{
    static OPGlobalURL *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[OPGlobalURL alloc] init];
        // Do your init.
    });
    return sharedInstance;
}

+ (NSString *)URLForKey:(NSString *)key
{
    OPGlobalURL *urlHandle = [OPGlobalURL sharedInstance];
    return [urlHandle.urls objectForKey:key];
}

@end
