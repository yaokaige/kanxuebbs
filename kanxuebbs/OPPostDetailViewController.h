//
//  OPPostDetailViewController.h
//  kanxuebbs
//
//  Created by sgl on 13-8-14.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPPostDetailViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *postID;

@end
