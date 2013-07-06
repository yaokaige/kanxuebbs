//
//  OPLoginViewController.m
//  kanxuebbs
//
//  Created by sgl on 13-6-24.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import "OPLoginViewController.h"
#import "OPUserManager.h"
#import "SIAlertView.h"

#define kOPSuccessAlertTag 1051

@interface OPLoginViewController ()

@end

@implementation OPLoginViewController

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
    [_nameField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNameField:nil];
    [self setPasswdField:nil];
    [super viewDidUnload];
}

- (void)dismiss
{
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

#pragma mark -
- (IBAction)cancleAction:(id)sender
{
    [self dismiss];
}

- (IBAction)loginAction:(id)sender
{
    if (_nameField.text.length == 0 || _passwdField.text.length == 0) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"错误" andMessage:@"请输入完整信息！"];
        
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDefault
                              handler:nil];
        [alertView show];
    }
    else {
        [[OPUserManager sharedInstance] setDelegate:self];
        [[OPUserManager sharedInstance] login:_nameField.text passwd:_passwdField.text];
    }
}

#pragma mark -
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (kOPSuccessAlertTag == alertView.tag) {
        [self dismiss];
    }
}

#pragma mark -
- (void)userManager:(OPUserManager *)userManager loginFailed:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)userManager:(OPUserManager *)userManager loginSuccess:(NSDictionary *)userInfo
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"登录成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alert.tag = kOPSuccessAlertTag;
    [alert show];
}

@end
