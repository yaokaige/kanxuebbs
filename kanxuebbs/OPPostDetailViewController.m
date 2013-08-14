//
//  OPPostDetailViewController.m
//  kanxuebbs
//
//  Created by sgl on 13-8-14.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import "OPPostDetailViewController.h"
#import "OPBBSInterface.h"

@interface OPPostDetailViewController ()

@end

@implementation OPPostDetailViewController

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
    [self loadData];
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
#pragma mark -
- (void)loadData
{
    [OPBBSInterface loadPostDetail:_postID result:^(id data, NSError *err) {
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
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"postdetail" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:[NSString stringWithFormat:htmlString, postdata] baseURL:nil];
}

- (void)dataFailed:(NSError *)err
{
    OPLog(@"%@", err);
}

#pragma mark -
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
}

@end
