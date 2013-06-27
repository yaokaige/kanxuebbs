//
//  OPThreadCell.m
//  kanxuebbs
//
//  Created by sgl on 13-6-27.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import "OPThreadCell.h"

@implementation OPThreadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)assignWithData:(id)data
{
    _threadTitleLabel.text = data[@"threadtitle"];
    _authorLabel.text = data[@"postusername"];
    _timeLabel.text = data[@"lastpostdate"];
}

@end
