//
//  AFNetworkBaseEngine.h
//  ASBasicLibrary
//
//  Created by Michael on 2019/1/3.
//  Copyright © 2019 Aspire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFApiProxy.h"

typedef NS_ENUM(NSUInteger, AFHTTPMethod) {
    AFHTTPMethodPOST,
    AFHTTPMethodGET,
};

//typedef void(^AFNetworkResponseSuccessBlock)(AFNetworkResponse *response);
//typedef void(^AFNetworkResponseErrorBlock)(NSInteger code, NSString *message);

@class AFNetworkBaseEngine;

@protocol AFNetworkBaseEngineDataSource <NSObject>

@required
- (NSDictionary *)paramsForApi:(AFNetworkBaseEngine *)engine;
- (NSString *)requestUrl;
- (AFHTTPMethod)httpMethod;

@end

@protocol AFNetworkBaseEngineDelegate <NSObject>

- (void)requestDidSuccessWithResponse:(AFNetworkResponse *)response;
- (void)requestDidFailWithError:(AFNetworkResponseError *)error;

@end

@interface AFNetworkBaseEngine : NSObject

@property (nonatomic, weak) id<AFNetworkBaseEngineDataSource> dataSource;
@property (nonatomic, weak) id<AFNetworkBaseEngineDelegate> delegate;

- (void)cancelAllRequests;

- (void)cancelRequestWithRequestID:(NSInteger)requestID;

- (void)loadData;

- (void)loadDataWithParams:(NSDictionary *)params;

@end
