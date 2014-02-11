//
//  LXDiscoveryViewController.m
//  ble-manager
//
//  Created by Alexis Kinsella on 08/02/2014.
//  Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import "UIColor+XBAdditions.h"
#import "LXPeripheral.h"
#import "LXScanViewController.h"
#import "LXDiscoveryManager.h"
#import "LXConstant.h"

@interface LXScanViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSUInteger countDown;

@property (nonatomic, assign) BOOL isScanning;

@property (strong, nonatomic) LXDiscoveryManager *discoveryManager;

@property (strong, nonatomic) id peripheralDiscoveredNotificationObserver;

@end

@implementation LXScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.discoveryManager = [LXDiscoveryManager sharedManager];

    self.isScanning = NO;
    self.scanRoundProgressView.tintColor = [UIColor colorWithHex:@"#4F74A7"];
    [self.scanRoundProgressView setProgress:100 animated:NO];
    self.scanRoundProgressView.alpha = 0;
    self.peripheralInformationView.hidden = YES;

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureForProgressView:)];
    [self.scanRoundProgressView addGestureRecognizer:tapGestureRecognizer];
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

    [[NSNotificationCenter defaultCenter] removeObserver:self.peripheralDiscoveredNotificationObserver];
}


- (void)onPeripheralDiscovered:(LXPeripheral *)lxPeripheral
{
    self.messageLabel.text = [NSString stringWithFormat:@"Found a device: '%@'", lxPeripheral.name];
    self.uuidLabel.text = [NSString stringWithFormat:@"UUID: '%@'", lxPeripheral.identifier];
    self.rssiLabel.text = [NSString stringWithFormat:@"RSSI: '%@'", lxPeripheral.rssi];
    self.peripheralInformationView.hidden = NO;
}

- (void)handleGestureForProgressView:(id)sender
{
    if (self.isScanning) {
        [self stopScanning];
    }
}

- (void)startScanningAction:(id)sender
{
    [self startScanning];
    self.isScanning = YES;
}

- (void)startScanning
{
    [self.discoveryManager startScanning];

    [self.scanRoundProgressView setProgress:100 animated:NO];
    self.countDown = 100;
    [self updateProgressValue];
    self.scanButton.hidden = YES;

    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.scanRoundProgressView.alpha = 1;
    } completion:^(BOOL finished) {}];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopScanning
{
    [self.discoveryManager stopScanning];

    [self.timer invalidate];
    self.peripheralInformationView.hidden = YES;
    self.isScanning = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.scanRoundProgressView.alpha = 0;
    } completion:^(BOOL finished) {
        self.scanButton.hidden = NO;
    }];
}

- (void)timerFired
{
    if (self.countDown <= 0) {
        [self stopScanning];
    }
    else {
        self.countDown -= 1;
        [self updateProgressValue];
    }
}

- (void)updateProgressValue
{
    self.scanRoundProgressView.progress = self.countDown * 0.01;
    self.countDownLabel.text = [NSString stringWithFormat:@"%ds.", (self.countDown == 0 ? 0 : self.countDown == 100 ? 10 : self.countDown / 10 + 1)];
}

@end
