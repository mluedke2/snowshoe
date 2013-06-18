//
//  SnowShoe.h
//  SnowShoe
//
//  Created by Matt Luedke on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnowShoe : UIViewController {
    
    NSMutableData *responseData;
    
    NSString *app_secret;
    NSString *app_id;
    NSNumber *PPMM;
    
    NSString *stampResult;
    
    IBOutlet UIImageView *scan;
    IBOutlet UIActivityIndicatorView *activityIndicator;
	NSTimer *timer;
}
@property (nonatomic, retain) IBOutlet UIImageView *scan;
@property (nonatomic, retain) NSString *app_secret;
@property (nonatomic, retain) NSString *app_id;
@property (nonatomic, retain) NSNumber *PPMM;
@property (nonatomic, retain) NSString *stampResult;

- (void)isReadyForStampWithId:(NSString *)yourAppId andSecret:(NSString *)yourAppSecret;

@end
