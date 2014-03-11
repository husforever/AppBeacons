#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailProxUUIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailMajorLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailMinorLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailProximityLabel;
@end
