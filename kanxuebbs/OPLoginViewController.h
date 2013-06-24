//
//  OPLoginViewController.h
//  kanxuebbs
//
//  Created by sgl on 13-6-24.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OPUserManager.h"

@interface OPLoginViewController : UIViewController <OPUserManagerDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *passwdField;

- (IBAction)cancleAction:(id)sender;
- (IBAction)loginAction:(id)sender;

@end
