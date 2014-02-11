//
//  LXDiscoveryViewController.h
//  ble-manager
//
//  Created by Alexis Kinsella on 08/02/2014.
//  Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

@interface LXDiscoveryViewController : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *peripheralsViewControllerTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanViewControllerHeightConstraint;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

- (void)onShowPeripheralsViewController;
@end
