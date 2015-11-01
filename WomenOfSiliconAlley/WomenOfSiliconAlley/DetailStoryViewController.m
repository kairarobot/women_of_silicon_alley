//
//  DetailStoryViewController.m
//  WomenOfSiliconAlley
//
//  Created by Xiulan Shi on 10/31/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "DetailStoryViewController.h"
#import <ParseUI/ParseUI.h>

@interface DetailStoryViewController () <UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITextView *detailStoryTextView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet PFImageView *imageView;

@end

@implementation DetailStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    
    self.detailStoryTextView.text = self.selected.storyDetail;
    self.nameLabel.text = self.selected.name;
    self.roleLabel.text = self.selected.role;
    
    self.imageView.file = self.selected.image;
    
    CALayer * photoLayer = [self.imageView layer];
    [photoLayer setMasksToBounds:YES];
    [photoLayer setCornerRadius:10.0];
    
    // Photo Configuration
    [photoLayer setBorderWidth:4.0];
    [photoLayer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [self.imageView loadInBackground];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    self.detailStoryTextView.hidden = YES;
    self.nameLabel.hidden = YES;
    self.roleLabel.hidden = YES;
}



@end
