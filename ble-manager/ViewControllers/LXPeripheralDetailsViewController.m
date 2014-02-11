//
// Created by Alexis Kinsella on 11/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "LXPeripheralDetailsViewController.h"
#import "LXPeripheralHeaderViewController.h"
#import "LXConstant.h"

@interface LXPeripheralDetailsViewController ()


@property (nonatomic, strong) LXPeripheralHeaderViewController *peripheralHeaderViewController;


@end

@implementation LXPeripheralDetailsViewController


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
}

- (void)disposeNotificationObservers
{
    LXLogDebug(@"[%d] Removing observers", self.hash);

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *segueIdentifier = [segue identifier];

    if ([segueIdentifier isEqualToString:LXPeripheralHeaderViewControllerSegue]) {
        self.peripheralHeaderViewController = segue.destinationViewController;
    }
    else {
        LXLogDebug(@"Segue with identifier was not handled: '%@'", segueIdentifier);
    }
}


@end