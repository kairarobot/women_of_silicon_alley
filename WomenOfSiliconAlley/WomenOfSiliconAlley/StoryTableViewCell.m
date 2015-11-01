//
//  StoryTableViewCell.m
//  WomenOfSiliconAlley
//
//  Created by Xiulan Shi on 10/31/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "StoryTableViewCell.h"

@implementation StoryTableViewCell

- (void)awakeFromNib {
    self.storyImageView.clipsToBounds = YES;
    CALayer * photoLayer = [self.storyImageView layer];
    [photoLayer setMasksToBounds:YES];
    [photoLayer setCornerRadius:10.0];
    
    // Photo Configuration
    [photoLayer setBorderWidth:4.0];
    [photoLayer setBorderColor:[[UIColor whiteColor] CGColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
