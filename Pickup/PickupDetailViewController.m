//
//  PickupDetailViewController.m
//  Pickup
//
//  Created by ALAIN KHUON on 15/05/13.
//  Copyright (c) 2013 ALAIN KHUON. All rights reserved.
//

#import "PickupDetailViewController.h"

@interface PickupDetailViewController ()

@end

@implementation PickupDetailViewController
{
    // Ces variables ne seront pas utilisés dans la version finale de l'application. Elles devront venir de la base de donnée.

    // View 2
    NSString *pseudoBDD;
    int likeNumberBDD;
    int dislikeNumberBDD;
    // View 3
    NSString *textPickupBDD;
    // View 4
    int likeStateBDD;
    int dislikeStateBDD;
    /*
     likeStateBDD	dislikeStateBDD	likeImg		dislikeImg
 
     0              0				like_default	dislike_default
     0              1				like_off		dislike_on
     1              0				like_on         dislike_off
     */
    Boolean isClashBDD;
    Boolean isFavBDD;
}

@synthesize actionSheet = _actionSheet;
@synthesize pickupName;

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
    // Do any additional setup after loading the view, typically from a nib.
    
    // Données de tests. Devrons venir de la base de donnée.
    // View 2
    likeNumberBDD = 3;
    dislikeNumberBDD = 6;
    pseudoBDD = @"Florian";
    // View 3
    textPickupBDD = @"Ton père est un voleur ... il a pris toutes les étoiles du ciel pour les mettre dans tes yeux !";
    
    // View 4
    likeStateBDD = 0;
    dislikeStateBDD = 0;
    isClashBDD = false;
    isFavBDD = false;
    
    // Initialisation avec les données.
    // View 2
    pseudoLabel.text = pseudoBDD;
    likeLabel.text = [NSString stringWithFormat:@"%d", likeNumberBDD];
    dislikeLabel.text = [NSString stringWithFormat:@"%d", dislikeNumberBDD];
    // View 3
    //messageTextView.text = textPickupBDD;
    messageTextView.text = pickupName;
    
    // View 4
    if (likeStateBDD == 0 && dislikeStateBDD == 1) {
        likeImg.image = [UIImage imageNamed:@"like_off.png"];
        dislikeImg.image = [UIImage imageNamed:@"dislike_on.png"];
    } else if (likeStateBDD == 1 && dislikeStateBDD == 0) {
        likeImg.image = [UIImage imageNamed:@"like_on.png"];
        dislikeImg.image = [UIImage imageNamed:@"dislike_off.png"];
    } else {
        likeImg.image = [UIImage imageNamed:@"like_default.png"];
        dislikeImg.image = [UIImage imageNamed:@"dislike_default.png"];
    }
    if (isFavBDD) {
        favImg.image = [UIImage imageNamed:@"fav_on.png"];
    } else {
        favImg.image = [UIImage imageNamed:@"fav_off.png"];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)likeButtonPush
{
    if (likeStateBDD == 0 && dislikeStateBDD == 0) {
        likeImg.image = [UIImage imageNamed:@"like_on.png"];
        dislikeImg.image = [UIImage imageNamed:@"dislike_off.png"];
        likeStateBDD = 1;
        dislikeStateBDD = 0;
        likeNumberBDD ++;
    } else if (likeStateBDD == 1 && dislikeStateBDD == 0) {
        likeImg.image = [UIImage imageNamed:@"like_default.png"];
        dislikeImg.image = [UIImage imageNamed:@"dislike_default.png"];
        likeStateBDD = 0;
        dislikeStateBDD = 0;
        likeNumberBDD --;
    }
    likeLabel.text = [NSString stringWithFormat:@"%d", likeNumberBDD];
}

- (IBAction)dislikeButtonPush
{
    if (likeStateBDD == 0 && dislikeStateBDD == 0) {
        likeImg.image = [UIImage imageNamed:@"like_off.png"];
        dislikeImg.image = [UIImage imageNamed:@"dislike_on.png"];
        likeStateBDD = 0;
        dislikeStateBDD = 1;
        dislikeNumberBDD ++;
    } else if (likeStateBDD == 0 && dislikeStateBDD == 1) {
        likeImg.image = [UIImage imageNamed:@"like_default.png"];
        dislikeImg.image = [UIImage imageNamed:@"dislike_default.png"];
        likeStateBDD = 0;
        dislikeStateBDD = 0;
        dislikeNumberBDD--;
    }
    dislikeLabel.text = [NSString stringWithFormat:@"%d", dislikeNumberBDD];
}

- (IBAction)favButtonPush
{
    isFavBDD = !isFavBDD;
    
    if (isFavBDD) {
        favImg.image = [UIImage imageNamed:@"fav_on.png"];
    } else {
        favImg.image = [UIImage imageNamed:@"fav_off.png"];
    }
}

- (IBAction)shareButtonPush
{
    if (self.actionSheet) {
        // do nothing
    } else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Partager" delegate:self cancelButtonTitle:@"Annuler" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", @"Twitter",@"Mail", nil];
        [actionSheet showFromBarButtonItem:self animated:YES];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *choice = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([choice isEqualToString:@"Facebook"]) {
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
            SLComposeViewController *facebook = [[SLComposeViewController alloc] init];
            
            facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            NSString *text = @"Trop fort cette phrase de drague !!! \n\"";
            
            text = [text stringByAppendingString:pickupName];
            text = [text stringByAppendingString:@"\""];
            
            [facebook setInitialText:text];
            [self presentViewController:facebook animated:YES completion:nil];
            
            [facebook setCompletionHandler:^(SLComposeViewControllerResult result){
                NSString *output;
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        output = @"Action Annulée";
                        break;
                    case SLComposeViewControllerResultDone:
                        output = @"Message posté";
                        break;
                    default:
                        break;
                }
                NSLog(@"%@", output);
            }];
            
        }
        
        NSLog(@"Partage par facebook selectionné !");
    } else if ([choice isEqualToString:@"Twitter"]) {
        
        TWTweetComposeViewController *tw = [[TWTweetComposeViewController alloc] init];
        
        NSString *text = @"Trop fort cette phrase de drague !!! \n\"";
        
        text = [text stringByAppendingString:pickupName];
        text = [text stringByAppendingString:@"\""];
        
        [tw setInitialText:text];
        [self presentModalViewController:tw animated:YES];
        
        NSLog(@"Partage par twitter selectionné !");
        
    } else if ([choice isEqualToString:@"Mail"]) {
        
        // Email Subject
        NSString *emailTitle = @"Partage pickup";
        // Email Content
        NSString *text = @"Trop fort cette phrase de drague !!! \n\"";
        
        text = [text stringByAppendingString:pickupName];
        text = [text stringByAppendingString:@"\""];
        // To address
        //NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:text isHTML:NO];
        //[mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
        
        NSLog(@"Partage par mail selectionné !");
    } else {
        NSLog(@"Option annuler selectionnée !");
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
