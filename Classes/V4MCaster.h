//
//  V4MCaster.h
//  Vote4Mihir
//
//  Created by Vishnu on 8/17/10.
//  Copyright 2010 Singapore. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface V4MCaster : NSObject {
	NSString *fname;
	NSString *lname;
	NSString *pretext;
	NSString *domain;
	
	NSString *email;
}

@property (nonatomic, retain) NSString *fname;
@property (nonatomic, retain) NSString *lname;
@property (nonatomic, retain) NSString *email;

-(id)initWithPretext:(NSString *)ptext andDomain:(NSString *)dtext;

@end
