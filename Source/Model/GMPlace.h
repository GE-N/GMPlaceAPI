//
//  GMPlace.h
//  GMPlaceAPI
//
//  Created by Ignacio Romero Zurbuchen on 7/8/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "GMParserProtocol.h"

@interface GMPlace : NSObject <GMParserProtocol>

@property (nonatomic) CLLocationCoordinate2D location;
@property (nonatomic, strong) NSString *name;

@end