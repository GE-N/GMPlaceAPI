//
//  GMPlaceClient+SearchBy.h
//  GeoSearch
//
//  Created by Jerapong Nampetch on 1/21/2557 BE.
//  Copyright (c) 2557 DZN Labs. All rights reserved.
//

#import "GMPlaceClient.h"

@interface GMPlaceClient (SearchBy)

- (void)searchNearbyLocation:(CLLocationCoordinate2D)location
                     success:(void (^)(NSArray *places))success
                     failure:(void (^)(NSError *error))failure;

@end
