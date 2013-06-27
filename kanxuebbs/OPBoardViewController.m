//
//  OPBoardViewController.m
//  kanxuebbs
//
//  Created by sgl on 13-6-24.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import "OPBoardViewController.h"
#import "OPBBSInterface.h"
#import "JSONKit.h"
#import "OPThreadViewController.h"

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
    NSString *boardList = @"{\"forumbits\":[{\"forumTitle\":\"初学者园地\",\"forumSubTitle\":[{\"name\":\"『临时会员版』\",\"id\":131,\"imgId\":0},{\"name\":\"『求助问答』\",\"id\":20,\"imgId\":0},{\"name\":\"『伴你成长』\",\"id\":139,\"imgId\":0}]},{\"forumTitle\":\"Windows平台\",\"forumSubTitle\":[{\"name\":\"『软件调试逆向』\",\"id\":4,\"imgId\":0},{\"name\":\"『编程技术』\",\"id\":41,\"imgId\":0},{\"name\":\"『加壳脱壳』\",\"id\":88,\"imgId\":0},{\"name\":\"『病毒木马』\",\"id\":30,\"imgId\":0},{\"name\":\"『密码学』\",\"id\":132,\"imgId\":0},{\"name\":\"『CrackMe&amp;ReverseMe』\",\"id\":37,\"imgId\":0},{\"name\":\"『外文翻译』\",\"id\":32,\"imgId\":0},{\"name\":\"『资源下载』\",\"id\":10,\"imgId\":0}]},{\"forumTitle\":\"移动平台\",\"forumSubTitle\":[{\"name\":\"『Android 开发』\",\"id\":159,\"imgId\":0},{\"name\":\"『Android 安全』\",\"id\":161,\"imgId\":0},{\"name\":\"『iOS安全』\",\"id\":166,\"imgId\":0},{\"name\":\"『Windows Phone安全』\",\"id\":167,\"imgId\":0}]},{\"forumTitle\":\"信息安全\",\"forumSubTitle\":[{\"name\":\"『WEB安全』\",\"id\":151,\"imgId\":0},{\"name\":\"『漏洞分析』\",\"id\":150,\"imgId\":0},{\"name\":\"『云计算安全』\",\"id\":162,\"imgId\":0},{\"name\":\"『硬件与通信安全』\",\"id\":128,\"imgId\":0}]},{\"forumTitle\":\"职场风云\",\"forumSubTitle\":[{\"name\":\"『招聘专区』\",\"id\":47,\"imgId\":0},{\"name\":\"『职业生涯』\",\"id\":137,\"imgId\":0}]},{\"forumTitle\":\"论坛生活\",\"forumSubTitle\":[{\"name\":\"『茶余饭后』\",\"id\":45,\"imgId\":0},{\"name\":\"『论坛会员区』\",\"id\":64,\"imgId\":0},{\"name\":\"『论坛活动』\",\"id\":109,\"imgId\":0}]},{\"forumTitle\":\"安全图书\",\"forumSubTitle\":[{\"name\":\"『图书项目版』\",\"id\":65,\"imgId\":0},{\"name\":\"『图书出版商』\",\"id\":126,\"imgId\":0}]},{\"forumTitle\":\"站务管理\",\"forumSubTitle\":[{\"name\":\"『论坛版务』\",\"id\":2,\"imgId\":0},{\"name\":\"『回收站』\",\"id\":57,\"imgId\":0}]}]}";
    self.boardData = [[boardList objectFromJSONString] objectForKey:@"forumbits"];
    _boardTable.delegate = self;
    _boardTable.dataSource = self;
    
    [_boardTable reloadData];
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

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_boardData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id dict = [_boardData safeObjectAtIndex:section];
    if (nil == dict) {
        return 0;
    }
    else {
        id subBoard = [dict objectForKeyNotNull:@"forumSubTitle"];
        if (nil == subBoard) {
            return 0;
        }
        return [subBoard count];
    }
    
    return 0;
}

#pragma mark -
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id dict = [_boardData safeObjectAtIndex:section];
    return [dict objectForKeyNotNull:@"forumTitle"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OPBoardCell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OPBoardCell"];
    }
    
    @try {
        id dict = [_boardData safeObjectAtIndex:indexPath.section];
        id subBoard = [dict objectForKeyNotNull:@"forumSubTitle"];
        id subDict = [subBoard safeObjectAtIndex:indexPath.row];
        cell.textLabel.text = [subDict objectForKeyNotNull:@"name"];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }

    return cell;
}


- (void)viewDidUnload {
    [self setBoardTable:nil];
    [super viewDidUnload];
}

#pragma mark -
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"OPBoardCell"]) {
        NSIndexPath *indexPath = [_boardTable indexPathForSelectedRow];
        id dict = [_boardData safeObjectAtIndex:indexPath.section];
        id subBoard = [dict objectForKeyNotNull:@"forumSubTitle"];
        id subDict = [subBoard safeObjectAtIndex:indexPath.row];
        [segue.destinationViewController setTitle:[subDict objectForKeyNotNull:@"name"]];
        [segue.destinationViewController setForumID:[[subDict objectForKeyNotNull:@"id"] intValue]];
    }
}

@end
