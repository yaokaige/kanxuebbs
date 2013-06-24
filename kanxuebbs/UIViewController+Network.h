//
//  UIViewController+Network.h
//
//  Created by sgl on 13-4-28.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Network)

- (void)loadData:(NSString *)jsonSource     tag:(NSInteger)tag;
- (void)dataReady:(id)data                  tag:(NSInteger)tag;
- (void)dataFailed:(NSError *)error         tag:(NSInteger)tag;

- (void)loadData:(NSString *)jsonSource     tag:(NSInteger)tag parser:(id(^)(id data, NSError **err))parserBlock;
- (void)loadJSON:(NSString *)jsonSource     tag:(NSInteger)tag;
- (void)postData:(NSString *)host path:(NSString *)path parameters:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
