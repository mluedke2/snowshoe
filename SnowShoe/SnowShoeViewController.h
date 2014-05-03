#import <UIKit/UIKit.h>

static NSString * const waiting = @"waiting";

@interface SnowShoeViewController : UIViewController

@property (nonatomic, retain) NSString *appSecret;
@property (nonatomic, retain) NSString *appKey;

- (void)stampResultDidChange:(NSString *)newResult;

@end
