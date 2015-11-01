//
//  cameraImageDelegate.h
//  SiliconAlleyMeme
//
//  Created by Zoufishan Mehdi on 10/31/15.
//  Copyright © 2015 Zoufishan Mehdi. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol cameraImageDelegate <NSObject>

@required

- (void) memeGenerator: (UIImage *)memeImage theLabel: (NSString *)memeString;

@end
