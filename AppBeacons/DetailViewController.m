//
//  DetailViewController.m
//  AppBeacons
//
//  Created by Sara Subijana Gracia on 27/02/14.
//  Copyright (c) 2014 Autentia. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        CLBeacon *detailBeacon = (CLBeacon *)self.detailItem;
        NSString *beaconProxUUIDLabel = [NSString stringWithFormat:@"ProximityUUID: %@", [detailBeacon.proximityUUID UUIDString]];
        self.detailProxUUIDLabel.text = beaconProxUUIDLabel;
        NSString *beaconMajorLabel = [NSString stringWithFormat:@"Major: %ld", (long)detailBeacon.major.integerValue];
        self.detailMajorLabel.text = beaconMajorLabel;
        NSString *beaconMinorLabel = [NSString stringWithFormat:@"Minor: %ld", (long)detailBeacon.minor.integerValue];
        self.detailMinorLabel.text = beaconMinorLabel;
        NSString *beaconProximityLabel = nil;
        switch (detailBeacon.proximity) {
            case CLProximityImmediate:
                beaconProximityLabel = @"Proximity: inmediate (0 - 20 cm)";
                break;
            case CLProximityNear:
                beaconProximityLabel = @"Proximity: near (20cm - 2m)";
                break;
            case CLProximityFar:
                beaconProximityLabel = @"Proximity: far (2m - 70m)";
                break;
            case CLProximityUnknown:
            default:
                beaconProximityLabel = @"Proximity: unknown";
                break;
        }
        self.detailProximityLabel.text = beaconProximityLabel;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
