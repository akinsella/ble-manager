//
//  LXDiscoveryViewController.h
//  ble-manager
//
//  Created by Alexis Kinsella on 08/02/2014.
//  Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//


@interface LXPeripheralsViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *peripheralCollectionView;

@end
