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
#import "DetailStoryCollectionVC.h"

@interface StoryCollectionVC () <UICollectionViewDelegateFlowLayout>

@property (nonatomic) NSArray *storyCollectionArray;

@property (nonatomic) PFFile *holderImage;


@end

@implementation StoryCollectionVC

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
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


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
    
    cell.imageView.layer.cornerRadius = 5.0;
    cell.imageView.layer.masksToBounds = YES;
        
    [cell.imageView loadInBackground];
    
    return cell;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    DetailStoryCollectionVC *vc = segue.destinationViewController;
    StoryCollection *current = self.storyCollectionArray[indexPath.item];
    vc.selected = current;
}


@end
