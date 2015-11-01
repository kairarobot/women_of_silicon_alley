//
//  StoryCollectionVC.m
//  WomenOfSiliconAlley
//
//  Created by Fatima Zenine Villanueva on 11/1/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "StoryCollectionVC.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "StoryCollection.h"
#import <UIKit/UIKit.h>
#import "StoryCollectionViewCell.h"

@interface StoryCollectionVC ()

@property (nonatomic) NSArray *storyCollectionArray;


@end

@implementation StoryCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)fetchParseQuery {
    
    PFQuery *query = [PFQuery queryWithClassName:@"StoryCollection"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved");
            
            self.storyCollectionArray = objects;
            
            // reload the tableview
            [self.collectionView reloadData];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchParseQuery];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.storyCollectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    StoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoryCell" forIndexPath:indexPath];
    
        StoryCollection *userStory = self.storyCollectionArray[indexPath.item];
    
    cell.imageView.file = userStory.photo;
    
    [cell.imageView loadInBackground];
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
