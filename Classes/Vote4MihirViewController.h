//
//  Vote4MihirViewController.h
//  Vote4Mihir
//
//  Created by Vishnu on 8/17/10.
//  Copyright Singapore 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Vote4MihirViewController : UIViewController {
	IBOutlet UILabel *voteLabel;
	IBOutlet UIActivityIndicatorView *activityView;
}

-(IBAction)moreInfoClicked;
-(IBAction)refreshVotesClicked;
-(IBAction)votePage;

@end

