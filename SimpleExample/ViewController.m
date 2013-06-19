#import "ViewController.h"

@implementation ViewController

@synthesize snowshoe;

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSString *stampResult = [change valueForKey:@"new"];
    
    NSLog(@"Status: %@", stampResult);
        
    NSData *jsonData = [stampResult dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e;
    NSDictionary *resultObject = [NSJSONSerialization JSONObjectWithData:jsonData options:nil error:&e];
     
    if (resultObject != NULL) {
        // the result is a valid JSON, and we will now parse it
        
        if ([resultObject objectForKey:@"stamp"] != nil) {
            // Success!
            
            NSString *stampSerial = [[resultObject objectForKey:@"stamp"] objectForKey:@"serial"];
            NSLog(@"Success! Your stamp serial number is %@. You should go do something awesome with this knowledge.", stampSerial);
            
        } else {
            // Failure
            NSLog(@"The stamp didn't return any valid serials. You should now do something awesome with this knowledge, like tell your user to use a valid stamp or try again.");
        }
        
    }
    
}

-(IBAction)activateSnowShoe:(id)sender {
   
    if (snowshoe == nil) {
        self.snowshoe = [[SnowShoe alloc] init];
        snowshoe.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [snowshoe addObserver:self forKeyPath:@"stampResult" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    [self presentViewController:snowshoe animated:YES completion:^(void){
        snowshoe.appId = @"a89e23b2ea0a6c31113b";
        snowshoe.appSecret = @"fc66b715fa44b359b6a4e293a8e970024d74fc5f";
    }];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
