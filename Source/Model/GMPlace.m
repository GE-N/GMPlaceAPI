//
//  GMPlace.m
//  GMPlaceAPI
//
//  Created by Ignacio Romero Zurbuchen on 7/8/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//

#import "GMPlace.h"

@implementation GMPlace
@synthesize location = _location;
@synthesize name = _name;

#pragma mark - ADParserProtocol Methods

- (id)initWithObject:(NSDictionary *)dict withParser:(GMParser)parser
{
    if (dict) {
        self = [super init];
        
        NSDictionary *geometry = [dict objectForKey:@"geometry"];
        NSDictionary *location = [geometry objectForKey:@"location"];
        float latitude = [[location objectForKey:@"lat"] doubleValue];
        float longitude = [[location objectForKey:@"lng"] doubleValue];
        
        _location = CLLocationCoordinate2DMake(latitude, longitude);
        
        if (parser == GMParserSearch) {
            _name = [dict objectForKey:@"name"];
        }
        else if (parser == GMParserGeocode) {
            _name = [dict objectForKey:@"formatted_address"];
        }

        return self;
    }
    return nil;
}

- (NSString *)attributes
{
    return [NSString stringWithFormat:@"Place name : %@ | location : %f, %f ", _name, _location.latitude, _location.longitude];
}

+ (NSArray *)serializeObjects:(id)objects withParser:(GMParser)parser
{
    NSArray *array = [objects objectForKey:@"results"];
    NSMutableArray *users = [NSMutableArray new];
    
    for (id object in array) {
        GMPlace *user = [[GMPlace alloc] initWithObject:object withParser:parser];
        [users addObject:user];
    }
    
    return users;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ <%f,%f> %@", [super description], self.location.latitude, self.location.longitude, self.name];
}

@end
