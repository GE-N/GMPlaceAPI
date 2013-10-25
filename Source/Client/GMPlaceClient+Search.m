//
//  GMPlaceClient+Search.m
//  GMPlaceAPI
//
//  Created by Ignacio Romero Zurbuchen on 7/8/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//

#import "GMPlaceClient+Search.h"
#import "GMPlace.h"

@implementation GMPlaceClient (Search)

- (void)searchPlacesForName:(NSString *)name
                    success:(void (^)(NSArray *places))success
                    failure:(void (^)(NSError *error))failure
{
    NSAssert([GMPlaceClient consumerKey] != nil, @"The client requieres a valid consumer key to do any request.");
    
    [self cancelAllRequests];
    
    GMSuccessBlock _success = [success copy];
    GMFailureBlock _failure = [failure copy];
    
    NSString *path = [NSString stringWithFormat:@"place/search/json?sensor=%@&key=%@",self.sensor ? @"true":@"false", [GMPlaceClient consumerKey]];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:name forKey:@"name"];
    
    if ((CLLocationCoordinate2DIsValid(self.southWestBounds) && (self.southWestBounds.latitude > 0 && self.southWestBounds.longitude > 0)) &&
        (CLLocationCoordinate2DIsValid(self.northEastBounds) && (self.northEastBounds.latitude > 0 && self.northEastBounds.longitude > 0))) {
        
        NSString *bounds = [NSString stringWithFormat:@"%f,%f|%f,%f", self.southWestBounds.latitude, self.southWestBounds.longitude, self.northEastBounds.latitude, self.northEastBounds.longitude];
        [params setObject:bounds forKey:@"bounds"];
    }
    
    if (CLLocationCoordinate2DIsValid(self.userLocation) && (self.userLocation.latitude > 0 && self.userLocation.longitude > 0)) {
        NSString *location = [NSString stringWithFormat:@"%f,%f", self.userLocation.latitude, self.userLocation.longitude];
        [params setObject:location forKey:@"location"];
    }
    
    NSString *radius = [NSString stringWithFormat:@"%d", self.radius];
    [params setObject:radius forKey:@"location"];
        
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
