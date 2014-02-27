//
//  DetailViewController.h
//  AppBeacons
//
//  Created by Sara Subijana Gracia on 27/02/14.
//  Copyright (c) 2014 Autentia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
