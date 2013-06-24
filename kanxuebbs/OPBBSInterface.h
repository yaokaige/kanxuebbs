//
//  OPBBSInterface.h
//  kanxuebbs
//
//  Created by sgl on 13-6-24.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OPGlobalURL.h"
#import "AFNetworking.h"

@interface OPBBSInterface : NSObject

+ (void)bbsGetData:(NSString *)url result:(void(^)(id data, NSError *err))resultBlock;
+ (void)bbsPostData:(NSString *)host path:(NSString *)path params:(NSDictionary *)params result:(void(^)(id data, NSError *err))resultBlock;

+ (void)login:(NSString *)name passwd:(NSString *)passwd result:(void(^)(id data, NSError *err))resultBlock;
+ (void)loadBoard:(void(^)(id data, NSError *err))resultBlock;

@end
