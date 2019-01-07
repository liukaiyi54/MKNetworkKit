//
//  AFNetworkResponse.m
//  ASBasicLibrary
//
//  Created by Michael on 2018/12/27.
//  Copyright © 2018 Aspire. All rights reserved.
//

#import "AFNetworkResponse.h"

@implementation AFNetworkResponse

- (instancetype)init {
    return [self initWithDictionary:nil];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _identifier = [[dict objectForKey:@"id"] copy];
        _result = [[dict objectForKey:@"result"] copy];
        _jsonrpc = [[dict objectForKey:@"jsonrpc"] copy];
        _error = [dict objectForKey:@"error"];
    }
    return self;
}

@end

@implementation AFNetworkResponse (Error)

+ (instancetype)responseWithErrorCode:(NSInteger)code errorMessage:(NSString *)message {
    AFNetworkResponseError *error = [[AFNetworkResponseError alloc] initWithCode:code message:message];
    NSDictionary *dict = @{@"error": error};
    AFNetworkResponse *instance = [[AFNetworkResponse alloc] initWithDictionary:dict];
    return instance;
}

@end
