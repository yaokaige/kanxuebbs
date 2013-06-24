//
//  OPBoardViewController.m
//  kanxuebbs
//
//  Created by sgl on 13-6-24.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import "OPBoardViewController.h"
#import "OPBBSInterface.h"

@interface OPBoardViewController ()

@end

@implementation OPBoardViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshAction:(id)sender
{
    OPLogMethodName();
    [OPBBSInterface loadBoard:^(id data, NSError *err) {
        if (err == nil) {
            OPLog(@"%@", data);
        }
        else {
            OPLogErr(@"Load board err.");
        }
    }];
}

@end
