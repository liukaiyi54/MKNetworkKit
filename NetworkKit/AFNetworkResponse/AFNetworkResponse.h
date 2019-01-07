//
//  AFNetworkResponse.h
//  ASBasicLibrary
//
//  Created by Michael on 2018/12/27.
//  Copyright © 2018 Aspire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkResponseError.h"

@interface AFNetworkResponse : NSObject
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *jsonrpc;
@property (nonatomic, copy, readonly) NSDictionary *result;
@property (nonatomic, copy, readonly) AFNetworkResponseError *error;

- (instancetype)initWithDictionary:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;

@end

@interface AFNetworkResponse (Error)

+ (instancetype)responseWithErrorCode:(NSInteger)code errorMessage:(NSString *)message;

@end
