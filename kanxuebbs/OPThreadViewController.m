//
//  OPThreadViewController.m
//  kanxuebbs
//
//  Created by sgl on 13-6-24.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import "OPThreadViewController.h"
#import "OPBBSInterface.h"
#import "OPThreadCell.h"

@interface OPThreadViewController ()

@end

@implementation OPThreadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _forumID = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _threadTable.dataSource = self;
    _threadTable.delegate = self;
    
    [OPBBSInterface loadThread:_forumID result:^(id data, NSError *err) {
        if (err == nil) {
            [self dataReady:data];
        }
        else {
            [self dataFailed:err];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
     
#pragma mark -
- (void)dataReady:(id)data
{
    OPLog(@"%@", data);
    self.threadList = data[@"threadList"];
    [_threadTable reloadData];
}

- (void)dataFailed:(NSError *)err
{
    OPLog(@"%@", err);
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return _threadList.count;
}

#pragma mark -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OPThreadCell *cell = (OPThreadCell *)[tableView dequeueReusableCellWithIdentifier:@"OPThreadCell"];
    
    @try {
        id subDict = [_threadList safeObjectAtIndex:indexPath.row];
        [cell assignWithData:subDict];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    return cell;
}

- (void)viewDidUnload {
    [self setThreadTable:nil];
    [super viewDidUnload];
}
@end
