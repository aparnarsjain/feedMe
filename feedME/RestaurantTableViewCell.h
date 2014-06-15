//
//  RestaurantTableViewCell.h
//  feedME
//
//  Created by Aparna Jain on 6/12/14.
//  Copyright (c) 2014 FOX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;

@interface RestaurantTableViewCell : UITableViewCell
@property (nonatomic, strong) Restaurant *restaurant;

@property (weak, nonatomic) IBOutlet UIImageView *imgRestaurant;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewRatings;
@property (weak, nonatomic) IBOutlet UILabel *lblCuisine;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@end
