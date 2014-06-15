//
//  YelpClient.h
//  feedME
//
//  Created by Aparna Jain on 6/13/14.
//  Copyright (c) 2014 FOX. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"

@interface YelpClient : BDBOAuth1RequestOperationManager
- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret;

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
