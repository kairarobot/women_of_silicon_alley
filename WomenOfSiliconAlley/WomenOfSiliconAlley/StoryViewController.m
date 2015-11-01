//
//  ViewController.m
//  WomenOfSiliconAlley
//
//  Created by Xiulan Shi on 10/31/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "StoryViewController.h"
#import "StoryTableViewCell.h"
#import <ParseUI/ParseUI.h>
#import "DetailStoryViewController.h"

@interface StoryViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray *storyArray;

@property (nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabBarItem;

@end

@implementation StoryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // register nib with table view
    UINib *nib = [UINib nibWithNibName:@"StoryTableViewCell" bundle:nil];
    
    
    //register the nib for the cell identifier
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ImageCell"];
    
    
    self.storyArray = [[NSMutableArray alloc] init];
    
    [self fetchParseQuery];
    
//    PFObject *newStoryObject = [PFObject objectWithClassName:@"Story"];
//    newStoryObject[@"name"] = @"Zoufishan Mehdi";
//    newStoryObject[@"role"] = @"iOS Developer";
//    newStoryObject[@"storyDetail"] = @"IIt all started with working on cybersecurity for my MA thesis. Tech always seemed out of my realm, and it was reinforced by others who would tell me that it wasn’t for me or it wasn’t up my alley. Normally I would just believe them, but this time I shook it off and gave it a shot. While I didn’t know this at the time, this was my first baby step veering towards tech. This very mentality of shrugging off negative comments and giving things a shot culminated in trying programming online until I decided to devote my full attention to it. I’m still trying to find my footing in this field but I have a feeling this is the start of something new.";
//    
//    self.image = [UIImage imageNamed:@"zoufishan"];
//    NSData *data = UIImageJPEGRepresentation(self.image, 0.5f);
//    PFFile *imageFile = [PFFile fileWithName:@"zoufishan" data:data];
//    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            [newStoryObject setObject:imageFile forKey:@"image"];
//            [newStoryObject saveInBackground];
//            
//        }
//        else{
//            NSLog(@" did not upload file ");
//        }
//    }];
//    
//    [self.storyArray addObject:newStoryObject];
//    [self.tableView reloadData];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    [super viewWillAppear:YES];
    [self.tableView reloadData];
    [self fetchParseQuery];
}


- (void)fetchParseQuery {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Story"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved");
            
            self.storyArray = objects;
            
            // reload the tableview
            [self.tableView reloadData];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}



#pragma Mark - TableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.storyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    Story *storyResult = self.storyArray[indexPath.row];
    
    cell.roleLabel.text = storyResult.role;
    cell.nameLabel.text = storyResult.name;
    cell.storyImageView.file = storyResult.image;
    [cell.storyImageView loadInBackground];
    
    return cell;
}

#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [self performSegueWithIdentifier:@"DetailSegueIdentifier" sender:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"DetailSegueIdentifier"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        DetailStoryViewController *detailVC = segue.destinationViewController;
        
        Story *current = self.storyArray[indexPath.row];
        
        detailVC.selected = current;
        
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
