//
//  TournamentViewController.m
//  Pickup
//
//  Created by ALAIN KHUON on 15/05/13.
//  Copyright (c) 2013 ALAIN KHUON. All rights reserved.
//

#import "TournamentViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "DetailsViewController.h"

@interface TournamentViewController ()

@end

@implementation TournamentViewController

@synthesize menuBtn;
@synthesize Label;
@synthesize onglets;
@synthesize myTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Menu sliding
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]){
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    //Button creation
    self.menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(8, 10, 34, 24);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.menuBtn];
    
    tableDatatournois = [NSArray arrayWithObjects:@"I'm a slave for you", @"Tu es une femme d'exception", @"Quand je vois tes yeux je suis amoureux", @"Pour toi je suis prêt à être Roux", @"You're sexy and you Know it", @"You light up my life like nobady else",nil];
    Label.text = @"bonbon";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableDatatournois count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableDatatournois objectAtIndex:indexPath.row];
    return cell;
}

-(IBAction) ongletChange1
{
    switch (self.onglets.selectedSegmentIndex) {
        case 0:
            self.Label.text =@"PICKUP";
            tableDatatournois = [NSArray arrayWithObjects:@"I'm a slave for you", @"Tu es une femme d'exception", @"Quand je vois tes yeux je suis amoureux", @"Pour toi je suis prêt à être Roux", @"You're sexy and you Know it", @"You light up my life like nobady else",nil];
            [myTableView reloadData];
            
            break;
        case 1:
            
            self.Label.text =@"REBUFF";
            tableDatatournois = [NSArray arrayWithObjects:@"tu rassemble à un point noir", @"t'as le look clodo qu'un bobo", @"Sérieux tu fais un peu pitié", @"T'as un oeil qui dit merde à l'autre", @"t'es le maillon faible...au revoir", @"t'es sur tu veux pas un chewing gum", @"T'as une tête d'autruche", nil];
            [myTableView reloadData];
            
            break;
            
        default:
            break;
    }
    
}
///////ma partie pour la gestion de l'action
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDetails"]) {
        NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
        DetailsViewController *destViewController = segue.destinationViewController;
        destViewController.recipeName = [tableDatatournois objectAtIndex:indexPath.row];
    }
}
//////

@end
