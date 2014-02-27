//
// Created by Simone Civetta on 13/12/13.
// Copyright (c) 2013 Xebia IT Architects. All rights reserved.
//

#import "LXAppConfiguration.h"
#import "GBDeviceInfo_iOS.h"

@interface LXAppConfiguration ()

@property (nonatomic, strong) GBDeviceDetails *deviceDetails;

@end

@implementation LXAppConfiguration

- (id)init
{
    self = [super init];
    if (self) {

        self.deviceDetails = [GBDeviceInfo deviceDetails];
    }

    return self;
}

+ (instancetype)appConfiguration
{

    return [[self alloc] init];
}

- (NSString *)userAgentComplement
{
    return [NSString stringWithFormat:@"%@-v%@(%@)", self.appName, self.bundleShortVersion, self.bundleVersion];
}

- (NSString *)appName
{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
}

- (NSString *)rawSystemInfo
{
    return self.deviceDetails.rawSystemInfoString;
}

- (NSString *)modelNumber
{
    return [NSString stringWithFormat:@"%d.%d", self.deviceDetails.majorModelNumber, self.deviceDetails.minorModelNumber ];
}

- (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)systemName
{
    return [[UIDevice currentDevice] systemName];
}

- (NSString *)deviceFamily
{
    return [[UIDevice currentDevice] model];
}

- (NSString *)bundleVersion
{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
}

- (NSString *)bundleShortVersion
{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
}

@end