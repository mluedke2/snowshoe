#import <UIKit/UIKit.h>

@interface SnowShoe : UIViewController {
    
    NSMutableData *responseData;
    NSString *stampResult;
    NSString *appSecret;
    NSString *appKey;
    IBOutlet UIActivityIndicatorView *activityIndicator;
}
@property (nonatomic, retain) NSString *stampResult;
@property (nonatomic, retain) NSString *appSecret;
@property (nonatomic, retain) NSString *appKey;

@end
