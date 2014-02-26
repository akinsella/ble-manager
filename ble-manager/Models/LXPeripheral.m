//
// Created by Alexis Kinsella on 09/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import "LXPeripheral.h"
#import "LXPeripheralService.h"


static NSString *const kNoName = @"No Name";

@interface LXPeripheral ()

@property (nonatomic, strong) CBPeripheral *cbPeripheral;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDictionary *advertisementData;
@property (nonatomic, strong) NSNumber *rssi;
@property (nonatomic, strong) NSString *hexColor;
@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) NSMutableArray *services;

@end

@implementation LXPeripheral

- (instancetype)initWithCBPeripheral:(CBPeripheral *)cbPeripheral advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)rssi hexColor:(NSString *)hexColor date:(NSDate *)date
{
    self = [super init];
    if (self) {
        self.cbPeripheral = cbPeripheral;
        self.identifier = cbPeripheral.identifier.UUIDString;
        self.name = cbPeripheral.name;
        self.advertisementData = advertisementData;
        self.rssi = rssi;
        self.hexColor = hexColor;
        self.date = date;
        self.services = [NSMutableArray array];
    }

    return self;
}

+ (instancetype)peripheralWithCBPeripheral:(CBPeripheral *)cbPeripheral advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)rssi hexColor:(NSString *)hexColor date:(NSDate *)date
{
    return [[self alloc] initWithCBPeripheral:cbPeripheral advertisementData:advertisementData rssi:rssi hexColor:hexColor date:date];
}

- (void)updatePeripheralWithCBPeripheral:(CBPeripheral *)cbPeripheral advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)rssi
{
    self.cbPeripheral = cbPeripheral;
    self.identifier = cbPeripheral.identifier.UUIDString;
    self.name = cbPeripheral.name;
    self.advertisementData = advertisementData;
    self.rssi = rssi;
}

- (void)updatePeripheralWithRSSI:(NSNumber *)rssi
{
    self.rssi = rssi;
}

- (void)updatePeripheralWithName:(NSString *)name
{
    self.name = name;
}

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];

    [description appendString:[NSString stringWithFormat:@" identifier: '%@'", self.identifier]];
    [description appendString:[NSString stringWithFormat:@", name: '%@'", self.name]];
    [description appendString:[NSString stringWithFormat:@", rssi: '%@'", self.rssi]];
    [description appendString:[NSString stringWithFormat:@", advertisementData: '%@'", self.advertisementData]];
    [description appendString:[NSString stringWithFormat:@", hexColor: '%@'", self.hexColor]];
    [description appendString:@">"];

    return description;
}

- (void)addService:(LXPeripheralService *)service
{
    [self.services addObject: service];
}

@end