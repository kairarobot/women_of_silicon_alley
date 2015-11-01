//
//  DetailStoryViewController.m
//  WomenOfSiliconAlley
//
//  Created by Xiulan Shi on 10/31/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "DetailStoryViewController.h"
#import <ParseUI/ParseUI.h>

@interface DetailStoryViewController ()

@property (weak, nonatomic) IBOutlet UILabel *storyDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet PFImageView *imageView;

@end

@implementation DetailStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.storyDetailLabel.text = self.selected.storyDetail;
    self.nameLabel.text = self.selected.name;
    self.roleLabel.text = self.selected.role;
    
    self.imageView.file = self.selected.image;
    [self.imageView loadInBackground];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    self.storyDetailLabel.hidden = YES;
    self.nameLabel.hidden = YES;
    self.roleLabel.hidden = YES;
}



@end
