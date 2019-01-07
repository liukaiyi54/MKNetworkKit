//
//  AFRegisterDeviceEngine.h
//  ASBasicLibrary
//
//  Created by Michael on 2019/1/4.
//  Copyright © 2019 Aspire. All rights reserved.
//

#import "AFNetworkBaseEngine.h"

@interface AFRegisterDeviceEngine : AFNetworkBaseEngine <AFNetworkBaseEngineDelegate, AFNetworkBaseEngineDataSource>

- (void)registerOnSuccess:(void (^)())success onError:(void (^)(NSInteger code, NSString *message))error;

@end

