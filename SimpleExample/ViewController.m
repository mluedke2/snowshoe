//
//  ViewController.m
//  FakeClientApp
//
//  Created by Matt Luedke on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize snowshoe;

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"Status: %@", [change valueForKey:@"new"]);
  //  NSLog(@"{\"head\":{\"total\":2,\"page\":0},\"body\":[{\"_ClassName\":\"StampObject\",\"SerialNum\":\"D1209050090\",\"Namespace\":\"snowshoe.dev\",\"CreDate\":\"Sep 08 2012 11:51 AM\",\"IdStampState\":null},{\"_ClassName\":\"StampObject\",\"SerialNum\":\"D1209050090\",\"Namespace\":\"snowshoe.dev.2\",\"CreDate\":\"Sep 08 2012 12:22 PM\",\"IdStampState\":null}]}");
}

-(IBAction)activateSnowShoe:(id)sender {
   
    if (snowshoe == nil) {
        self.snowshoe = [[SnowShoe alloc] init];
        snowshoe.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [snowshoe addObserver:self forKeyPath:@"stampResult" options:NSKeyValueObservingOptionNew context:nil];
    }
 //   [self presentModalViewController:snowshoe animated:YES];
    [self presentViewController:snowshoe animated:YES completion:NULL];
    [snowshoe isReadyForStampWithId:@"a89e23b2ea0a6c31113b" andSecret:@"fc66b715fa44b359b6a4e293a8e970024d74fc5f"];
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
