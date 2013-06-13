//
//  HomeViewController.m
//  Pickup
//
//  Created by ALAIN KHUON on 15/05/13.
//  Copyright (c) 2013 ALAIN KHUON. All rights reserved.
//

#import "HomeViewController.h"
#import "PickupDetailViewController.h"

// Sliding menu
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

// GET api
#import "JSONKit.h"
#import "MKNetworkKit.h"

// DataBase
#import "AppDelegate.h"



@interface HomeViewController ()

@end

@implementation HomeViewController
{
    NSMutableArray *tableData;
    NSObject *Record;

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Sliding menu
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]){
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    //[self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    //Button creation
    self.menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.menuBtn.frame = CGRectMake(8, 8, 34, 24);
    [self.menuBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [self.menuBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.view addSubview:self.menuBtn];
    
    [self loadData];
    
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];


}

- (void)viewDidAppear:(BOOL)animated
{
    self.menuBtn.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.menuBtn.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [tableData count];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *homeIdentifier = @"HomeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeIdentifier];
    }
    
    UILabel *recipeNameLabel = (UILabel *)[cell viewWithTag:101];
    recipeNameLabel.text = tableData[indexPath.row][@"text"];
        
    //cell.textLabel.text = tableData[indexPath.row][@"text"];
    //cell.textLabel.text = tableData[indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPickupDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PickupDetailViewController *destViewController = segue.destinationViewController;
        //destViewController.pickupName = [tableData objectAtIndex:indexPath.row];
        destViewController.pickupName = tableData[indexPath.row][@"text"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */

}

- (void)refreshData
{
    MKNetworkOperation *request = [[PickupNetworkEngine instance] operationWithURLString:@"http://pacific-beyond-9278.herokuapp.com/home/pickups.json"];
     tableData = [NSMutableArray array];
     [request addCompletionHandler:^(MKNetworkOperation *completedOperation) {
     NSArray *array = [completedOperation.responseString objectFromJSONString];
     
     for (NSDictionary *tmp in array)
     {
     //[tableData addObject:tmp[@"id"]];
     [tableData addObject:tmp[@"text"]];
     
     [APPDELEGATE.database executeUpdate:@"insert into pickups(id, text, user_id) values(?,?,?)", tmp[@"id"], tmp[@"text"], tmp[@"user_id"], nil];
     }
         
     [self loadData];
         
     [self.tableView reloadData];
     
     //NSLog(@"json = %@", tableData);
     
     } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
     // error
     
     }];
     
     [[PickupNetworkEngine instance] enqueueOperation:request];
}

-(void)loadData
{
    tableData = [NSMutableArray array];
    
    FMResultSet *results = [APPDELEGATE.database executeQuery:@"select text from pickups"];
    while([results next]) {
        [tableData addObject:[results resultDict]];
    }
    NSLog(@"Data reloaded !!, %@", tableData);
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    [self refreshData];
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [refreshControl endRefreshing];
    });
}

@end
