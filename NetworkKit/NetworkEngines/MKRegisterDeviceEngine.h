//
//  MKRegisterDeviceEngine.h
//  ASBasicLibrary
//
//  Created by Michael on 2019/1/4.
//  Copyright © 2019 Aspire. All rights reserved.
//

#import "MKNetworkBaseEngine.h"

@interface MKRegisterDeviceEngine : MKNetworkBaseEngine <MKNetworkBaseEngineDelegate, MKNetworkBaseEngineDataSource>

- (void)registerOnSuccess:(void (^)())success onError:(void (^)(NSInteger code, NSString *message))error;

@end

