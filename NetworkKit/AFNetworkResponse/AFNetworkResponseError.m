//
//  AFNetworkResponseError.m
//  ASBasicLibrary
//
//  Created by Michael on 2019/1/2.
//  Copyright © 2019 Aspire. All rights reserved.
//

#import "AFNetworkResponseError.h"

@implementation AFNetworkResponseError

- (instancetype)init {
    return [self initWithCode:0 message:nil];
}

- (instancetype)initWithCode:(NSInteger)code message:(NSString *)message {
    self = [super init];
    if (self) {
        _code = code;
        _message = [message copy];
    }
    return self;
}

@end
