//
//  Filters.h
//  feedME
//
//  Created by Aparna Jain on 6/16/14.
//  Copyright (c) 2014 FOX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filters : NSObject

@property (nonatomic, strong) NSString *searchTerm;
@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableDictionary *parametersArray;
@property (nonatomic, assign) NSInteger sortTypeIndex;
@property (nonatomic, assign) NSInteger radiusIndex;
@property (nonatomic, assign) BOOL dealOnly;

- (NSDictionary *) searchParams;
- (void)updateFilters;



@end
