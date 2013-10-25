//
//  GMPlaceClient+Geocode.m
//  GMPlaceAPI
//
//  Created by Ignacio Romero Zurbuchen on 7/8/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//

#import "GMPlaceClient+Geocode.h"
#import "GMPlace.h"

@implementation GMPlaceClient (Geocode)

- (void)geocodedPlacesForName:(NSString *)name
                      success:(void (^)(NSArray *places))success
                      failure:(void (^)(NSError *error))failure
{
    GMSuccessBlock _success = [success copy];
    GMFailureBlock _failure = [failure copy];
    
    NSAssert((name != nil || name.length > 0), @"The place name cannot be empty or nil");

    NSString *path = [NSString stringWithFormat:@"geocode/json?sensor=%@",self.sensor ? @"true":@"false"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:name forKey:@"address"];
    
    if ((CLLocationCoordinate2DIsValid(self.southWestBounds) && (self.southWestBounds.latitude > 0 && self.southWestBounds.longitude > 0)) &&
        (CLLocationCoordinate2DIsValid(self.northEastBounds) && (self.northEastBounds.latitude > 0 && self.northEastBounds.longitude > 0))) {
        
        NSString *bounds = [NSString stringWithFormat:@"%f,%f|%f,%f", self.southWestBounds.latitude, self.southWestBounds.longitude, self.northEastBounds.latitude, self.northEastBounds.longitude];
        [params setObject:bounds forKey:@"bounds"];
    }
    
    [self getPath:path
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id JSON){
              
              NSLog(@"geocodedPlacesForName operation : %@",operation.request.URL.absoluteString);
              
              NSArray *places = [GMPlace serializeObjects:JSON withParser:GMParserGeocode];
              _success(places);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error){
              _failure(error);
          }];
}

@end
