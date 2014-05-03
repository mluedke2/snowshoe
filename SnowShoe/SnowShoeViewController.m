#import "SnowShoeViewController.h"
#import <GTMOAuthAuthentication.h>

static NSString * const baseURL = @"http://beta.snowshoestamp.com/api/v2/stamp?";

@interface SnowShoeViewController()

@property (nonatomic, retain) NSMutableData *responseData;

@end

@implementation SnowShoeViewController

- (void)stampResultDidChange:(NSString *)newResult
{
    // override this method in your subclass
}

- (void)handleStamp:(UIGestureRecognizer *)sender {
    
    [self stampResultDidChange:waiting];
    
    if (self.appKey.length > 0 && self.appSecret.length > 0) {
        
        CGPoint tapPoint0 = [sender locationOfTouch:0 inView:self.view];
        CGPoint tapPoint1 = [sender locationOfTouch:1 inView:self.view];
        CGPoint tapPoint2 = [sender locationOfTouch:2 inView:self.view];
        CGPoint tapPoint3 = [sender locationOfTouch:3 inView:self.view];
        CGPoint tapPoint4 = [sender locationOfTouch:4 inView:self.view];
        
        // start with the base URL and add coordinates
        NSString *requestString = [baseURL stringByAppendingFormat:@"x1=%.2f&x2=%.2f&x3=%.2f&x4=%.2f&x5=%.2f&y1=%.2f&y2=%.2f&y3=%.2f&y4=%.2f&y5=%.2f", tapPoint0.x, tapPoint1.x, tapPoint2.x, tapPoint3.x, tapPoint4.x, tapPoint0.y, tapPoint1.y, tapPoint2.y, tapPoint3.y, tapPoint4.y];
        
        NSURL *url = [NSURL URLWithString:requestString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        // this method is from the gtm-oauth package.
        GTMOAuthAuthentication *auth = [[GTMOAuthAuthentication alloc] initWithSignatureMethod:kGTMOAuthSignatureMethodHMAC_SHA1 consumerKey:self.appKey privateKey:self.appSecret];
        
        [auth addRequestTokenHeaderToRequest:request];
        
        [request setHTTPMethod:@"GET"];
        
        __unused id x = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        // the actual data is received in the connectionDidFinishLoading method
        
    } else {
        [self stampResultDidChange:@"error: neither appKey nor appSecret can be empty"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initialize the gesture recognizer
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleStamp:)];
    
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 5;
    
    [self.view addGestureRecognizer:tapRecognizer];
    
    // initialize the data that we'll be getting back
	self.responseData = [NSMutableData data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString *responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
        
    [self stampResultDidChange:responseString];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[self stampResultDidChange:[NSString stringWithFormat:@"connection didFailWithError: %@", [error description]]];
}

@end
