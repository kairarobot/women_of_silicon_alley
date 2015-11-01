//
//  Message.h
//  testParseChat
//
//  Created by Fatima Zenine Villanueva on 10/31/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "PFObject.h"
#import <Parse/Parse.h>

@interface Message : PFObject <PFSubclassing>

@property (nonatomic)NSString *userName;
@property (nonatomic)NSString *contentText;


@end
