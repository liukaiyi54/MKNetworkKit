//
//  MKApiProxy.m
//  ASBasicLibrary
//
//  Created by Michael on 2018/12/27.
//  Copyright © 2018 Aspire. All rights reserved.
//

#import "MKApiProxy.h"
#import "AFNetworking/AFNetworking.h"
#import "MJExtension/NSObject+MJKeyValue.h"

@interface MKApiProxy()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableDictionary *taskTable;

@end

@implementation MKApiProxy

#pragma mark - setters and getters
- (NSMutableDictionary *)taskTable {
    if (!_taskTable) {
        _taskTable = [[NSMutableDictionary alloc] init];
    }
    return _taskTable;
}

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy.validatesDomainName = NO;
    }
    return _sessionManager;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MKApiProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MKApiProxy alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request onSuccess:(AFNetworkResponseSuccessBlock)success onFail:(AFNetworkResponseErrorBlock)fail {
    NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.taskTable removeObjectForKey:requestID];
        MKNetworkResponse *result = nil;
        if (error) {
            MKNetworkResponseError *err = [[MKNetworkResponseError alloc] initWithCode:error.code message:error.localizedDescription];
            fail ? fail(err) : nil;
        } else {
            result = [MKNetworkResponse mj_objectWithKeyValues:responseObject];
            if (result.error) {
                fail ? fail(result.error) : nil;
            } else {
                success ? success(result) : nil;
            }
        }
    }];
    
    NSNumber *requestID = @([dataTask taskIdentifier]);
    self.taskTable[requestID] = dataTask;
    [dataTask resume];
    
    return requestID;
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID {
    NSURLSessionDataTask *dataTask = self.taskTable[requestID];
    [dataTask cancel];
    [self.taskTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList {
    for (NSNumber *requestID in requestIDList) {
        [self cancelRequestWithRequestID:requestID];
    }
}

@end
