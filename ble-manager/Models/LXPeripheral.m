//
// Created by Alexis Kinsella on 09/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import "LXPeripheral.h"


static NSString *const kNoName = @"No Name";

@interface LXPeripheral ()

@property(nonatomic, strong) NSString *identifier;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSDictionary *advertisementData;
@property(nonatomic, strong) NSNumber *rssi;
@property(nonatomic, strong) NSString *hexColor;
@property(nonatomic, strong) NSDate *date;

@end

@implementation LXPeripheral

- (instancetype)initWithIdentifier:(NSString *)identifier name:(NSString *)name advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)rssi hexColor:(NSString *)hexColor date:(NSDate *)date
{
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.name = name;
        self.advertisementData = advertisementData;
        self.rssi = rssi;
        self.hexColor = hexColor;
        self.date = date;
    }

    return self;
}

+ (instancetype)peripheralWithIdentifier:(NSString *)identifier name:(NSString *)name advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)rssi hexColor:(NSString *)hexColor date:(NSDate *)date
{
    return [[self alloc] initWithIdentifier:identifier name:name advertisementData:advertisementData rssi:rssi  hexColor:hexColor date:date];
}

+ (instancetype)peripheralCBPeripheral:(CBPeripheral *)cbPeripheral advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)rssi hexColor:(NSString *)hexColor date:(NSDate *)date
{    return [LXPeripheral peripheralWithIdentifier:cbPeripheral.identifier.UUIDString
                                              name:cbPeripheral.name ? cbPeripheral.name : kNoName
                                 advertisementData: advertisementData
                                              rssi: rssi
                                          hexColor: hexColor
                                              date:date];
}
- (void)updatePeripheralWithCBPeripheral:(CBPeripheral *)cbPeripheral advertisementData:(NSDictionary *)advertisementData rssi:(NSNumber *)rssi
{
    self.identifier = cbPeripheral.identifier.UUIDString;
    self.name = cbPeripheral.name;
    self.advertisementData = advertisementData;
    self.rssi = rssi;
}


- (void)updatePeripheralWithLXPeripheral:(LXPeripheral *)lxPeripheral
{
    self.name = lxPeripheral.name;
    self.advertisementData = lxPeripheral.advertisementData;
    self.rssi = lxPeripheral.rssi;
}


- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];

    [description appendString:[NSString stringWithFormat:@" identifier: '%@'", self.identifier]];
    [description appendString:[NSString stringWithFormat:@", name: '%@'", self.name]];
    [description appendString:[NSString stringWithFormat:@", rssi: '%@'", self.rssi]];
    [description appendString:[NSString stringWithFormat:@", advertisementData: '%@'", self.advertisementData]];
    [description appendString:[NSString stringWithFormat:@", hexColor: '%@'", self.hexColor]];
    [description appendString:@">"];

    return description;
}

@end