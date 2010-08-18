//
//  Vote4MihirViewController.m
//  Vote4Mihir
//
//  Created by Vishnu on 8/17/10.
//  Copyright Singapore 2010. All rights reserved.
//

#import "Vote4MihirViewController.h"
#import "ASIHTTPRequest.h"
#import "V4MVoter.h"

@implementation Vote4MihirViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self refreshVotesClicked];
}

-(IBAction)moreInfoClicked{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Help the poor african kid" message:@"Mihir is a poor little boy who's only intention in life is to fly to Beijing to intoxicate some pollution. With the help of us Punjus we can achieve this" delegate:nil cancelButtonTitle:@"Okay sire..." otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(IBAction)votePage{
	V4MVoter *viewController = [[V4MVoter alloc] initWithNibName:@"V4MVoter" bundle:nil];
	viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[self presentModalViewController:viewController animated:YES];
}

- (IBAction)refreshVotesClicked
{
	[voteLabel setText:@""];
	[activityView startAnimating];
	
	NSURL *url = [NSURL URLWithString:@"http://create2011.com.sg/top10/top10Detailed.aspx?id=17&cat=S"];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSString *responseString = [request responseString];
	
	NSArray *arr = [responseString componentsSeparatedByString:@"<div class=\"top10_detailed_number_vote\">"];
	NSArray *arr2 = [[arr objectAtIndex:1] componentsSeparatedByString:@"</div><div class=\"top10_detailed_votes\"></div></div>"];
	NSArray *arr3 = [[arr2 objectAtIndex:0] componentsSeparatedByString:@"<img src=\"../images/number/"];
	
	NSMutableString *resultStr = [[NSMutableString alloc] init];
	int i=0;
	for (NSString *s in arr3) {
		i++;
		if (i==1) {
			continue;
		}
		NSArray *arr = [s componentsSeparatedByString:@".gif\" style=\"border:none\"/>"];
		[resultStr appendString:[arr objectAtIndex:0]];
	}
	[voteLabel setText:[NSString stringWithFormat:@"%i",[resultStr intValue]]];
	
	[activityView stopAnimating];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
