//
//  LXDiscoveryViewController.m
//  ble-manager
//
//  Created by Alexis Kinsella on 08/02/2014.
//  Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "UIColor+XBAdditions.h"
#import "LXPeripheral.h"
#import "LXPeripheralViewCell.h"
#import "LXPeripheralsViewController.h"
#import "LXConstant.h"
#import "LXDiscoveryManager.h"

@interface LXPeripheralsViewController ()

@property (nonatomic, strong) id scanStartNotificationObserver;
@property (nonatomic, strong) id scanStopNotificationObserver;
@property (nonatomic, strong) id peripheralDiscoveredNotificationObserver;
@property (strong, nonatomic) LXDiscoveryManager *discoveryManager;

@end

@implementation LXPeripheralsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.discoveryManager = [LXDiscoveryManager sharedManager];
}

-(void)dealloc
{
    LXLogDebug(@"[%d] Dealloc", self.hash);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self configureNotificationObservers];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [self disposeNotificationObservers];
}

- (void)configureNotificationObservers
{
    typeof(self) weakSelf = self;
    self.scanStartNotificationObserver = [[NSNotificationCenter defaultCenter] addObserverForName:LXScanStartNotification
                                                                                           object:nil
                                                                                            queue:nil
                                                                                       usingBlock:^(NSNotification *notification) {
        LXLogDebug(@"[%d] '%@' notification observed - userInfos: %@", weakSelf.hash, notification.name, notification.userInfo);

        [weakSelf onScanStart];
    }];

    self.scanStopNotificationObserver = [[NSNotificationCenter defaultCenter] addObserverForName:LXScanStopNotification
                                                                                          object:nil
                                                                                           queue:nil
                                                                                      usingBlock:^(NSNotification *notification) {
        LXLogDebug(@"[%d] '%@' notification observed - userInfos: %@", weakSelf.hash, notification.name, notification.userInfo);
        [weakSelf onScanStop];
    }];

    self.peripheralDiscoveredNotificationObserver = [[NSNotificationCenter defaultCenter] addObserverForName:LXPeripheralDiscoveredNotification
                                                                                                      object:nil
                                                                                                       queue:nil
                                                                                                  usingBlock:^(NSNotification *notification) {
        LXLogDebug(@"[%d] '%@' notification observed - userInfos: %@", weakSelf.hash, notification.name, notification.userInfo);

        LXPeripheral *lxPeripheral = notification.userInfo[LXPeripheralValue];
        [weakSelf onPeripheralDiscovered:lxPeripheral];
    }];
}

- (void)disposeNotificationObservers
{
    LXLogDebug(@"[%d] Removing observers", self.hash);

    [[NSNotificationCenter defaultCenter] removeObserver:self.scanStartNotificationObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self.scanStopNotificationObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self.peripheralDiscoveredNotificationObserver];
}

- (void)onScanStart
{
    [self.peripheralCollectionView reloadData];
}

- (void)onScanStop
{
}

- (void)onPeripheralDiscovered:(LXPeripheral *)lxPeripheral
{
    [self.peripheralCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.discoveryManager.discoveredPeripherals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PeripheralCell";

    LXPeripheral *lxPeripheral = self.discoveryManager.discoveredPeripherals[(NSUInteger) indexPath.item];

    LXPeripheralViewCell *peripheralViewCell = [self.peripheralCollectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    [peripheralViewCell configureWithPeripheral:lxPeripheral backgroundColor:[UIColor colorWithHex:lxPeripheral.hexColor] forIndexPath:indexPath];

    return peripheralViewCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    LXPeripheral *lxPeripheral = self.discoveryManager.discoveredPeripherals[(NSUInteger) indexPath.item];

    [[NSNotificationCenter defaultCenter] postNotificationName:LXPeripheralSelectedNotification
                                                        object:self
                                                      userInfo:@{LXPeripheralValue: lxPeripheral}];
}

@end
