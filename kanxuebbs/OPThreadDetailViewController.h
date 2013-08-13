//
//  OPThreadDetailViewController.h
//  kanxuebbs
//
//  Created by sgl on 13-6-28.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPThreadDetailViewController : UIViewController <UIWebViewDelegate>
@property (nonatomic, strong) NSString *threadID;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
