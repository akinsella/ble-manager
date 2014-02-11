//
// Created by Alexis Kinsella on 11/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "LXPeripheralServicesViewController.h"
#import "XBReloadableArrayDataSource.h"
#import "LXPeripheralService.h"
#import "LXPeripheralServiceTableViewCell.h"
#import "XBBundleJsonDataLoader.h"
#import "LXPeripheral.h"
#import "LXConstant.h"

@interface LXPeripheralServicesViewController ()

@property (nonatomic, strong)XBReloadableArrayDataSource *peripheralServicesDataSource;

@property (nonatomic, strong)id peripheralSelectedNotificationObserver;

@end

@implementation LXPeripheralServicesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    id<XBDataLoader> dataLoader = [XBBundleJsonDataLoader dataLoaderWithResourcePath:@"services" resourceType:@"json"];
    self.peripheralServicesDataSource = [XBReloadableArrayDataSource dataSourceWithDataLoader:dataLoader];

    [self.peripheralServicesTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.peripheralServicesDataSource ? self.peripheralServicesDataSource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PeripheralServiceCell";

    LXPeripheralService *peripheralService = self.peripheralServicesDataSource[(NSUInteger) indexPath.row];
    LXPeripheralServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell configureWithPeripheralService:peripheralService forIndexPath:indexPath];

    return cell;
}

@end