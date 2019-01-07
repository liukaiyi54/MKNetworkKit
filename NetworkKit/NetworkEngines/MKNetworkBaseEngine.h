//
//  MKNetworkBaseEngine.h
//  ASBasicLibrary
//
//  Created by Michael on 2019/1/3.
//  Copyright © 2019 Aspire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKApiProxy.h"

typedef NS_ENUM(NSUInteger, AFHTTPMethod) {
    AFHTTPMethodPOST,
    AFHTTPMethodGET,
};

//typedef void(^AFNetworkResponseSuccessBlock)(MKNetworkResponse *response);
//typedef void(^AFNetworkResponseErrorBlock)(NSInteger code, NSString *message);

@class MKNetworkBaseEngine;

@protocol MKNetworkBaseEngineDataSource <NSObject>

@required
- (NSDictionary *)paramsForApi:(MKNetworkBaseEngine *)engine;
- (NSString *)requestUrl;
- (AFHTTPMethod)httpMethod;

@end

@protocol MKNetworkBaseEngineDelegate <NSObject>

- (void)requestDidSuccessWithResponse:(MKNetworkResponse *)response;
- (void)requestDidFailWithError:(MKNetworkResponseError *)error;

@end

@interface MKNetworkBaseEngine : NSObject

@property (nonatomic, weak) id<MKNetworkBaseEngineDataSource> dataSource;
@property (nonatomic, weak) id<MKNetworkBaseEngineDelegate> delegate;

- (void)cancelAllRequests;

- (void)cancelRequestWithRequestID:(NSInteger)requestID;

- (void)loadData;

- (void)loadDataWithParams:(NSDictionary *)params;

@end
