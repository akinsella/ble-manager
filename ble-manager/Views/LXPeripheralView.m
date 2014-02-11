//
// Created by Alexis Kinsella on 09/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "LXPeripheralView.h"
#import "UIColor+XBAdditions.h"

@interface LXPeripheralView ()

@property (nonatomic, strong) LXPeripheral *lxPeripheral;
@property (nonatomic, strong) CALayer *tapLayer;

@end

@implementation LXPeripheralView

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self configureLayers];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    UIColor *bodyColor = backgroundColor;
    UIColor *headerColor = [bodyColor darkerColorWithRatio:0.25];
    self.bodyView.backgroundColor = bodyColor;
    self.headerView.backgroundColor = headerColor;
}


- (void)updateWithPeripheral:(LXPeripheral *)lxPeripheral
{
    self.lxPeripheral = lxPeripheral;

    self.parentView.layer.cornerRadius = 2;

    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 1;

    self.nameLabel.text = lxPeripheral.name;
    self.uuidLabel.text = lxPeripheral.identifier;
    self.rssiLabel.text = [NSString stringWithFormat:@"%@", lxPeripheral.rssi];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.tapLayer.opacity = 0.25;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    self.tapLayer.opacity = 0.25;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.tapLayer.opacity = 0;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.tapLayer.opacity = 0;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.tapLayer.frame = self.parentView.frame;
}

- (void)configureLayers
{
    self.tapLayer = [CALayer layer];
    self.tapLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.tapLayer.opacity = 0;
    [self.layer insertSublayer:self.tapLayer atIndex:self.layer.sublayers.count];
}

@end