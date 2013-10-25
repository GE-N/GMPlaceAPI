//
//  GMParserProtocol.h
//  GMPlaceAPI
//
//  Created by Ignacio Romero Zurbuchen on 7/8/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GMParserSearch = 1,
    GMParserGeocode
} GMParser;

/** Protocol for the parsers that process the responses from the server. */
@protocol GMParserProtocol <NSObject>

@required

/** Returns a new instance of the receiving class based on the result of parsing a JSON data structure representation.
 *
 * @param dict A parsed JSON data into a collection.
 * @param parser The parser type to be applied.
 * @returns The new instance.
 */
- (id)initWithObject:(NSDictionary *)dict withParser:(GMParser)parser;

@optional

/**
 * Returns an array of parsed JSON data structure representations.
 *
 * @param objects The objects to be parsed.
 * @param parser The parser type to be applied.
 * @returns The parsed array.
 */
+ (NSArray *)serializeObjects:(id)objects withParser:(GMParser)parser;

@end
