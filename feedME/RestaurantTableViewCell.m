//
//  RestaurantTableViewCell.m
//  feedME
//
//  Created by Aparna Jain on 6/12/14.
//  Copyright (c) 2014 FOX. All rights reserved.
//

#import "RestaurantTableViewCell.h"
#import "Restaurant.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>


@implementation RestaurantTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    [self.imgRestaurant.layer setCornerRadius:5.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) setRestaurant:(Restaurant *)restaurant{
    _restaurant = restaurant;
    self.lblName.text = restaurant.name;
    self.lblAddress.text = restaurant.address;
    self.lblCuisine.text = restaurant.cuisine;
    [self.imgViewRatings setImageWithURL:[NSURL URLWithString:restaurant.ratingImageUrl]];
    [self.imgRestaurant setImageWithURL:[NSURL URLWithString:restaurant.imageUrl]];
}
@end
