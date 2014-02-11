//
// Created by Alexis Kinsella on 11/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "LXPeripheralHeaderViewController.h"
#import "LXConstant.h"
#import "LXPeripheral.h"
#import "UIColor+XBAdditions.h"


@interface LXPeripheralHeaderViewController ()

@property (nonatomic, strong)id peripheralSelectedNotificationObserver;

@end


@implementation LXPeripheralHeaderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UISwipeGestureRecognizer *swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureForControllerView:)];
    swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUpGestureRecognizer];
    UISwipeGestureRecognizer *swipeDownGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureForControllerView:)];
    swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDownGestureRecognizer];
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
    self.peripheralSelectedNotificationObserver = [[NSNotificationCenter defaultCenter] addObserverForName:LXPeripheralSelectedNotification
                                                                                                    object:nil
                                                                                                     queue:nil
                                                                                                usingBlock:^(NSNotification *notification) {
                                                                                                    LXLogDebug(@"[%d] '%@' notification observed - userInfos: %@", weakSelf.hash, notification.name, notification.userInfo);

                                                                                                    LXPeripheral *lxPeripheral = notification.userInfo[LXPeripheralValue];
                                                                                                    [weakSelf onPeripheralSelected:lxPeripheral];
                                                                                                }];
}

- (void)disposeNotificationObservers
{
    LXLogDebug(@"[%d] Removing observers", self.hash);

    [[NSNotificationCenter defaultCenter] removeObserver:self.peripheralSelectedNotificationObserver];
}

- (void)onPeripheralSelected:(LXPeripheral *)lxPeripheral
{
    self.nameLabel.text = lxPeripheral.name;
    self.uuidLabel.text = lxPeripheral.identifier;
    self.rssiLabel.text = [lxPeripheral.rssi stringValue];
    self.view.backgroundColor = [UIColor colorWithHex:lxPeripheral.hexColor];
}

- (void)handleGestureForControllerView:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionDown) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LXShowPeripheralsViewControllerNotification object:self userInfo:@{}];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:LXHidePeripheralsViewControllerNotification object:self userInfo:@{}];
    }
}


@end