//
//  ViewController.m
//  WomenOfSiliconAlley
//
//  Created by Xiulan Shi on 10/31/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "ViewController.h"
#import "StoryTableViewCell.h"
#import <ParseUI/ParseUI.h>

@interface ViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray *storyArray;

@property (nonatomic) UIImage *image;

@end

@implementation ViewController

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
//    newStoryObject[@"role"] = @"iOS Developer in training @C4QNYC’s#AccessCode";
//    newStoryObject[@"storyDetail"] = @"IIt all started with working on cybersecurity for my MA thesis. Tech always seemed out of my realm, and it was reinforced by others who would tell me that it wasn’t for me or it wasn’t up my alley. Normally I would just believe them, but this time I shook it off and gave it a shot. While I didn’t know this at the time, this was my first baby step veering towards tech. This very mentality of shrugging off negative comments and giving things a shot culminated in trying programming online until I decided to devote my full attention to it. I’m still trying to find my footing in this field but I have a feeling this is the start of something new.";
//    
//    
////        Story *story1 = [[Story alloc] init];
////        story1.role = @"iOS Developer";
////        story1.name = @"Kaira";
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
            // Do something with the found objects
//            for (PFObject *object in objects) {
//                NSLog(@"%@", object.objectId);
//                
//                //Retrieve the Column value of each PFObject
//                NSString *storyID = object[@"objectId"];
//                NSString *storyName = object[@"name"];
//                NSString *storyRole = object[@"role"];
//                NSString *storyDetail = object[@"storyDetail"];
//                PFFile *imageFile = object[@"image"];
//                
//                // Assign it into storyArray
//                
//                
//                [self.storyArray addObject:object];
//                
//                Story *story = [[Story alloc] init];
//
//                story.storyID =storyID;
//                story.name = storyName;
//                story.role = storyRole;
//                story.storyDetail = storyDetail;
//                story.image = imageFile;
//                
//                [self.storyArray addObject:story];
                
            
//            }
            
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
  
//    PFFile *imageFile = storyResult.image;
//    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//        if (!error) {
//            cell.storyImageView.image = [UIImage imageWithData:data];
//        }
//    }];
    
//    imageView.image = [UIImage imageNamed:@"..."]; // placeholder image
//    imageView.file = (PFFile *)someObject[@"picture"]; // remote image
//    [imageView loadInBackground];
    
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
