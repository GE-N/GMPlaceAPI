//
//  GMPlaceClientBlockProtocol.h
//  GMPlaceAPI
//
//  Created by Ignacio Romero Zurbuchen on 7/8/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GMSuccessBlock)(NSArray *places);
typedef void (^GMFailureBlock)(NSError *error);

/** A General Block protocol to be applied to most of the completion and failure block methods. */
@protocol GMPlaceClientBlockProtocol <NSObject>

/**
 * Sets the `completionBlock` property with a block that executes either the specified success or failure block, depending on the state of the request on completion. If `error` returns a value, which can be caused by an unacceptable status code or content type, then `failure` is executed. Otherwise, `success` is executed.
 *
 * This method is overridden in this subclasses in order to specify the response object passed into the success block.
 *
 * @param success The block to be executed on the completion of a successful request. This block has no return value and takes two arguments: the receiver operation and the object constructed from the response data of the request.
 * @param failure The block to be executed on the completion of an unsuccessful request. This block has no return value and takes two arguments: the receiver operation and the error that occurred during the request.
 */
- (void)setCompletionBlockWithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 * Cancels all non-valid block and avoids them to be called.
 */
- (void)cancelBlockCalls;

@end