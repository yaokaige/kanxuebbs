//
//  OPThreadDetailViewController.m
//  kanxuebbs
//
//  Created by sgl on 13-6-28.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import "OPThreadDetailViewController.h"
#import "OPBBSInterface.h"
#import "OPPostDetailViewController.h"

@interface OPThreadDetailViewController ()

@end

@implementation OPThreadDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _webView.delegate = self;
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"thread" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}

#pragma mark -
- (void)loadData
{
    [OPBBSInterface loadPost:_threadID result:^(id data, NSError *err) {
        if (err == nil) {
            [self dataReady:data];
        }
        else {
            [self dataFailed:err];
        }
    }];
}

#pragma mark -
- (void)dataReady:(id)data
{
    NSString *postdata = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *cmd = [NSString stringWithFormat:@"var pdata = %@\nShowPost(pdata)", [postdata stringByReplacingOccurrencesOfString:@"\r\n" withString:@""]];
    OPLog(@"%@", [_webView stringByEvaluatingJavaScriptFromString:cmd]);
}

- (void)dataFailed:(NSError *)err
{
    OPLog(@"%@", err);
}

- (void)runAction:(NSString *)path
{
    if ([path hasPrefix:@"/show/"]) {
        // 显示详情
        NSString *postid = [path substringFromIndex:6];
        [self performSegueWithIdentifier:@"OPPostShowDetail" sender:postid];
    }
}

#pragma mark -
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"OPPostShowDetail"]) {
        OPPostDetailViewController *c = segue.destinationViewController;
        c.postID = sender;
    }
}

#pragma mark -
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (UIWebViewNavigationTypeLinkClicked == navigationType) {
        [self performSelector:@selector(runAction:) withObject:request.URL.path];
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self loadData];
}


@end
