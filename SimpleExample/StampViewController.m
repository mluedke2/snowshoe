//
//  StampViewController.m
//  SimpleExample
//
//  Created by Matt Luedke on 5/2/14.
//  Copyright (c) 2014 Matt Luedke. All rights reserved.
//

#import "StampViewController.h"

@interface StampViewController ()

@end

@implementation StampViewController

-(void)stampResultDidChange:(NSString *)stampResult
{
    [super stampResultDidChange:stampResult];
    
    NSLog(@"Status: %@", stampResult);
    
    NSData *jsonData = [stampResult dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e;
    NSDictionary *resultObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];
    
    if (resultObject != NULL) {
        // the result is a valid JSON, and we will now parse it
        
        if ([resultObject objectForKey:@"stamp"] != nil) {
            NSString *stampSerial = [[resultObject objectForKey:@"stamp"] objectForKey:@"serial"];
            NSLog(@"Success! Your stamp serial number is %@. You should go do something awesome with this knowledge.", stampSerial);
            
        } else {
            // Failure
            NSLog(@"The stamp didn't return any valid serials. You should now do something with this knowledge, like tell your user to use a valid stamp or try again.");
        }
    }
}

@end
