//
// Created by Alexis Kinsella on 10/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import "LXDiscoveryManager.h"
#import "LXPeripheral.h"
#import "LXConstant.h"
#import "Underscore.h"
#import "OCMockObject.h"
#import "NSObject+KiwiStubAdditions.h"
#import <OCMock/OCMock.h>


@interface LXDiscoveryManager ()

@property (nonatomic, strong) NSMutableArray *peripherals;

@property (nonatomic, strong) NSArray *colors;

@property (nonatomic, strong) CBCentralManager *centralManager;

@property (nonatomic, assign) BOOL isScanning;

//#if TARGET_IPHONE_SIMULATOR
@property (nonatomic, strong) NSArray *mockLxPeripherals;
//#endif

@end

@implementation LXDiscoveryManager

- (NSArray *)discoveredPeripherals
{
    return [self.peripherals copy];
}

+ (instancetype)sharedManager
{
    static LXDiscoveryManager *sharedManager = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });

    return sharedManager;
}


#pragma mark - Lifecycle methods

- (id)init
{
    self = [super init];
    if (self) {
        self.isScanning = NO;
        self.peripherals = [NSMutableArray array];
//#if TARGET_IPHONE_SIMULATOR
        self.centralManager = [self configureMockCentralManager];
//#else
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
//#endif


#if TARGET_IPHONE_SIMULATOR
        [self configureMockPeripherals];
#endif
        [self configureColors];
    }

    return self;
}

//#if TARGET_IPHONE_SIMULATOR
- (CBCentralManager *)configureMockCentralManager
{
    CBCentralManager *mockCentralManager = [OCMockObject mockForClass:CBCentralManager.class];
    self.centralManager = mockCentralManager;

    return mockCentralManager;
}

- (void)configureMockPeripherals
{
    self.mockLxPeripherals = @[
            [LXPeripheral peripheralWithCBPeripheral:[self cbPeripheralMockWithIdentfier:@"0894645C-5BB6-9D49-AABD-CAEB02CF1BE8"
                                                                                 andName:@"iSmartLight - Bough"]
                                 advertisementData:@{} rssi:@-87
                                          hexColor: @"#f1c40f"
                                              date:[NSDate date]],
            [LXPeripheral peripheralWithCBPeripheral:[self cbPeripheralMockWithIdentfier:@"64A92BB4-F1A3-16C6-C4AF-551DEFF0A24F"
                                                                                 andName:@"No Name - 1"]
                                 advertisementData:@{} rssi:@-57
                                          hexColor: @"#34495e"
                                              date:[NSDate date]],
            [LXPeripheral peripheralWithCBPeripheral:[self cbPeripheralMockWithIdentfier:@"BB173E0E-5F5F-3260-B2DD-75D847D2859A"
                                                                                 andName:@"No Name - 2"]
                                 advertisementData:@{} rssi:@-81
                                          hexColor: @"#e74c3c"
                                              date:[NSDate date]],
            [LXPeripheral peripheralWithCBPeripheral:[self cbPeripheralMockWithIdentfier:@"4696D7AC-433B-692A-D898-A5234A0508EF"
                                                                                 andName:@"Sensor Tag"]
                                 advertisementData:@{} rssi:@-69
                                          hexColor: @"#27ae60"
                                              date:[NSDate date]],
            [LXPeripheral peripheralWithCBPeripheral:[self cbPeripheralMockWithIdentfier:@"19366D3C-21A4-3450-504F-B42E6E4D847B"
                                                                                 andName:@"No Name - 3"]
                                 advertisementData:@{} rssi:@-77
                                          hexColor: @"#2980b9"
                                              date:[NSDate date]]
    ];
}

- (CBPeripheral *)cbPeripheralMockWithIdentfier:(NSString *)mockIdentifier andName:(NSString *)mockName
{
    CBPeripheral *mockCBPeripheral = [OCMockObject mockForClass:CBPeripheral.class];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:mockIdentifier];
    [[[mockCBPeripheral stub] andReturn:uuid] identifier];
    [[[mockCBPeripheral stub] andReturn:mockName] name];
    [[[mockCBPeripheral stub] andReturnValue:OCMOCK_VALUE(CBPeripheralStateConnected)] state];
    [[mockCBPeripheral stub] discoverServices:OCMOCK_ANY];

    return mockCBPeripheral;
}
//#endif

-(void)dealloc
{
    LXLogDebug(@"[%d] Dealloc", self.hash);
}

- (void)configureColors
{
    self.colors = @[
            @"#f1c40f", // Sun Flower
            @"#34495e", // Wet Asphlat
            @"#e74c3c", // Alizarin
            @"#27ae60", // Nephritis
            @"#2980b9", // Belize Hole
            @"#9b59b6", // Amethyst
            @"#2ecc71", // Emerald
            @"#f39c12", // Orange
            @"#95a5a6", // Concrete
            @"#1abc9c", // Turquoise
            @"#8e44ad", // Wysteria
            @"#e67e22", // Carrot
            @"#d35400", // Pumpkin
            @"#3498db", // Peter River
            @"#c0392b", // Pomegranate
            @"#ecf0f1", // Clouds
            @"#16a085", // Green Sea
            @"#bdc3c7", // Silver
            @"#2c3e50", // Midnight Blue
            @"#7f8c8d" // Asbestos
    ];
}


#pragma mark - Action methods

- (void)startScanning
{
    self.isScanning = YES;
    [self.peripherals removeAllObjects];
    if (self.centralManager.state == CBCentralManagerStatePoweredOn) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LXScanStartNotification object:self];

        // Scan for devices
        [self.centralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @NO}];
        LXLogDebug(@"Scanning started");
    }
#if TARGET_IPHONE_SIMULATOR
    else {
        srand48(time(0));
        for (LXPeripheral *lxPeripheral in self.mockLxPeripherals) {
            CGFloat randValue = drand48() * arc4random_uniform(6) + drand48() * arc4random_uniform(6);
            LXLogDebug(@"Rand Value: %f", randValue);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,randValue * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                if (self.isScanning) {
                    [self.peripherals addObject: lxPeripheral];
                    [self notifyDiscoveredPeripheral: lxPeripheral];
                }
            });
        }
    }
#endif
}

- (void)stopScanning
{
    self.isScanning = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:LXScanStopNotification object:self];

    if (self.centralManager.state == CBCentralManagerStatePoweredOn) {
        [self.centralManager stopScan];
    }
}


#pragma mark - CBCentralManager Delegate methods

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    LXLogDebug(@"Central Manager did update state - central : '%d'", central.state);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)cbPeripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI
{
    NSUInteger randomValue = self.peripherals.count % self.colors.count;
    NSString *peripheralColor = self.colors[randomValue];
    LXLogDebug(@"Discovered peripheral count: %d - Color: %@, arc4random: %d, RandomValue: %d", self.peripherals.count, peripheralColor, rand, randomValue);

    LXPeripheral *lxPeripheral = Underscore.find(self.peripherals, ^BOOL(LXPeripheral *lxPeripheralItem) {
        return [lxPeripheralItem.identifier isEqualToString:cbPeripheral.identifier.UUIDString];
    });

    if (!lxPeripheral) {
        lxPeripheral = [LXPeripheral peripheralWithCBPeripheral:cbPeripheral
                                              advertisementData:advertisementData
                                                           rssi:RSSI
                                                       hexColor:peripheralColor
                                                           date:[NSDate date]];

        [self.peripherals addObject:lxPeripheral];
    }
    else {
        [lxPeripheral updatePeripheralWithCBPeripheral:cbPeripheral advertisementData:advertisementData rssi:RSSI];
    }

    LXLogDebug(@"Found cbPeripheral: %@", lxPeripheral.description);

    [self notifyDiscoveredPeripheral:lxPeripheral];
}

- (void)notifyDiscoveredPeripheral:(LXPeripheral *)lxPeripheral
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LXPeripheralDiscoveredNotification
                                                        object:self
                                                      userInfo:@{LXPeripheralValue : lxPeripheral}];

}

@end