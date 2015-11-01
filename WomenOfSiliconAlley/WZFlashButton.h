//
//  WZFlashButton.h
//  WZRippleButton
//
//  Created by z on 15-1-6.
//  Copyright (c) 2015年 SatanWoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WZFlashButtonDelegate;

typedef void(^WZFlashButtonDidClickBlock)(void);

typedef NS_ENUM(NSUInteger, WZFlashButtonType) {
    WZFlashButtonTypeInner = 0,
    WZFlashButtonTypeOuter = 1
};

@interface WZFlashButton : UIView

@property (nonatomic, assign) WZFlashButtonType buttonType;
@property (nonatomic, copy) WZFlashButtonDidClickBlock clickBlock;
@property (nonatomic) BOOL didClick;
@property (nonatomic, weak) id<WZFlashButtonDelegate>delegate;

@property (nonatomic, strong) UIColor *flashColor;

- (void)setText:(NSString *)text;
- (void)setTextColor:(UIColor *)textColor;
- (void)setText:(NSString *)text withTextColor:(UIColor *)textColor;
- (BOOL)didTapTheButton;
@end

@protocol WZFlashButtonDelegate <NSObject>

- (void)didTapWZFlashButton:(WZFlashButton *)button;

@end
// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net 
