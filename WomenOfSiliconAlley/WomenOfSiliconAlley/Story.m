//
//  Story.m
//  WomenOfSiliconAlley
//
//  Created by Xiulan Shi on 10/31/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "Story.h"

@implementation Story

@dynamic storyID;
@dynamic role;
@dynamic name;
@dynamic image;
@dynamic storyDetail;

+ (NSString *) parseClassName {
    return @"Story";
}

@end
