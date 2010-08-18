//
//  Vote4MihirAppDelegate.h
//  Vote4Mihir
//
//  Created by Vishnu on 8/17/10.
//  Copyright Singapore 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Vote4MihirViewController;

@interface Vote4MihirAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Vote4MihirViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Vote4MihirViewController *viewController;

@end

