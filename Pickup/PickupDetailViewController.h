//
//  PickupDetailViewController.h
//  Pickup
//
//  Created by ALAIN KHUON on 15/05/13.
//  Copyright (c) 2013 ALAIN KHUON. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface PickupDetailViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
{
    // View 2
    IBOutlet UIImageView *avatarImg;
    IBOutlet UILabel *pseudoLabel;
    IBOutlet UILabel *likeLabel;
    IBOutlet UILabel *dislikeLabel;
    
    // View 3
    IBOutlet UITextView *messageTextView;
    
    // View 4
    IBOutlet UIImageView *likeImg;
    IBOutlet UIImageView *dislikeImg;
    IBOutlet UIImageView *favImg;
}

// View 4
- (IBAction)likeButtonPush;
- (IBAction)dislikeButtonPush;
- (IBAction)favButtonPush;
- (IBAction)shareButtonPush;

@property (weak, nonatomic) UIActionSheet *actionSheet;

//@property (nonatomic, strong) IBOutlet UILabel *pickupLabel;
@property (nonatomic, strong) NSString *pickupName;

@end
