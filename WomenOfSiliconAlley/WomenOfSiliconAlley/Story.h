//
//  Story.h
//  WomenOfSiliconAlley
//
//  Created by Xiulan Shi on 10/31/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "PFObject.h"
#import <Parse/Parse.h>

@interface Story : PFObject <PFSubclassing>

@property (nonatomic) NSString *storyID;
@property (nonatomic) NSString *role;
@property (nonatomic) NSString *name;
@property (nonatomic) PFFile *image;
@property (nonatomic) NSString *storyDetail;


@end
