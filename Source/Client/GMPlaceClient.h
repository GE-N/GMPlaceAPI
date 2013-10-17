//
//  GMPlaceClient.h
//  GMPlaceAPI
//
//  Created by Ignacio Romero Zurbuchen on 7/8/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AFIncrementalStore/AFRESTClient.h>

#import "GMPlaceAPIBlockProtocol.h"

@interface GMPlaceClient : AFRESTClient

@property (nonatomic) CLLocationCoordinate2D userLocation;
@property (nonatomic) CLLocationCoordinate2D southWestBounds;
@property (nonatomic) CLLocationCoordinate2D northEastBounds;
@property (nonatomic) NSString *language;
@property (nonatomic) NSUInteger radius;
@property (nonatomic) BOOL sensor;

+ (GMPlaceClient *)sharedClient;

+ (void)registerClientWithConsumerKey:(NSString *)key;
+ (NSString *)consumerKey;

- (void)cancelAllRequests;

@end
