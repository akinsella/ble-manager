//
// Created by Alexis Kinsella on 11/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "LXPeripheralServiceTableViewCell.h"
#import "LXPeripheralService.h"

@interface LXPeripheralServiceTableViewCell ()

@property (nonatomic, strong)LXPeripheralService *peripheralService;

@end

@implementation LXPeripheralServiceTableViewCell

- (void)configureWithPeripheralService:(LXPeripheralService *)peripheralService forIndexPath:(NSIndexPath *)path
{
    self.peripheralService = peripheralService;

    self.nameAndUuidLabel.text = [NSString stringWithFormat:@"%@", peripheralService.identifier];
    self.typeLabel.text = @"";
}

@end