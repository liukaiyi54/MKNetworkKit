//
//  MKRegisterDeviceEngine.m
//  ASBasicLibrary
//
//  Created by Michael on 2019/1/4.
//  Copyright © 2019 Aspire. All rights reserved.
//

#import "MKRegisterDeviceEngine.h"

#include <sys/types.h>
#include <sys/sysctl.h>

@implementation MKRegisterDeviceEngine

- (void)registerOnSuccess:(void (^)())success onError:(void (^)(NSInteger code, NSString *message))error {
    [self loadData];
}

#pragma mark - delegate
- (void)requestDidFailWithError:(MKNetworkResponseError *)error {
    if (error) {
        NSLog(@"%@",error.message);
    }
}

- (void)requestDidSuccessWithResponse:(MKNetworkResponse *)response {
    if (response) {
        NSLog(@"%@", response);
    }
}

#pragma mark - dataSource
- (AFHTTPMethod)httpMethod {
    return AFHTTPMethodPOST;
}


+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 ";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 ";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 ";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S ";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 ";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 ";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c ";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c ";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s ";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s ";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus ";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 ";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6S";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6S Plus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G ";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G ";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G ";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G ";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G ";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G ";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 ";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 ";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

@end
