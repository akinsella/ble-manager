//
// Created by Alexis Kinsella on 16/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "LXPeripheralManager.h"
#import "LXPeripheral.h"
#import "LXPeripheralService.h"
#import "LXConstant.h"
#import "OCMockObject.h"
#import "NSObject+KiwiStubAdditions.h"
#import "OCMArg.h"

@interface LXPeripheralManager ()

@property(nonatomic, strong) CBCentralManager *centralManager;
@property(nonatomic, strong) LXPeripheral *lxPeripheral;
@property(nonatomic, assign) BOOL scanning;

@end

@implementation LXPeripheralManager

- (instancetype)initWithPeripheral:(LXPeripheral *)lxPeripheral
{
    self = [super init];
    if (self) {
        self.lxPeripheral = lxPeripheral;
        self.scanning = NO;
    }


//#if TARGET_IPHONE_SIMULATOR
    self.centralManager = [self configureMockCentralManager];
//#else
//    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
//#endif


    return self;
}

+ (instancetype)managerWithPeripheral:(LXPeripheral *)lxPeripheral
{
    return [[self alloc] initWithPeripheral:lxPeripheral];
}

- (void)connectPeripheral
{
    CBPeripheral *cbPeripheral = self.lxPeripheral.cbPeripheral;

    [self.centralManager connectPeripheral:cbPeripheral options:@{}];
}

- (CBCentralManager *)configureMockCentralManager
{
    CBCentralManager *mockCentralManager = [OCMockObject mockForClass:CBCentralManager.class];
    [[mockCentralManager stub] connectPeripheral:OCMOCK_ANY options:OCMOCK_ANY];
    [[mockCentralManager stub] cancelPeripheralConnection:OCMOCK_ANY];

    self.centralManager = mockCentralManager;

    return mockCentralManager;
}

- (void)disconnectPeripheral
{
    CBPeripheral *cbPeripheral = self.lxPeripheral.cbPeripheral;
    [self.centralManager cancelPeripheralConnection:cbPeripheral];
}

- (void)discoverServices
{
    CBPeripheral *cbPeripheral = self.lxPeripheral.cbPeripheral;
    [cbPeripheral discoverServices:@[]];
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{
    [self.lxPeripheral updatePeripheralWithRSSI:peripheral.RSSI];
}

- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral
{
    [self.lxPeripheral updatePeripheralWithName:peripheral.name];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    for (CBService *service in peripheral.services) {
        NSString *serviceIdentifier = [[NSString alloc] initWithData:service.UUID.data encoding:NSUTF8StringEncoding];
        LXPeripheralService *peripheralService = [LXPeripheralService serviceWithIdentifier:serviceIdentifier primary:service.isPrimary];

        [self.lxPeripheral addService:peripheralService];
    }
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)centralManager
{

}

- (void)discoverServicesWithTimeout:(CGFloat)timeout completion:(void (^)(NSError *error))completion
{
    if (self.scanning) {
        NSError *alreadyScanningError = [NSError errorWithDomain:LXErrorDomain code:LXAlreadyScanningPeripheral userInfo:@{}];
        completion(alreadyScanningError);
    }
    self.scanning = YES;
    [self connectPeripheral];
    [self discoverServices];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (timeout * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self disconnectPeripheral];
        if (completion) {
            self.scanning = NO;
            completion(nil);
        }
    });
}

@end