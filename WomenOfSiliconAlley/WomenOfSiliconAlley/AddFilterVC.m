//
//  AddFilterVC.m
//  SiliconAlleyMeme
//
//  Created by Zoufishan Mehdi on 11/1/15.
//  Copyright © 2015 Zoufishan Mehdi. All rights reserved.
//

#import "AddFilterVC.h"
#import "FilterStoryVC.h"
#import "cameraImageDelegate.h"

@interface AddFilterVC ()

@property (weak, nonatomic) IBOutlet UIImageView *filteredImage;
@property (weak, nonatomic) IBOutlet UILabel *userStory;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (nonatomic) BOOL touchingLabel;

@end

@implementation AddFilterVC

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panning:)];
    [self.userStory addGestureRecognizer:pan];
}


-(void) viewWillAppear:(BOOL)animated {
    [self.view setNeedsDisplay];
}


- (void)panning:(UIPanGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateChanged: {
            CGPoint location = [gesture locationInView:self.view];
            self.userStory.center = location;
            break;
        }
        default:
            return;
    }
}


- (void) memeGenerator: (UIImage *)storyImage theLabel: (NSString *)storyString{
    self.filteredImage.image = storyImage;
    self.userStory.text = storyString;
    NSLog(@"image: %@, text: %@", storyImage, storyString);
}

-(void) prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender {
    FilterStoryVC *vc = segue.destinationViewController;
    vc.delegate = self;
    
}

-(UIImage *)capture{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(imageView, nil, nil, nil); //if you need to save
    return imageView;
}


- (IBAction)saveButtonTapped:(UIBarButtonItem *)sender {
    
    if (self.filteredImage.image != nil) {
        [self capture];
    }
}


@end
