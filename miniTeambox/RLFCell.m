//
//  RLFCell.m
//  miniTeambox
//
//  Created by Raimon Lapuente on 28/05/13.
//  Copyright (c) 2013 RaimonLapuente. All rights reserved.
//

#import "RLFCell.h"

@implementation RLFCell

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

@end
