//
//  AFNetworkBaseEngine.m
//  ASBasicLibrary
//
//  Created by Michael on 2019/1/3.
//  Copyright © 2019 Aspire. All rights reserved.
//

#import "MKNetworkBaseEngine.h"
#import <AFNetworking/AFNetworking.h>

@interface MKNetworkBaseEngine()

@property (nonatomic, strong) NSMutableArray *requestIDList;
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation MKNetworkBaseEngine

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _delegate = nil;
        if ([self conformsToProtocol:@protocol(MKNetworkBaseEngineDataSource)]) {
            self.dataSource = (id <MKNetworkBaseEngineDataSource>)self;
        } else {
            NSException *exception = [[NSException alloc] init];
            @throw exception;
        }
    }
    return self;
}

- (void)dealloc {
    [self cancelAllRequests];
    self.requestIDList = nil;
}

#pragma mark - setters & getters
- (NSMutableArray *)requestIDList {
    if (!_requestIDList) {
        _requestIDList = [[NSMutableArray alloc] init];
    }
    return _requestIDList;
}

- (AFHTTPRequestSerializer *)httpRequestSerializer {
    if (!_httpRequestSerializer) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
    }
    return _httpRequestSerializer;
}

#pragma mark - public methods
- (void)loadData {
    NSDictionary *params = [self.dataSource paramsForApi:self];
    [self loadDataWithParams:params];
}

- (void)loadDataWithParams:(NSDictionary *)params {
    NSString *method = @"";
    switch (self.dataSource.httpMethod) {
        case AFHTTPMethodPOST:
            method = @"POST";
            break;
        case AFHTTPMethodGET:
            method = @"GET";
            break;
        default:
            break;
    }
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:method URLString:self.dataSource.requestUrl parameters:params error:nil];
    
    NSNumber *requestID = [[MKApiProxy sharedInstance] callApiWithRequest:request onSuccess:^(MKNetworkResponse *response) {
        [self successOnResponse:response];
    } onFail:^(MKNetworkResponseError *error) {
        [self failWithError:error];
    }];
    
    [self.requestIDList addObject:requestID];
}

- (void)cancelAllRequests {
    [[MKApiProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIDList];
    [self.requestIDList removeAllObjects];
}

- (void)cancelRequestWithRequestID:(NSInteger)requestID {
    [[MKApiProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
}

#pragma mark - private methods
- (void)removeRequestIDWithRequestID:(NSInteger)requestID {
    for (NSNumber *storedID in self.requestIDList) {
        if ([storedID integerValue] == requestID) {
            [self.requestIDList removeObject:storedID];
        }
    }
}

#pragma mark - API callbacks
- (void)successOnResponse:(MKNetworkResponse *)response {
    if ([self.delegate respondsToSelector:@selector(requestDidSuccessWithResponse:)]) {
        [self.delegate requestDidSuccessWithResponse:response];
    }
}

- (void)failWithError:(MKNetworkResponseError *)error {
    if ([self.delegate respondsToSelector:@selector(requestDidFailWithError:)]) {
        [self.delegate requestDidFailWithError:error];
    }
}

@end
