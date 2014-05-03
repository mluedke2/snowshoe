#import "ViewController.h"
#import "StampViewController.h"

static NSString * const snowshoe_app_key = @"your_key";
static NSString * const snowshoe_app_secret = @"your_secret";

@implementation ViewController

-(IBAction)activateSnowShoe:(id)sender {
   
    StampViewController *stampViewController = [[StampViewController alloc] initWithNibName:@"StampViewController" bundle:nil];

    stampViewController.appKey = snowshoe_app_key;
    stampViewController.appSecret = snowshoe_app_secret;
    
    [self presentViewController:stampViewController animated:YES completion:nil];
}

@end
