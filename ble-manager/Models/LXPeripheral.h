//
// Created by Alexis Kinsella on 09/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class LXPeripheralService;


@interface LXPeripheral : NSObject

@property (nonatomic, strong, readonly) CBPeripheral *cbPeripheral;
@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSDictionary *advertisementData;
@property (nonatomic, strong, readonly) NSNumber *rssi;
@property (nonatomic, strong, readonly) NSString *hexColor;
@property (nonatomic, strong, readonly) NSDate *date;
@property (nonatomic, strong, readonly) NSMutableArray *services;

- (instancetype)initWithCBPeripheral:(CBPeripheral *)cbPeripheral advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)rssi hexColor:(NSString *)hexColor date:(NSDate *)date;

+ (instancetype)peripheralWithCBPeripheral:(CBPeripheral *)cbPeripheral advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)rssi hexColor:(NSString *)hexColor date:(NSDate *)date;

- (void)updatePeripheralWithCBPeripheral:(CBPeripheral *)cbPeripheral advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)rssi;

- (void)updatePeripheralWithRSSI:(NSNumber *)rssi;

- (void)updatePeripheralWithName:(NSString *)name;

- (void)addService:(LXPeripheralService *)service;

@end