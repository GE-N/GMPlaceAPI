//
//  GMPlaceClient+SearchBy.m
//  GeoSearch
//
//  Created by Jerapong Nampetch on 1/21/2557 BE.
//  Copyright (c) 2557 DZN Labs. All rights reserved.
//

#import "GMPlaceClient+SearchBy.h"
#import "GMPlace.h"

@implementation GMPlaceClient (SearchBy)

- (void)searchNearbyLocation:(CLLocationCoordinate2D)location
                     success:(void (^)(NSArray *places))success
                     failure:(void (^)(NSError *error))failure
{
    NSAssert([GMPlaceClient consumerKey] != nil, @"The client requieres a valid consumer key to do any request.");
    
    [self cancelAllRequests];
    
    GMSuccessBlock _success = [success copy];
    GMFailureBlock _failure = [failure copy];
    
    NSString *path = [NSString stringWithFormat:@"place/nearbysearch/json?sensor=%@&key=%@",self.sensor ? @"true":@"false", [GMPlaceClient consumerKey]];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *locationStr = [NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude];
    [params setObject:locationStr forKey:@"location"];
    
    NSString *radius = [NSString stringWithFormat:@"%d", self.radius];
    [params setObject:radius forKey:@"radius"];
    
    [self getPath:path
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id JSON){
              NSArray *places = [GMPlace serializeObjects:JSON withParser:GMParserSearch];
              _success(places);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error){
              _failure(error);
          }];

}

@end
