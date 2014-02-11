//
// Created by Alexis Kinsella on 11/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXTableViewCell.h"

@class LXPeripheralService;


@interface LXPeripheralServiceTableViewCell : LXTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameAndUuidLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

- (void)configureWithPeripheralService:(LXPeripheralService *)lxPeripheralService forIndexPath:(NSIndexPath *)path;

@end