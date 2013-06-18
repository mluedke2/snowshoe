#import <UIKit/UIKit.h>
#import "SnowShoe.h"

@class SnowShoe;

@interface ViewController : UIViewController {
    
    SnowShoe *snowshoe;
    
}

@property(nonatomic, strong) SnowShoe *snowshoe;

-(IBAction)activateSnowShoe:(id)sender;

@end
