//
//  AFApiProxy.h
//  ASBasicLibrary
//
//  Created by Michael on 2018/12/27.
//  Copyright © 2018 Aspire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkResponse.h"

typedef void(^AFNetworkResponseSuccessBlock)(AFNetworkResponse *response);
typedef void(^AFNetworkResponseErrorBlock)(AFNetworkResponseError *error);

@interface AFApiProxy : NSObject

+ (instancetype)sharedInstance;

- (NSNumber *)callApiWithRequest:(NSURLRequest *)request onSuccess:(AFNetworkResponseSuccessBlock)success onFail:(AFNetworkResponseErrorBlock)fail;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

@end

