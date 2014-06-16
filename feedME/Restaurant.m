//
//  Restaurant.m
//  feedME
//
//  Created by Aparna Jain on 6/13/14.
//  Copyright (c) 2014 FOX. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant


- (id)initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.address = dictionary[@"location"][@"address"][0];
        self.ratingImageUrl = dictionary[@"rating_img_url"];
        self.imageUrl = dictionary[@"image_url"];
        self.cuisine = [dictionary[@"categories"][0] componentsJoinedByString:@", "];
        self.noOfReviews = dictionary[@"review_count"];
    }
    return self;
    
}

+ (NSArray *)restaurantsWithArray: (NSArray *)array {
    NSMutableArray *restaurants = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array) {
        Restaurant *restaurant = [[Restaurant alloc] initWithDictionary:dictionary];
        [restaurants addObject:restaurant];
    }
    return restaurants;
}


@end
