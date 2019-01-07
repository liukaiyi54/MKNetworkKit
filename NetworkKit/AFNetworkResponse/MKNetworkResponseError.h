//
//  MKNetworkResponseError.h
//  ASBasicLibrary
//
//  Created by Michael on 2019/1/2.
//  Copyright © 2019 Aspire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKNetworkResponseError : NSObject

@property (nonatomic, assign, readonly) NSInteger code;
@property (nonatomic, copy, readonly) NSString *message;

- (instancetype)initWithCode:(NSInteger)code message:(NSString *)message NS_DESIGNATED_INITIALIZER;

@end

