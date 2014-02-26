//
// Created by Alexis Kinsella on 16/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class LXPeripheral;


@interface LXPeripheralManager : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate>

- (instancetype)initWithPeripheral:(LXPeripheral *)lxPeripheral;

+ (instancetype)managerWithPeripheral:(LXPeripheral *)lxPeripheral;

- (void)discoverServicesWithTimeout:(CGFloat)timeout completion:(void (^)(NSError *error))completion;

@end