//
//  OPUserManager.m
//  kanxuebbs
//
//  Created by sgl on 13-6-24.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import "OPUserManager.h"
#import "OPBBSInterface.h"
#import "JSONKit.h"

@implementation OPUserManager

- (id)init
{
    self = [super init];
    if (self) {
        id dict = [[NSUserDefaults standardUserDefaults] objectForKey:kOPUserInfoKey];
        if (dict != nil && dict != [NSNull null]) {
            [self loadUserInfo:dict];
        }
    }
    return self;
}

- (BOOL)isLogin
{
    if (self.token == nil || self.token.length == 0) {
        return NO;
    }
    return YES;
}

- (void)logout
{
    self.token = nil;
    self.username = nil;
    self.avatar = nil;
    self.email = nil;
    self.userid = nil;
    
    // 覆盖已存储的用户信息
    [self saveUserInfo:[NSNull null]];
}

- (void)login:(NSString *)name passwd:(NSString *)passwd
{
    [OPBBSInterface login:name passwd:passwd result:^(id data, NSError *err) {
        if (err == nil) {
            id json = [data objectFromJSONData];
            [self checkResult:json];
        }
        else {
            OPLogErr(@"error: %@", err);
            [_delegate userManager:self loginFailed:err];
        }
    }];
}

- (void)checkResult:(NSDictionary *)dict
{
    id result = [dict objectForKeyNotNull:@"result"];
    NSString *msg = nil;
    if (result == nil) {
        msg = @"Result data format error.";
    }
    else {
        if (0 == [result intValue]) {
            [self saveUserInfo:(NSDictionary *)dict];
            [_delegate userManager:self loginSuccess:dict];
        }
        else if (1 == [result intValue]) {
            msg = [NSString stringWithFormat:@"密码错误，还剩%@次尝试机会。", [dict objectForKeyNotNull:@"strikes"]];
        }
        else {
            msg = @"Unknown error.";
        }
    }
    
    if (msg != nil) {
        NSError *e = [NSError errorWithDomain:OPErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey: msg, NSLocalizedFailureReasonErrorKey: msg}];
        [_delegate userManager:self loginFailed:e];
    }
}

- (void)saveUserInfo:(id)dict
{
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:kOPUserInfoKey];
    if (dict != [NSNull null]) {
        [self loadUserInfo:dict];
    }
}

- (void)loadUserInfo:(NSDictionary *)dict
{
    self.token = [dict objectForKeyNotNull:@"securitytoken"];
    self.username = [dict objectForKeyNotNull:@"securitytoken"];
    self.email = [dict objectForKeyNotNull:@"email"];
    self.userid = [dict objectForKeyNotNull:@"userid"];
    if (1 == [[dict objectForKeyNotNull:@"isavatar"] intValue]) {
        self.avatar = [NSString stringWithFormat:[OPGlobalURL URLForKey:kOPUserAvatar], _userid];
    }
    else {
        self.avatar = nil;
    }
    self.username = [dict objectForKeyNotNull:@"securitytoken"];
}

- (void)getSecurityToken
{
    // TODO: 登录接口会返回securitytoken，每次重新启动app还需要通过getsecuritytoken.php接口重新获得securitytoken
}

+ (id)sharedInstance
{
    static OPUserManager *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[OPUserManager alloc] init];
        // Do your init.
    });
    return sharedInstance;
}

@end
