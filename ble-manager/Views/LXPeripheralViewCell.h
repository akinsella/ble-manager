//
// Created by Alexis Kinsella on 09/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXPeripheralView.h"
#import "LXPeripheral.h"

@interface LXPeripheralViewCell : UICollectionViewCell

- (void)configureWithPeripheral:(LXPeripheral *)peripheral backgroundColor:(UIColor *)backgroundColor forIndexPath:(NSIndexPath *)path;

@end