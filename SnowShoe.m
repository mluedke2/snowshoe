//
//  SnowShoe.m
//  SnowShoe
//
//  Created by Matt Luedke on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SnowShoe.h"
#import "GTMOAuthAuthentication.h"

@implementation SnowShoe

@synthesize app_secret, app_id, stampResult, scan, PPMM;

- (void)handleRealTap:(UIGestureRecognizer *)sender {
    
    self.stampResult = @"waiting";
    
    if (self.app_id.length > 0 && self.app_secret.length > 0 ) {
        
        [self determinePPMM];
        
        CGPoint tapPoint0 = [sender locationOfTouch:0 inView:self.view];
        CGPoint tapPoint1 = [sender locationOfTouch:1 inView:self.view];
        CGPoint tapPoint2 = [sender locationOfTouch:2 inView:self.view];
        CGPoint tapPoint3 = [sender locationOfTouch:3 inView:self.view];
        CGPoint tapPoint4 = [sender locationOfTouch:4 inView:self.view];
        
        NSDictionary *latestStamp = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(tapPoint0.x/self.PPMM.floatValue)], @"x1",[NSNumber numberWithFloat:(tapPoint1.x/self.PPMM.floatValue)], @"x2", [NSNumber numberWithFloat:(tapPoint2.x/self.PPMM.floatValue)], @"x3", [NSNumber numberWithFloat:(tapPoint3.x/self.PPMM.floatValue)], @"x4", [NSNumber numberWithFloat:(tapPoint4.x/self.PPMM.floatValue)], @"x5", [NSNumber numberWithFloat:(tapPoint0.y/self.PPMM.floatValue)], @"y1", [NSNumber numberWithFloat:(tapPoint1.y/self.PPMM.floatValue)], @"y2", [NSNumber numberWithFloat:(tapPoint2.y/self.PPMM.floatValue)], @"y3", [NSNumber numberWithFloat:(tapPoint3.y/self.PPMM.floatValue)], @"y4", [NSNumber numberWithFloat:(tapPoint4.y/self.PPMM.floatValue)], @"y5", nil];
        
        [self goOnlineAndCheckPoints:latestStamp]; 
        
    } else {
        self.stampResult = @"error";
    }
}


- (void)determinePPMM {
    
    // read device type, save
    
    // find if a multiplier is needed, based on
    // 163 dpi for iphone / 132 dpi for iPad 1+2
    
    // this is now not necessary -- server scales accordingly
    
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"]) {
        self.PPMM = [NSNumber numberWithFloat:5.197];
    } else {
        self.PPMM = [NSNumber numberWithFloat:6.417];
    }
    
}

- (void)goBack:(UISwipeGestureRecognizer *)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}


-(void)goOnlineAndCheckPoints:(NSDictionary *)points {
    
    // initialize the data that we'll be getting back, and start the request string with the baseURL
	responseData = [[NSMutableData data] retain];
	
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
    
    // key a89e23b2ea0a6c31113b
    
    // secret fc66b715fa44b359b6a4e293a8e970024d74fc5f
     
     GTMOAuthAuthentication *auth = [[GTMOAuthAuthentication alloc] initWithSignatureMethod:kGTMOAuthSignatureMethodHMAC_SHA1 consumerKey:self.app_id privateKey:self.app_secret] ;

    [auth addRequestTokenHeaderToRequest:request];
    
    [request setHTTPMethod:@"GET"];

	[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
	// the actual data is received in the connectionDidFinishLoading function	
}

- (void)isReadyForStampWithId:(NSString *)yourAppId andSecret:(NSString *)yourAppSecret {
    
    self.app_secret = yourAppSecret;
    self.app_id = yourAppId;
    return;
}


- (void)loading {
	
	if ([self.stampResult isEqualToString:@"waiting"]) {
        activityIndicator.hidden = NO;
		[activityIndicator startAnimating];
    } else {
        if (activityIndicator.hidden == NO) {
            [activityIndicator stopAnimating];
            activityIndicator.hidden = YES;
		}
    }
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
    
    
    UISwipeGestureRecognizer *swipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)] autorelease];
    
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
    
    // initialize the timer
	timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(loading) userInfo:nil repeats:YES];
    
    // reset the stamp result and the apiKey
    self.stampResult = @"none";
    self.app_id = @"";
    self.app_secret = @"";
    self.scan.alpha = 0.0;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    
    // end timer
    [timer invalidate];
    
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
	[connection release];
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	[responseData release];
    
    NSLog(@"responseString: %@", responseString);
    
	if (responseString == nil || [responseString rangeOfString:@"Exception"].location != NSNotFound) {
		
		self.stampResult = @"error";
        NSLog(@"%@", self.stampResult);
		return;
	} 		
    
    // this next line!
    self.stampResult = responseString;
    
	[responseString release];
    
    [self dismissModalViewControllerAnimated:YES];
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
}

@end
