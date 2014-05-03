#import "AppDelegate.h"
#import "StampViewController.h"

static NSString * const snowshoe_app_key = @"your_key";
static NSString * const snowshoe_app_secret = @"your_secret";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    StampViewController *stampViewController = [[StampViewController alloc] initWithNibName:@"StampViewController" bundle:nil];
    
    stampViewController.appKey = snowshoe_app_key;
    stampViewController.appSecret = snowshoe_app_secret;
    
    self.window.rootViewController = stampViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
