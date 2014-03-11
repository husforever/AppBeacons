#import "MasterViewController.h"

#import "DetailViewController.h"

#pragma mark - Constants iBeacons info
static NSString * const kIBeaconUUID = @"F7826DA6-4FA2-4E98-8024-BC5B71E0893E";
static NSString * const kRegionIdentifier = @"Kontakt.io";


@interface MasterViewController ()
    @property (nonatomic, strong) NSMutableArray *detectedBeacons;
    @property (nonatomic, strong) CLLocationManager *locationManager;
    @property (nonatomic, strong) CLBeaconRegion *beaconRegion;

@end

@implementation MasterViewController


- (void)insertNewObject:(id)sender
{
    if (!self.detectedBeacons) {
        self.detectedBeacons = [[NSMutableArray alloc] init];
    }
    [self.detectedBeacons insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state
              forRegion:(CLRegion *)region
{
    if (state == CLRegionStateInside) {
        NSLog(@"inside region");
        [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    } else {
        NSLog(@"not in region");
        [self.locationManager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}


- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    self.detectedBeacons = [NSMutableArray new];
    for (CLBeacon *beacon in beacons) {
        NSLog(@"%@",beacon);
        [self.detectedBeacons addObject:beacon];
    }
    [self.tableView reloadData];
}


#pragma mark - Table View and data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detectedBeacons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    CLBeacon *object = self.detectedBeacons[indexPath.row];
    
    
    NSLog(@"Beacon %@ monitorized with Major %ld and Minor: %ld",
          [object.proximityUUID UUIDString],
          (long)object.major.integerValue,
          (long)object.minor.integerValue);
    
    NSString *beaconLabel = [NSString stringWithFormat:
                             @"Beacon monitorized with Major %ld and Minor: %ld ",
                             (long)object.major.integerValue, (long)object.minor.integerValue];
    cell.textLabel.text = beaconLabel;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.detectedBeacons removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:kIBeaconUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:kRegionIdentifier];
    self.beaconRegion.notifyEntryStateOnDisplay = YES;
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    
    if (![CLLocationManager isRangingAvailable]) {
        NSLog(@"Couldn't turn on ranging: Ranging is not available.");
        return;
    }
    
    if (self.locationManager.rangedRegions.count > 0) {
        NSLog(@"Didn't turn on ranging: Ranging already on.");
    }
    
    [self.locationManager startMonitoringForRegion:self.beaconRegion];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.detectedBeacons[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}


@end
