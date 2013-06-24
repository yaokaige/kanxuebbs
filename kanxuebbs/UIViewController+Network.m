//
//  UIViewController+Network.m
//
//  Created by sgl on 13-4-28.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import "UIViewController+Network.h"
#import "AFNetworking.h"

@implementation UIViewController (Network)

- (void)loadData:(NSString *)jsonSource tag:(NSInteger)tag parser:(id(^)(id data,  NSError **err))parserBlock;
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:jsonSource]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (parserBlock != nil) {
            NSError *err = nil;
            id result = parserBlock(JSON, &err);
            if (err == nil) {
                [self dataReady:result tag:tag];
            }
            else {
                [self dataFailed:err tag:tag];
            }
        }
        else {
            [self dataReady:JSON tag:tag];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [self dataFailed:error tag:tag];
    }];
    [operation start];
}

- (void)loadData:(NSString *)jsonSource tag:(NSInteger)tag
{
    [self loadData:jsonSource tag:tag parser:nil];
}

- (void)loadJSON:(NSString *)jsonSource tag:(NSInteger)tag
{
    [self loadData:jsonSource tag:tag parser:^id(id data, NSError *__autoreleasing *err) {
        id result = [data objectForKey:@"result"];
        if (result == nil) {
            NSError *e = [NSError errorWithDomain:@"com.sunix.rating" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"Data format error.", NSLocalizedFailureReasonErrorKey: @"No result in data."}];
            *err = e;
            return nil;
        }
        
        id status = [result objectForKey:@"status"];
        if (status == nil || ![status isKindOfClass:[NSDictionary class]]) {
            NSError *e = [NSError errorWithDomain:@"com.sunix.rating" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"Data format error.", NSLocalizedFailureReasonErrorKey: @"No status in result."}];
            *err = e;
            return nil;
        }
        
        NSInteger code = [[status objectForKey:@"code"] intValue];
        if (code != 0) {
            NSString *msg = [status objectForKey:@"msg"];
            if (msg.length == 0) {
                msg = @"Unknown Server Error.";
            }
            NSError *e = [NSError errorWithDomain:@"com.sunix.rating" code:code userInfo:@{NSLocalizedDescriptionKey: msg, NSLocalizedFailureReasonErrorKey: msg}];
            *err = e;
            return nil;
        }
        
        return [result objectForKey:@"data"];
    }];
}

- (void)dataReady:(id)data tag:(NSInteger)tag
{
    
}

- (void)dataFailed:(NSError *)error tag:(NSInteger)tag
{
    
}

- (void)postData:(NSString *)host path:(NSString *)path parameters:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:host]];
    
    [httpClient postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        failure(error);
    }];
}

@end
