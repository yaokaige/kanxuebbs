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
#import "OPThreadDetailViewController.h"

@interface OPThreadViewController ()

@end

@implementation OPThreadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _forumID = 0;
        _page = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _threadTable.dataSource = self;
    _threadTable.delegate = self;
    
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setThreadTable:nil];
    [super viewDidUnload];
}

#pragma mark -
- (void)loadData
{
    [OPBBSInterface loadThread:_forumID page:_page result:^(id data, NSError *err) {
        if (err == nil) {
            [self dataReady:data];
        }
        else {
            [self dataFailed:err];
        }
    }];
}

- (void)loadMore
{
    _page += 1;
    [self loadData];
}

- (void)refresh
{
    _page = 1;
    [self loadData];
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

#pragma mark -
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [_threadTable indexPathForSelectedRow];
    id data = [_threadList safeObjectAtIndex:indexPath.row];
    if (nil != data) {
        // TODO: pass data
        OPThreadDetailViewController *c = segue.destinationViewController;
        c.threadID = data[@"threadid"];
    }
}

@end
