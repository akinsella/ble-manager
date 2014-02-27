//
// Created by Alexis Kinsella on 11/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "LXPeripheralServicesViewController.h"
#import "LXPeripheralService.h"
#import "LXPeripheralServiceTableViewCell.h"
#import "LXConstant.h"
#import "LXPeripheralManager.h"
#import "UIColor+XBAdditions.h"
#import <SVPullToRefresh/SVPullToRefresh.h>

@interface LXPeripheralServicesViewController ()

@property(nonatomic, strong) id peripheralSelectedNotificationObserver;

@property(nonatomic, strong) LXPeripheral *lxPeripheral;

@end

@implementation LXPeripheralServicesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureTableView];
    [self configureEmptyView];
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
    typeof (self) weakSelf = self;
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

- (void)configureEmptyView
{
    self.peripheralServicesTableView.emptyView = [[NSBundle mainBundle] loadNibNamed:@"LXEmptyView" owner:nil options:nil][0];
    self.peripheralServicesTableView.emptyView.backgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
}

- (void)configureTableView
{
    typeof (self) weakSelf = self;

    [self.peripheralServicesTableView addPullToRefreshWithActionHandler:^{
        [weakSelf scanServices];
    }];

    self.peripheralServicesTableView.pullToRefreshView.arrowColor = [UIColor colorWithHex:@"#275591"];
    self.peripheralServicesTableView.pullToRefreshView.textColor = [UIColor colorWithHex:@"#275591"];
    self.peripheralServicesTableView.pullToRefreshView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}


#pragma mark - Action

- (void)scanServices
{
    self.peripheralServicesTableView.showsPullToRefresh = NO;
    LXPeripheralManager *peripheralManager = [LXPeripheralManager managerWithPeripheral:self.lxPeripheral];

    [peripheralManager discoverServicesWithTimeout:5 completion:^(NSError *error) {
        [self.peripheralServicesTableView reloadData];
        self.peripheralServicesTableView.showsPullToRefresh = YES;
    }];
}


# pragma mark - Event

- (void)onPeripheralSelected:(LXPeripheral *)lxPeripheral
{
    self.lxPeripheral = lxPeripheral;
    [self.peripheralServicesTableView reloadData];

    [self scanServices];
}


# pragma mark - TableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lxPeripheral ? self.lxPeripheral.services.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PeripheralServiceCell";

    LXPeripheralService *peripheralService = self.lxPeripheral.services[(NSUInteger) indexPath.row];
    LXPeripheralServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell configureWithPeripheralService:peripheralService forIndexPath:indexPath];

    return cell;
}

@end