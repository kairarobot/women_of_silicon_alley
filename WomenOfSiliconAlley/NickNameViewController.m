//
//  NickNameViewController.m
//  testParseChat
//
//  Created by Fatima Zenine Villanueva on 10/31/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "NickNameViewController.h"
#import "WZFlashButton.h"

@interface NickNameViewController () <WZFlashButtonDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;

@end

@implementation NickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self nickNameWhiteTextField];
    
    [self nickNameCheckButton];

}

- (void)nickNameWhiteTextField {
    self.nickNameTextField.layer.borderColor=[[UIColor whiteColor]CGColor];
    self.nickNameTextField.layer.borderWidth= 1.0f;
}

- (void)nickNameCheckButton {
    // Outer Round Button
    WZFlashButton *outerRoundFlashButton = [[WZFlashButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2.5, self.view.frame.size.height/ 1.7, 80, 80)];
    outerRoundFlashButton.buttonType = WZFlashButtonTypeOuter;
    outerRoundFlashButton.layer.cornerRadius = 40;
    outerRoundFlashButton.flashColor = [UIColor colorWithRed:240/255.f green:159/255.f blue:10/255.f alpha:1];
    outerRoundFlashButton.backgroundColor = [UIColor colorWithRed:0 green:152.0f/255.0f blue:203.0f/255.0f alpha:1.0f];
    [outerRoundFlashButton setText:@"Send"];
    [self.view addSubview:outerRoundFlashButton];
    outerRoundFlashButton.delegate = self;
}


- (void)didTapWZFlashButton:(WZFlashButton *)button {


}

@end
