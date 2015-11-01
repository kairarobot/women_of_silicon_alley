//
//  StoryTableViewCell.h
//  WomenOfSiliconAlley
//
//  Created by Xiulan Shi on 10/31/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

@interface StoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *storyImageView;

@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
