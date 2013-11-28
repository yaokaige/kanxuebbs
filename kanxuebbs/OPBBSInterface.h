//
//  OPBBSInterface.h
//  kanxuebbs
//
//  Created by sgl on 13-6-24.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OPGlobalURL.h"
#import <AFNetworking.h>

typedef void(^OPResultBlock)(id data, NSError *err);

@interface OPBBSInterface : NSObject

+ (void)bbsGetData:(NSString *)url result:(OPResultBlock)resultBlock;
+ (void)bbsGetJSON:(NSString *)url result:(OPResultBlock)resultBlock;
+ (void)bbsPostData:(NSString *)host path:(NSString *)path params:(NSDictionary *)params result:(OPResultBlock)resultBlock;

+ (void)login:(NSString *)name passwd:(NSString *)passwd result:(OPResultBlock)resultBlock;
+ (void)getSecurityToken:(OPResultBlock)resultBlock;
+ (void)loadBoard:(OPResultBlock)resultBlock;
+ (void)loadThread:(NSInteger)forumID page:(NSInteger)page result:(OPResultBlock)resultBlock;
+ (void)loadPost:(NSString *)threadid result:(OPResultBlock)resultBlock;
+ (void)loadPostDetail:(NSString *)postid result:(OPResultBlock)resultBlock;

+ (void)newPost:(NSString *)subject message:(NSString *)message forumID:(NSString *)fid;
+ (void)replyPost:(NSString *)message postID:(NSString *)pid;

@end
