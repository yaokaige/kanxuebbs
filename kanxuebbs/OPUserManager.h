//
//  OPUserManager.h
//  kanxuebbs
//
//  Created by sgl on 13-6-24.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kOPUserInfoKey  @"OPUserInfo"

@protocol OPUserManagerDelegate;

@interface OPUserManager : NSObject

@property (nonatomic, weak) id<OPUserManagerDelegate>delegate;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *userid;

- (BOOL)isLogin;
- (void)logout;
- (void)login:(NSString *)name passwd:(NSString *)passwd;

+ (id)sharedInstance;

@end

@protocol OPUserManagerDelegate <NSObject>

- (void)userManager:(OPUserManager *)userManager loginSuccess:(NSDictionary *)userInfo;
- (void)userManager:(OPUserManager *)userManager loginFailed:(NSError *)error;

@end
