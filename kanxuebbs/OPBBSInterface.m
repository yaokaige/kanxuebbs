//
//  OPBBSInterface.m
//  kanxuebbs
//
//  Created by sgl on 13-6-24.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import "OPBBSInterface.h"
#import <CommonCrypto/CommonDigest.h>
#import "JSONKit.h"

@implementation OPBBSInterface

+ (NSString*)encodePassword:(NSString*)password
{
    //这叫做丧心病狂
    return [OPBBSInterface md5:[OPBBSInterface stringEncode:[OPBBSInterface stringByTrimming:password]]];
}

+ (NSString *)encodePasswordUTF:(NSString *)password
{
    return [OPBBSInterface md5:[OPBBSInterface stringByTrimming:password]];
}

//转换代码
+ (NSString*)stringEncode:(NSString*)text
{
    NSString *result = @"";
    for(int index = 0; index < [text length]; index++){
        //获得每个字符的Unicode
        int ucode = [[NSString stringWithFormat:@"%04x", [text characterAtIndex:index]] intValue];
        NSString *tmp = @"";
        
        if (ucode > 255){
            while (ucode > 1) {
                tmp = [NSString stringWithFormat:@"%C%@", [@"0123456789" characterAtIndex:(ucode%10)], tmp];
                ucode /= 10;
            }
            
            if ([tmp isEqualToString:@""]){
                tmp = @"0";
            }
            
            tmp = [NSString stringWithFormat:@"&#%@;", tmp];
            result = [NSString stringWithFormat:@"%@%@", result, tmp];
        } else {
            result = [NSString stringWithFormat:@"%@%C", result, [text characterAtIndex:index]];
        }
    }
    
    return result;
}

//给NSString执行Trim指令
+ (NSString*)stringByTrimming:(NSString*)text
{
    NSMutableString *mStr = [text mutableCopy];
    CFStringTrimWhitespace((CFMutableStringRef)mStr);
    
    NSString *result = [mStr copy];
    
    return result;
}

//将NSString值转换成MD5
+ (NSString*)md5:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

+ (void)bbsGetData:(NSString *)url result:(void(^)(id data, NSError *err))resultBlock
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [responseObject objectFromJSONData];
        if (json == nil) {
            NSString *msg = @"Cant parse response data to json.";
            NSError *e = [NSError errorWithDomain:OPErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey: msg, NSLocalizedFailureReasonErrorKey: msg}];
            resultBlock(nil, e);
        }
        else {
            resultBlock(json, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        resultBlock(nil, error);
    }];

    [operation start];
}

+ (void)bbsPostData:(NSString *)host path:(NSString *)path params:(NSDictionary *)params result:(void(^)(id data, NSError *err))resultBlock
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:host]];
    
    [httpClient postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", [[operation response] allHeaderFields]);
        resultBlock(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        resultBlock(nil, error);
    }];
}

+ (void)login:(NSString *)name passwd:(NSString *)passwd result:(void(^)(id data, NSError *err))resultBlock
{
    NSURL *loginURL = [NSURL URLWithString:[OPGlobalURL URLForKey:kOPUserLogin]];
    NSString *host = [NSString stringWithFormat:@"http://%@", loginURL.host];
    NSString *path = @"login.php?do=login&styleid=12";
    NSString *md5passwd = [OPBBSInterface encodePassword:passwd];
    NSString *md5passwdutf = [OPBBSInterface encodePasswordUTF:passwd];
    
    NSDictionary *params = @{@"vb_login_username": name,
                             @"vb_login_md5password": md5passwd,
                             @"vb_login_md5password_utf": md5passwdutf,
                             @"do": @"login",
                             @"cookieuser": @"1",
                             @"securitytoken": @"guest"};
    [OPBBSInterface bbsPostData:host path:path params:params result:resultBlock];
}

+ (void)loadBoard:(void(^)(id data, NSError *err))resultBlock
{
    NSString *url = [OPGlobalURL URLForKey:kOPBoardList];
    [OPBBSInterface bbsGetData:url result:resultBlock];
}

@end
