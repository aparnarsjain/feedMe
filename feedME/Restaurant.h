//
//  Restaurant.h
//  feedME
//
//  Created by Aparna Jain on 6/13/14.
//  Copyright (c) 2014 FOX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *ratingImageUrl;
@property (nonatomic, strong) NSString *cuisine;

- (id)initWithDictionary: (NSDictionary *)dictionary;
+ (NSArray *)restaurantsWithArray: (NSArray *)array;

@end
