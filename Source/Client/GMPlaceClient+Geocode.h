//
//  GMPlaceClient+Geocode.h
//  GMPlaceAPI
//
//  Created by Ignacio Romero Zurbuchen on 7/8/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//

#import "GMPlaceClient.h"

@interface GMPlaceClient (Geocode)

- (void)geocodedPlacesForName:(NSString *)name
                      success:(void (^)(NSArray *places))success
                      failure:(void (^)(NSError *error))failure;

@end