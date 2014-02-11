//
// Created by Alexis Kinsella on 10/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LXDiscoveryManager : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate>

+ (instancetype)sharedManager;

- (void)startScanning;

- (void)stopScanning;

- (NSArray *)discoveredPeripherals;

@end