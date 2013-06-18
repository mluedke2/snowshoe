//
//  ViewController.h
//  SimpleExample
//
//  Created by Matt Luedke on 9/6/12.
//  Copyright (c) 2012 Matt Luedke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnowShoe.h"

@class SnowShoe;

@interface ViewController : UIViewController {
    
    SnowShoe *snowshoe;
    
}

@property(nonatomic, strong) SnowShoe *snowshoe;

-(IBAction)activateSnowShoe:(id)sender;

@end
