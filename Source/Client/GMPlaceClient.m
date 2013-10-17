//
//  GMPlaceClient.m
//  GMPlaceAPI
//
//  Created by Ignacio Romero Zurbuchen on 7/8/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//

#import "GMPlaceClient.h"

static __unused NSString *_baseURL = @"https://maps.googleapis.com/maps/api/";
static __unused NSString *_consumerKey = nil;

@interface GMPlaceClient()
@end

@implementation GMPlaceClient

+ (GMPlaceClient *)sharedClient
{
    static GMPlaceClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[GMPlaceClient alloc] initWithBaseURL:[NSURL URLWithString:_baseURL]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)URL
{
    self = [super initWithBaseURL:URL];
    
    if (self)
    {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self setDefaultHeader:@"Content-Encoding" value:@"gzip"];
        [self setDefaultHeader:@"Accept-Encoding" value:@"gzip"];
        
        [self setParameterEncoding:AFJSONParameterEncoding];
        [self setStringEncoding:NSUTF8StringEncoding];
        
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:8 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
        [NSURLCache setSharedURLCache:URLCache];
    }
    return self;
}

+ (void)registerClientWithConsumerKey:(NSString *)key
{
    _consumerKey = key;
}

+ (NSString *)consumerKey
{
    return _consumerKey;
}

- (void)cancelAllRequests
{
    [self.operationQueue cancelAllOperations];
}

@end
