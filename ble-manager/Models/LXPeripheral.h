//
// Created by Alexis Kinsella on 09/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


@interface LXPeripheral : NSObject

@property(nonatomic, strong, readonly) NSString *identifier;
@property(nonatomic, strong, readonly) NSString *name;
@property(nonatomic, strong, readonly) NSDictionary *advertisementData;
@property(nonatomic, strong, readonly) NSNumber *rssi;
@property(nonatomic, strong, readonly) NSString *hexColor;
@property(nonatomic, strong, readonly) NSDate *date;

- (instancetype)initWithIdentifier:(NSString *)identifier name:(NSString *)name advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)rssi hexColor:(NSString *)hexColor date:(NSDate *)date;

+ (instancetype)peripheralWithIdentifier:(NSString *)identifier name:(NSString *)name advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)rssi hexColor:(NSString *)hexColor date:(NSDate *)date;

+ (instancetype)peripheralCBPeripheral:(CBPeripheral *)cbPeripheral advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)rssi hexColor:(NSString *)hexColor date:(NSDate *)date;

- (void)updatePeripheralWithCBPeripheral:(CBPeripheral *)cbPeripheral advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)rssi;

- (void)updatePeripheralWithLXPeripheral:(LXPeripheral *)peripheral;

@end