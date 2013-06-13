//
//  TournamentViewController.h
//  Pickup
//
//  Created by ALAIN KHUON on 15/05/13.
//  Copyright (c) 2013 ALAIN KHUON. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TournamentViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UILabel *Label;
    IBOutlet UISegmentedControl *onglets;
    IBOutlet UITableView *myTableView;
    NSArray *tableDatatournois;
    ///modif1
    //NSArray *recipes;
    //H1
    //IBOutlet UITableView *tableView;
}
@property (strong, nonatomic) UIButton *menuBtn;
@property (nonatomic, retain) IBOutlet UISegmentedControl *onglets;
- (IBAction)ongletChange1: (id)sender;
@property (nonatomic, retain) IBOutlet UILabel *Label;
@property (nonatomic, strong) IBOutlet UITableView *myTableView;

@end

