//
// Created by Simone Civetta on 13/12/13.
// Copyright (c) 2013 Xebia IT Architects. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBHttpClient.h"
#import "XBReloadableArrayDataSource.h"
#import "XBArrayDataSource.h"


@interface LXAppConfiguration : NSObject

+ (instancetype)appConfiguration;

- (NSObject *)userAgentComplement;

- (NSString *)bundleVersion;

- (NSString *)bundleShortVersion;
@end