//
//  V4MVoter.m
//  Vote4Mihir
//
//  Created by Vishnu on 8/17/10.
//  Copyright 2010 Singapore. All rights reserved.
//

#import "V4MVoter.h"
#import "V4MCaster.h"

@implementation V4MVoter

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

-(IBAction)backToHome{
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)generateEmailsClicked{
	arrayOfEmails = [[NSMutableArray alloc] init];
	if ([domainField.text isEqualToString:@""]||[votesField.text isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please do not leave anything blank" delegate:nil cancelButtonTitle:@"KThxBye" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	if ([votesField.text intValue]>30) {
		[votesField setText:@"30"];
	}
	
	NSMutableString *collectionString = [NSMutableString stringWithString:@"Please verify before continuing:"];
	for (int i=0; i<=[votesField.text intValue]; i++) {
		V4MCaster *cast = [[V4MCaster alloc] initWithPretext:nameField.text andDomain:domainField.text];
		[collectionString appendFormat:@"\n%@",cast.email];
		[arrayOfEmails addObject:cast];
	}
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"We've generated emailz..." message:collectionString delegate:self cancelButtonTitle:@"Cast Votes" otherButtonTitles:@"Close",nil];
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if ([alertView.title isEqualToString:@"We've generated emailz..."]) {
		if (buttonIndex==0) {
			[self castVotes];
		}
	}
	else if([alertView.title isEqualToString:@"It's either done or it's not"]){
		if (buttonIndex==1) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:+65-90091516"]];
		}
	}
}

-(void)castVotes{
	[activityView startAnimating];
	NSLog(@"Cast Votes!");
	[[self networkQueue] cancelAllOperations];
	
	// Creating a new queue each time we use it means we don't have to worry about clearing delegates or resetting progress tracking
	[self setNetworkQueue:[ASINetworkQueue queue]];
	[[self networkQueue] setDelegate:self];
	[[self networkQueue] setRequestDidFinishSelector:@selector(requestFinished:)];
	[[self networkQueue] setRequestDidFailSelector:@selector(requestFailed:)];
	[[self networkQueue] setQueueDidFinishSelector:@selector(queueFinished:)];
	
	for (V4MCaster *caster in arrayOfEmails) {
		//NSString *fullName = [[NSString stringWithFormat:@"%@ %@",caster.fname, caster.lname] retain];
		NSString *str1 = @"http://create2011.com.sg/VoteEntry.aspx?eid=17&__EVENTARGUMENT=&__EVENTTARGET=&__EVENTVALIDATION=%2FwEWBQLw9emDAgLf6ZSyBwLEhISFCwKE8%2F26DALCi9reA1tPRiuEGNYU%2FgClhL2idDq8vVfi&__VIEWSTATE=%2FwEPDwULLTE5NDgyMjYzMjlkGAEFBm12Vm90ZQ8PZGZkp55WpW82jN%2BkparRC21%2BWPruzug%3D&btnSubmit=Submit&hfEntryId=17&tm_HiddenField=&txtEmail=";
		NSString *str = [NSString stringWithFormat:@"%@&txtName=%@", caster.email, [NSString stringWithFormat:@"%@%20%@",caster.fname,caster.lname]];
		
		NSString *fstring = [str1 stringByAppendingString:str];
		
		[fstring retain];
		
		NSURL *url2 = [[NSURL alloc] initWithString:fstring];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url2];
		
		
		[[self networkQueue] addOperation:request];
	}
	
	[[self networkQueue] go];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	// You could release the queue here if you wanted
	if ([[self networkQueue] requestsCount] == 0) {
		
		// Since this is a retained property, setting it to nil will release it
		// This is the safest way to handle releasing things - most of the time you only ever need to release in your accessors
		// And if you an Objective-C 2.0 property for the queue (as in this example) the accessor is generated automatically for you
		[self setNetworkQueue:nil]; 
	}
	
	//... Handle success
	NSLog(@"Request finished");
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	// You could release the queue here if you wanted
	if ([[self networkQueue] requestsCount] == 0) {
		[self setNetworkQueue:nil]; 
	}
	
	//... Handle failure
	NSLog(@"Request failed");
}


- (void)queueFinished:(ASINetworkQueue *)queue
{
	// You could release the queue here if you wanted
	if ([[self networkQueue] requestsCount] == 0) {
		[self setNetworkQueue:nil]; 
	}
	NSLog(@"Queue finished");
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"It's either done or it's not" message:@"Ok, so the votes have either been casted properly, or they've not. I could do a check to check whether they've actually been casted properly but I am too lazy.\nWhy don't you just go back to homepage and refresh and check the counter yourself? If vote is not casting properly, call Vishnu" delegate:self cancelButtonTitle:@"Ok, thanks" otherButtonTitles:@"Call Vishnu",nil];
	[alert show];
	[alert release];
	
	[activityView stopAnimating];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@synthesize networkQueue;
@end
