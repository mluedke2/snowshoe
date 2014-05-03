#import "SnowShoe.h"
#import <GTMOAuthAuthentication.h>

@implementation SnowShoe

@synthesize appSecret, appKey, stampResult;

- (void)handleRealTap:(UIGestureRecognizer *)sender {
    
    self.stampResult = @"waiting";
    
    if (self.appKey.length > 0 && self.appSecret.length > 0 ) {
        
        CGPoint tapPoint0 = [sender locationOfTouch:0 inView:self.view];
        CGPoint tapPoint1 = [sender locationOfTouch:1 inView:self.view];
        CGPoint tapPoint2 = [sender locationOfTouch:2 inView:self.view];
        CGPoint tapPoint3 = [sender locationOfTouch:3 inView:self.view];
        CGPoint tapPoint4 = [sender locationOfTouch:4 inView:self.view];
        
        NSDictionary *latestStamp = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:tapPoint0.x], @"x1",[NSNumber numberWithFloat:tapPoint1.x], @"x2", [NSNumber numberWithFloat:tapPoint2.x], @"x3", [NSNumber numberWithFloat:tapPoint3.x], @"x4", [NSNumber numberWithFloat:tapPoint4.x], @"x5", [NSNumber numberWithFloat:tapPoint0.y], @"y1", [NSNumber numberWithFloat:tapPoint1.y], @"y2", [NSNumber numberWithFloat:tapPoint2.y], @"y3", [NSNumber numberWithFloat:tapPoint3.y], @"y4", [NSNumber numberWithFloat:tapPoint4.y], @"y5", nil];
        
        [self goOnlineAndCheckPoints:latestStamp]; 
        
    } else {
        self.stampResult = @"error: neither appKey nor appSecret can be empty";
    }
}

- (void)goBack:(UISwipeGestureRecognizer *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)goOnlineAndCheckPoints:(NSDictionary *)points {
    
    // initialize the data that we'll be getting back, and start the request string with the baseURL
	responseData = [NSMutableData data];
	
	// start off the string with the base URL
	NSString *requestString = @"http://beta.snowshoestamp.com/api/v2/stamp?";
    
    requestString = [requestString stringByAppendingFormat:@"x1=%@", [points objectForKey:@"x1"]];
    
    requestString = [requestString stringByAppendingFormat:@"&x2=%@", [points objectForKey:@"x2"]];
    
    requestString = [requestString stringByAppendingFormat:@"&x3=%@", [points objectForKey:@"x3"]];
    
    requestString = [requestString stringByAppendingFormat:@"&x4=%@", [points objectForKey:@"x4"]];
    
    requestString = [requestString stringByAppendingFormat:@"&x5=%@", [points objectForKey:@"x5"]];
    
    requestString = [requestString stringByAppendingFormat:@"&y1=%@", [points objectForKey:@"y1"]];
    
    requestString = [requestString stringByAppendingFormat:@"&y2=%@", [points objectForKey:@"y2"]];
    
    requestString = [requestString stringByAppendingFormat:@"&y3=%@", [points objectForKey:@"y3"]];
    
    requestString = [requestString stringByAppendingFormat:@"&y4=%@", [points objectForKey:@"y4"]];
    
    requestString = [requestString stringByAppendingFormat:@"&y5=%@", [points objectForKey:@"y5"]];
       
     NSURL *url = [NSURL URLWithString:requestString];
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // this method is from the gtm-oauth package.
     GTMOAuthAuthentication *auth = [[GTMOAuthAuthentication alloc] initWithSignatureMethod:kGTMOAuthSignatureMethodHMAC_SHA1 consumerKey:self.appKey privateKey:self.appSecret] ;

    [auth addRequestTokenHeaderToRequest:request];
    
    [request setHTTPMethod:@"GET"];

	[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
	// the actual data is received in the connectionDidFinishLoading function	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // initialize the gesture recognizer
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleRealTap:)];
    
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 5;
    
    [self.view addGestureRecognizer:tapRecognizer];
    
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
    
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    swipeRecognizer.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:swipeRecognizer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        
    // reset the stamp result and the apiKey
    self.stampResult = @"none";
    activityIndicator.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
    self.stampResult = responseString;
    
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"%@", [NSString stringWithFormat:@"Connection failed: %@", [error description]]);
	self.stampResult = @"error";
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
}

@end
