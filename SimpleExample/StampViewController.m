#import "StampViewController.h"

@interface StampViewController ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation StampViewController

-(void)stampResultDidChange:(NSString *)stampResult
{
    NSLog(@"Status: %@", stampResult);
    
    if ([stampResult isEqualToString:waiting]) {
        [self.activityIndicator startAnimating];
        return;
    } else {
        [self.activityIndicator stopAnimating];
    }
    
    NSData *jsonData = [stampResult dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e;
    NSDictionary *resultObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];
    
    if (resultObject != NULL) {
        // the result is a valid JSON, and we will now parse it
        
        if ([resultObject objectForKey:@"stamp"] != nil) {
            NSString *stampSerial = [[resultObject objectForKey:@"stamp"] objectForKey:@"serial"];
            NSLog(@"Success! Your stamp serial number is %@. You should go do something awesome with this knowledge.", stampSerial);
            
        } else {
            NSLog(@"The stamp didn't return any valid serials. You should now do something with this knowledge, like tell your user to use a valid stamp or try again.");
        }
    }
}

@end
