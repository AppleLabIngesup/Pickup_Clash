//
//  HomeViewController.h
//  Pickup
//
//  Created by ALAIN KHUON on 15/05/13.
//  Copyright (c) 2013 ALAIN KHUON. All rights reserved.
//

#import <UIKit/UIKit.h>
//RefreshControl
#import "ODRefreshControl.h"

@interface HomeViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIButton *menuBtn;

- (void)loadData;
- (void)refreshData;
- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl;
@end
