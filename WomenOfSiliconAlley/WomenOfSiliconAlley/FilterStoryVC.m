//
//  FilterStoryVC.m
//  SiliconAlleyMeme
//
//  Created by Zoufishan Mehdi on 10/31/15.
//  Copyright © 2015 Zoufishan Mehdi. All rights reserved.
//

#import "FilterStoryVC.h"
#import "cameraImageDelegate.h"
#import "UIImage+Filter.h"
#import "AddFilterVC.h"

@interface FilterStoryVC ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureTakenImageView;


@property (weak, nonatomic) IBOutlet UIButton *shareStoryButton;

@property (weak, nonatomic) IBOutlet UIButton *siliconFilterButton;
@property (weak, nonatomic) IBOutlet UIButton *takePic;

@property (nonatomic) NSMutableArray *storyPics;
@property (weak, nonatomic) IBOutlet UITextField *enterStoryTextField;

@end


@implementation FilterStoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    self.pictureTakenImageView.clipsToBounds = YES;
    
}

- (IBAction)siliconButtonTapped:(UIButton *)sender {
    
    
    UIImage *cameraImg = self.pictureTakenImageView.image;

    
    float width = 320.0;
    float ratio = width / cameraImg.size.width;
    UIImage *scaledImage = [cameraImg resize:CGSizeMake(width, cameraImg.size.height * ratio)];
    
    UIImage *siliconAlleyFilter = [[UIImage imageNamed:@"womenofsiliconalley.png"] resize:scaledImage.size];
    
    
    
    UIImage *finalImage = [UIImage drawImage:siliconAlleyFilter inImage:scaledImage atPoint:CGPointZero];
    
    self.pictureTakenImageView.image = finalImage;
    
}


- (IBAction)filterTwoTapped:(UIButton *)sender {
    
    UIImage *cameraImg = self.pictureTakenImageView.image;
    
    float width = 320.0;
    float ratio = width / cameraImg.size.width;
    UIImage *scaledImage = [cameraImg resize:CGSizeMake(width, cameraImg.size.height * ratio)];
    
    CIImage *bgnImage = [[CIImage alloc] initWithCGImage:scaledImage.CGImage options:nil];
    
  
    CIContext *imgContext = [CIContext contextWithOptions:nil];
    
    CIFilter *imgFilter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, bgnImage, @"inputIntensity", [NSNumber numberWithFloat:0.6], nil];
    CIImage *myOutputImage = [imgFilter outputImage];
    
    CGImageRef cgImgRef = [imgContext  createCGImage:myOutputImage fromRect:[myOutputImage extent]];
    UIImage *newImgWithFilter = [UIImage imageWithCGImage:cgImgRef];
    
     self.pictureTakenImageView.image = newImgWithFilter;
    
    CGImageRelease(cgImgRef);
    
}


- (IBAction)filterThreeTapped:(UIButton *)sender {
    
    UIImage *cameraImg = self.pictureTakenImageView.image;
    
    float width = 320.0;
    float ratio = width / cameraImg.size.width;
    UIImage *scaledImage = [cameraImg resize:CGSizeMake(width, cameraImg.size.height * ratio)];
    
    CIImage *bgnImage = [[CIImage alloc] initWithCGImage:scaledImage.CGImage options:nil];
    
    
    CIContext *imgContext = [CIContext contextWithOptions:nil];
    
    CIFilter *imgFilter = [CIFilter filterWithName:@"CIVignette" keysAndValues: kCIInputImageKey, bgnImage, @"inputIntensity", [NSNumber numberWithFloat:0.7], @"inputRadius", [NSNumber numberWithFloat:10.0], nil];
    CIImage *myOutputImage = [imgFilter outputImage];
    
    CGImageRef cgImgRef = [imgContext  createCGImage:myOutputImage fromRect:[myOutputImage extent]];
    UIImage *newImgWithFilter = [UIImage imageWithCGImage:cgImgRef];
    
    self.pictureTakenImageView.image = newImgWithFilter;
    
    CGImageRelease(cgImgRef);
    
}
- (IBAction)filterFourTapped:(UIButton *)sender {
    UIImage *cameraImg = self.pictureTakenImageView.image;
    
    float width = 320.0;
    float ratio = width / cameraImg.size.width;
    UIImage *scaledImage = [cameraImg resize:CGSizeMake(width, cameraImg.size.height * ratio)];
    
    CIImage *bgnImage = [[CIImage alloc] initWithCGImage:scaledImage.CGImage options:nil];
    
    
    CIContext *imgContext = [CIContext contextWithOptions:nil];
    
    CIFilter *imgFilter = [CIFilter filterWithName:@"CIVibrance"  keysAndValues: kCIInputImageKey, bgnImage, @"inputAmount", [NSNumber numberWithFloat:0.7], nil];
    CIImage *myOutputImage = [imgFilter outputImage];
    
    CGImageRef cgImgRef = [imgContext  createCGImage:myOutputImage fromRect:[myOutputImage extent]];
    UIImage *newImgWithFilter = [UIImage imageWithCGImage:cgImgRef];
    
    self.pictureTakenImageView.image = newImgWithFilter;
    
    CGImageRelease(cgImgRef);
}

- (IBAction)filterFiveTapped:(UIButton *)sender {
    
    UIImage *cameraImg = self.pictureTakenImageView.image;
    
    float width = 320.0;
    float ratio = width / cameraImg.size.width;
    UIImage *scaledImage = [cameraImg resize:CGSizeMake(width, cameraImg.size.height * ratio)];
    
  
    
    CIImage *bgnImage = [[CIImage alloc] initWithCGImage:scaledImage.CGImage options:nil];
    
    
    CIContext *imgContext = [CIContext contextWithOptions:nil];
    
    CIFilter *imgFilter = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues: kCIInputImageKey, bgnImage, @"inputColor", [CIColor colorWithRed:0 green:191/255 blue:1 alpha:0.7] ,@"inputIntensity", [NSNumber numberWithFloat:0.5], nil];
    CIImage *myOutputImage = [imgFilter outputImage];
    
    CGImageRef cgImgRef = [imgContext  createCGImage:myOutputImage fromRect:[myOutputImage extent]];
    UIImage *newImgWithFilter = [UIImage imageWithCGImage:cgImgRef];
    
    self.pictureTakenImageView.image = newImgWithFilter;
    
    CGImageRelease(cgImgRef);
}


- (IBAction)takePicButtonTapped:(UIButton *)sender {
    
    self.picker.allowsEditing = YES;
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.picker animated:YES completion:NULL];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.pictureTakenImageView.image = chosenImage;
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}




- (void)textFieldDidBeginEditing:(UITextField*)textField {
    textField.text = @" ";
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.enterStoryTextField resignFirstResponder];
}



- (IBAction)shareStoryButtonTapped:(UIButton *)sender {
    
    [self.delegate memeGenerator:self.pictureTakenImageView.image theLabel:@"Woman of Silicon Alley"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"working");
    
 
}



@end
