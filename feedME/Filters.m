//
//  Filters.m
//  feedME
//
//  Created by Aparna Jain on 6/16/14.
//  Copyright (c) 2014 FOX. All rights reserved.
//

#import "Filters.h"
@interface Filters()
@property (nonatomic, strong) NSDictionary *allCategories;
@end

@implementation Filters

- (id) init {
    self = [super init];
    self.allCategories = @{@"Active Life": @"active", @"Arts & Entertainment" : @"arts", @"Automotive" : @"auto", @"Beauty & Spas" : @"beautysvc", @"Education" : @"education", @"Event Planning & Services" : @"eventservices", @"Financial Services" : @"financialservices", @"Food" : @"food", @"Health & Medical" : @"health", @"Home Services" : @"homeservices", @"Hotels & Travel" : @"hotelstravel", @"Local Services" : @"localservices", @"Nightlife" : @"nightlife", @"Pets" : @"pets", @"Professional Services" : @"professional", @"Public Services & Government" : @"publicservicesgovt", @"Real Estate" : @"realestate", @"Restaurants" : @"restaurants", @"Shopping" : @"shopping"};

    self.sections = @[@{@"title" :@"Distance", @"rows": @[@"Auto", @"2 blocks", @"4 blocks", @"1 mile", @"2 miles"]},
                      @{@"title" :@"Sort by", @"rows": @[@"Best Matched", @"Distance", @"Highest Rated"]},
                      @{@"title" :@"Categories", @"rows": [self.allCategories allKeys]}
        ];
    self.categories = [[NSMutableArray alloc] init];
    self.radiusIndex = 0;
    self.sortTypeIndex = 0;
    self.parametersArray = [NSMutableDictionary dictionary];
    return self;
}

- (NSDictionary *)searchParams {
    NSMutableDictionary *parameters = [@{@"location" : @"San Francisco"} mutableCopy];
    
    int radiusIndex = [[NSUserDefaults standardUserDefaults] objectForKey:@"radius_filter"]? [[[NSUserDefaults standardUserDefaults] objectForKey:@"radius_filter"] intValue] : -1;
    int sortIndex = [[NSUserDefaults standardUserDefaults] objectForKey:@"sort"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"sort"] intValue] : -1;
    
    
    if (self.searchTerm) {
        parameters[@"term"] = self.searchTerm;
    }
    if (radiusIndex > 0) {
        parameters[@"radius_filter"] = @[@"200", @"400", @"1600", @"3200"][radiusIndex-1];
    }
    if(sortIndex > 0){
        parameters[@"sort"] = [[NSString alloc] initWithFormat:@"%d", sortIndex];
    }
    if ([self.sections count] > 0){
        NSMutableArray *a = [[NSMutableArray alloc] init];
        for(NSNumber *i in self.categories){
            [a addObject:self.allCategories[self.sections[2][@"rows"][[i integerValue]]]];
        }
        parameters[@"category_filter"] = [a componentsJoinedByString:@","];
    }
    return [parameters copy];
}
- (void)updateFilters {
    
}
@end
