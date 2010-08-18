//
//  V4MVoter.h
//  Vote4Mihir
//
//  Created by Vishnu on 8/17/10.
//  Copyright 2010 Singapore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASINetworkQueue.h"

@interface V4MVoter : UIViewController <UIAlertViewDelegate>{
	IBOutlet UITextField *nameField;
	IBOutlet UITextField *domainField;
	IBOutlet UITextField *votesField;
	IBOutlet UIActivityIndicatorView *activityView;
	
	NSMutableArray *arrayOfEmails;
	
	ASINetworkQueue *networkQueue;
}

@property (retain) ASINetworkQueue *networkQueue;

-(IBAction)backToHome;
-(IBAction)generateEmailsClicked;

@end
