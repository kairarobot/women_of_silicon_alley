//
//  DetailStoryCollectionVC.h
//  WomenOfSiliconAlley
//
//  Created by Fatima Zenine Villanueva on 11/3/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import "StoryCollection.h"

@interface DetailStoryCollectionVC : UIViewController

@property (nonatomic) PFFile *imageView;
@property (nonatomic) StoryCollection *selected;

@end
