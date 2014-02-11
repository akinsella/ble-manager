//
//  LXDiscoveryViewController.m
//  ble-manager
//
//  Created by Alexis Kinsella on 08/02/2014.
//  Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "LXDiscoveryViewController.h"
#import "LXScanViewController.h"
#import "LXPeripheralsViewController.h"
#import "LXConstant.h"
#import "LXPeripheral.h"
#import "LXPeripheralDetailsViewController.h"

@interface LXDiscoveryViewController ()

@property (nonatomic, strong) LXScanViewController *scanViewController;
@property (nonatomic, strong) LXPeripheralsViewController *peripheralsViewController;
@property (nonatomic, strong) LXPeripheralDetailsViewController *peripheralHeaderViewController;

@property (nonatomic, strong) id peripheralSelectedNotificationObserver;
@property (nonatomic, strong) id showPeripheralsViewControllerNotificationObserver;
@property (nonatomic, strong) id hidePeripheralsViewControllerNotificationObserver;

@end

@implementation LXDiscoveryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.delegate = self;
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
    self.showPeripheralsViewControllerNotificationObserver = [[NSNotificationCenter defaultCenter] addObserverForName:LXShowPeripheralsViewControllerNotification
                                                                                                               object:nil
                                                                                                                queue:nil
                                                                                                           usingBlock:^(NSNotification *notification) {
        LXLogDebug(@"[%d] '%@' notification observed - userInfos: %@", weakSelf.hash, notification.name, notification.userInfo);

        [weakSelf onShowPeripheralsViewController];
    }];
    self.hidePeripheralsViewControllerNotificationObserver = [[NSNotificationCenter defaultCenter] addObserverForName:LXHidePeripheralsViewControllerNotification
                                                                                                               object:nil
                                                                                                                queue:nil
                                                                                                           usingBlock:^(NSNotification *notification) {
       LXLogDebug(@"[%d] '%@' notification observed - userInfos: %@", weakSelf.hash, notification.name, notification.userInfo);

       [weakSelf onHidePeripheralsViewController];
    }];
}

- (void)disposeNotificationObservers
{
    LXLogDebug(@"[%d] Removing observers", self.hash);

    [[NSNotificationCenter defaultCenter] removeObserver:self.peripheralSelectedNotificationObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self.showPeripheralsViewControllerNotificationObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self.hidePeripheralsViewControllerNotificationObserver];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *segueIdentifier = [segue identifier];

    if ([segueIdentifier isEqualToString:LXScanViewControllerSegue]) {
        self.scanViewController = segue.destinationViewController;
    }
    else if ([segueIdentifier isEqualToString:LXPeripheralsViewControllerSegue]) {
        self.peripheralsViewController = segue.destinationViewController;
    }
    else if ([segueIdentifier isEqualToString:LXPeripheralDetailsViewControllerSegue]) {
        self.peripheralsViewController = segue.destinationViewController;
    }
    else {
        LXLogDebug(@"Segue with identifier was not handled: '%@'", segueIdentifier);
    }
}

- (void)onShowPeripheralsViewController
{
    if (self.peripheralsViewControllerTopConstraint.constant == 0) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.peripheralsViewControllerTopConstraint.constant = 464;
                             self.scanViewControllerHeightConstraint.constant = 464;
                             [self.view layoutIfNeeded];
                         } completion:^(BOOL finished) {}];

    }
    else {
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.peripheralsViewControllerTopConstraint.constant = 0;
                             [self.view layoutIfNeeded];
                         } completion:^(BOOL finished) {}];
    }
}

- (void)onHidePeripheralsViewController
{
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.peripheralsViewControllerTopConstraint.constant = -240;
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {}];
}

- (void)onPeripheralSelected:(LXPeripheral *)peripheral
{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.peripheralsViewControllerTopConstraint.constant = -240;
                         self.scanViewControllerHeightConstraint.constant = 0;
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {}];
}

@end
