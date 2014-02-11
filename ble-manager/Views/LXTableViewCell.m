//
//  LXTableViewCell.m
//  xebia-ios
//
//  Created by Alexis Kinsella on 23/06/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import "LXTableViewCell.h"
#import "LXAppDelegate.h"
#import "UIColor+XBAdditions.h"

@interface LXTableViewCell ()

@property (nonatomic, strong)CAShapeLayer *separatorLineShapeLayer;
@property (nonatomic, strong)CAShapeLayer *selectedSeparatorLineShapeLayer;

@end

@implementation LXTableViewCell

#pragma mark - Cell Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureCell];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configureCell];
    }

    return self;
}

#pragma mark - Cell configuration

- (void)configureCell
{
    [self initBackgroundView];
    [self initSelectedBackgroundView];

    self.leftSeparatorInset = 10;
    self.rightSeparatorInset = 10;
    self.separatorLineColor = [UIColor colorWithHex:@"#dde2e8"];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithHex:@"#eff2f7"];
    self.showSeparatorLine = YES;
    self.showSelectedSeparatorLine = NO;
}

#pragma mark - Views and Layers creation

- (void)initBackgroundView
{
    self.backgroundView = [self createBackgroundView];

    self.separatorLineShapeLayer = [self createSeparatorLineShapeLayer];
    self.separatorLineShapeLayer.hidden = NO;
    [self.backgroundView.layer insertSublayer:self.separatorLineShapeLayer atIndex:0];
}

- (void)initSelectedBackgroundView
{
    self.selectedBackgroundView = [self createBackgroundView];

    self.selectedSeparatorLineShapeLayer = [self createSeparatorLineShapeLayer];
    self.selectedSeparatorLineShapeLayer.hidden = YES;
    [self.selectedBackgroundView.layer insertSublayer:self.selectedSeparatorLineShapeLayer atIndex:0];
}

- (UIView *)createBackgroundView
{
    return [[UIView alloc] init];
}

- (CAShapeLayer *)createSeparatorLineShapeLayer
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];

    shapeLayer.bounds = self.bounds;
    shapeLayer.position = self.center;
    shapeLayer.fillColor = [UIColor lightGrayColor].CGColor;
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.lineJoin = kCALineJoinRound;

    return shapeLayer;
}

#pragma mark - Properties overrides
- (void)setShowSeparatorLine:(BOOL)showSeparatorLine
{
    _showSeparatorLine = showSeparatorLine;

    self.separatorLineShapeLayer.hidden = !showSeparatorLine;

    [self setNeedsDisplay];
}

#pragma mark - Properties overrides
- (void)setShowSelectedSeparatorLine:(BOOL)showSelectedSeparatorLine
{
    _showSeparatorLine = showSelectedSeparatorLine;

    self.selectedSeparatorLineShapeLayer.hidden = !showSelectedSeparatorLine;

    [self setNeedsDisplay];
}

- (void)setLeftSeparatorInset:(CGFloat)leftSeparatorInset
{
    _leftSeparatorInset = leftSeparatorInset;

    [self setNeedsLayout];
}

- (void)setRightSeparatorInset:(CGFloat)rightSeparatorInset
{
    _rightSeparatorInset = rightSeparatorInset;

    [self setNeedsLayout];
}

- (void)setSeparatorLineColor:(UIColor *)separatorLineColor
{
    _separatorLineColor = separatorLineColor;

    self.separatorLineShapeLayer.fillColor = separatorLineColor.CGColor;
    self.separatorLineShapeLayer.strokeColor = separatorLineColor.CGColor;
    self.selectedSeparatorLineShapeLayer.fillColor = separatorLineColor.CGColor;
    self.selectedSeparatorLineShapeLayer.strokeColor = separatorLineColor.CGColor;

    [self setNeedsDisplay];
}

#pragma mark - Layout lifecycle

-(void)layoutSubviews
{
    [super layoutSubviews];

    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];

    [self updateLayoutForSeparatorLayer:self.separatorLineShapeLayer];
    [self updateLayoutForSeparatorLayer:self.selectedSeparatorLineShapeLayer];
}

-(void)updateLayoutForSeparatorLayer:(CAShapeLayer *)shapeLayer
{
    shapeLayer.bounds = self.bounds;
    shapeLayer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);

    CGMutablePathRef path = CGPathCreateMutable();

    CGPathMoveToPoint(path, NULL, self.leftSeparatorInset, self.bounds.size.height);
    CGPathAddLineToPoint(path, NULL, self.bounds.size.width - self.rightSeparatorInset, self.bounds.size.height);

    shapeLayer.path = path;
}

#pragma mark - Helper properties

- (LXAppDelegate *) appDelegate
{
    return (LXAppDelegate *) [[UIApplication sharedApplication] delegate];
}

@end
