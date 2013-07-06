//
//  OPThreadViewController.h
//  kanxuebbs
//
//  Created by sgl on 13-6-24.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPThreadViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) NSInteger forumID;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *threadList;
@property (strong, nonatomic) IBOutlet UITableView *threadTable;

@end
