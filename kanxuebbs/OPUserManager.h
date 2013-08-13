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

/*! 
 *  通过判断token是否为空来确认用户是否登录。
 *
 *  @return 用户是否登录
 */
- (BOOL)isLogin;

/*!
 *  用户登出，调用kOPUserLogout
 */
- (void)logout;

/*!
 *  用户登录
 *
 *	@param 	name 	用户名
 *  @param 	passwd 	密码
 */
- (void)login:(NSString *)name passwd:(NSString *)passwd;

- (void)getSecurityToken;

+ (id)sharedInstance;

@end

@protocol OPUserManagerDelegate <NSObject>

- (void)userManager:(OPUserManager *)userManager loginSuccess:(NSDictionary *)userInfo;
- (void)userManager:(OPUserManager *)userManager loginFailed:(NSError *)error;

@end
