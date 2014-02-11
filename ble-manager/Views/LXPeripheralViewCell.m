//
// Created by Alexis Kinsella on 09/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "LXPeripheralViewCell.h"


@interface LXPeripheralViewCell ()

@property (weak, nonatomic) LXPeripheralView *peripheralView;

@property (nonatomic, strong) LXPeripheral *peripheral;

@end

@implementation LXPeripheralViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.peripheralView = [[NSBundle mainBundle] loadNibNamed:@"LXPeripheralView" owner:self options:nil][0];
    [self addSubview:self.peripheralView];
}


- (void)configureWithPeripheral:(LXPeripheral *)peripheral backgroundColor:(UIColor *)backgroundColor forIndexPath:(NSIndexPath *)path
{
    self.peripheral = peripheral;

    self.peripheralView.backgroundColor = backgroundColor;
    self.peripheralView.layer.cornerRadius = 2;
    [self.peripheralView updateWithPeripheral:peripheral];
}

@end