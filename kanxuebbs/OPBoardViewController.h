//
//  OPBoardViewController.h
//  kanxuebbs
//
//  Created by sgl on 13-6-24.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPBoardViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *boardData;
@property (strong, nonatomic) IBOutlet UITableView *boardTable;

- (IBAction)refreshAction:(id)sender;

@end
