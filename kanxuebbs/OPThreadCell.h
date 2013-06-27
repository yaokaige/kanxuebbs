//
//  OPThreadCell.h
//  kanxuebbs
//
//  Created by sgl on 13-6-27.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPThreadCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *threadTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

- (void)assignWithData:(id)data;

@end
