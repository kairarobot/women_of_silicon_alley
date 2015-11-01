//
//  ChatViewController.m
//  WomenOfSiliconAlley
//
//  Created by Fatima Zenine Villanueva on 11/1/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "ChatViewController.h"
#import "Message.h"
#import "MessageCellXib.h"


@interface ChatViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

// Local array that references Parse data
@property (nonatomic) NSMutableArray *textArray;

// Text view
@property (weak, nonatomic) IBOutlet UITextView *chatView;

// Table view
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// Property constraint of the UIView holding the self.chatView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dockViewConstraint;

// Send the message button
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation ChatViewController


#pragma mark - Table View Settings

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Creates an instance of MessageCellXib so it can be used as a cell
    MessageCellXib *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    // Creates an instance of PFObject Message from the locally referenced array
    Message *text = [self.textArray objectAtIndex:indexPath.row];
    
    // Sets the cell's user name to the PFObject text's user name
    cell.userName.text = text.userName;
    
    // Sets the cell's content text to the PFObject text's content text
    cell.contextText.text = text.contentText;
    
    return cell;
}

- (void)userRegisterNickName {
    
    // Creates NSUserDefaults
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    
    // Checks if user has a nickname stored in defaults
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"nickname"]){
        
        NSLog(@"nickname found");
        
    } else {
        
        // Goes to nick name view controller
        [self performSegueWithIdentifier:@"NicknameID" sender:self];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    // Delete username for test purposes
//     [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nickname"];
    
    // Nickname register name
    [self userRegisterNickName];

}

-(void) fetchDataFromParse
{
    self.textArray = [[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName: @"Message"];
    [query findObjectsInBackgroundWithBlock: ^(NSArray *objects, NSError *error)
     {
         if(!error)
         {
             // Loop through the Message objects in Parse
             for (PFObject *object in objects) {
                 [self.textArray addObject:object];
             }
             
         } else {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
         
         // Stays on the main thread to
         dispatch_async(dispatch_get_main_queue(), ^(void)
                        {
                            [self.tableView reloadData];
                            
                            // Automtically scrolls down to the bottom of table view
                            [self automaticScrollDown];
                            
                            NSLog(@"Test: %@", self.textArray);
                            
                        });
     }];
}


- (IBAction)sendButton:(UIButton *)sender {
    Message *text = [[Message alloc]init];
    text.contentText = self.chatView.text;
    NSString *nickname = [[NSUserDefaults standardUserDefaults]valueForKey:@"nickname"];
    text.userName = nickname;
    [text saveInBackground];
    [self.chatView resignFirstResponder];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        
        self.dockViewConstraint.constant = 60;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        nil;
    }];
    [self retrieveMessages];
    
    
}


- (void) retrieveMessages {
    
    // Create a new PFQuery
    PFQuery *query = [PFQuery queryWithClassName: @"Message"];
    
    // Call findObjectsInBackground
    [query findObjectsInBackgroundWithBlock: ^(NSArray *objects, NSError *error){
        if(!error)
        {
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            
            //Clear array
            [self.textArray removeAllObjects];
            
            // Loop through the parse objects
            for (PFObject *object in objects) {
                [self.textArray addObject:object];
                NSLog(@"%@", object.objectId);
            }
        }  else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        // Stay on this thread
        dispatch_async(dispatch_get_main_queue(), ^(void)
                       {
                           [self.tableView reloadData];
                           
                           // Automtically scrolls down to the bottom of table view
                           [self automaticScrollDown];
                           
                           NSLog(@"Test: %@", self.textArray);
                           
                       });
    }];
    
}


- (void)viewDidLoad {
    
    // Calls the method to fetch data from Parse
    [self fetchDataFromParse];
    
    [super viewDidLoad];
    
    [self.sendButton setEnabled:NO];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.chatView.delegate = self;
    
    // Cell height: estimated row height with constraint in xib
    self.tableView.estimatedRowHeight = 70.0;
    
    // Cell height: auto cell height adjusts based on xib content
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Register the nib file inside the table view
    UINib *nib = [UINib nibWithNibName:@"MessageCellXib" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CellIdentifier"];
}

- (void) automaticScrollDown {
    // Grabs the last row
    NSInteger numberOfRow = self.textArray.count - 1;
    
    // Creates an index path based on the last row
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:numberOfRow inSection:0];
    
    if (self.textArray.count > 0){
        
        // Sets the table view to the index path indiczted
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:true];
    }
}


#pragma mark - Text View Return
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    // Enable send button once user starts editing
    [self.sendButton setEnabled:YES];
    
    // If user hits return
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self.view layoutIfNeeded];
        
        // Closes down the view with a drop animation
        [UIView animateWithDuration:0.5 animations:^{
            self.dockViewConstraint.constant = 60;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            nil;
        }];
        
        // Reloads the table view data
        [self.tableView reloadData];
        
        // Disables the send button
        [self.sendButton setEnabled:NO];
        
        // Clears the text
        [textView setText:@""];

        
        return NO;
    }
    
    // Sets the text view to the current text of the textView delegate
    self.chatView.text = textView.text;
    
    return YES;
}

#pragma Mark - Text Field Delegate Methods
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    [textView setText:@""];
    
    [self.view layoutIfNeeded];
    
    // Closes down the view with a drop animation
    [UIView animateWithDuration:0.5 animations:^{
        self.dockViewConstraint.constant = 280;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        nil;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
