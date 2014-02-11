//
//  LXTableViewCell.h
//  xebia-ios
//
//  Created by Alexis Kinsella on 23/06/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXAppDelegate.h"

@interface LXTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly)LXAppDelegate *appDelegate;

@property (nonatomic, assign)BOOL showSeparatorLine;
@property (nonatomic, assign)BOOL showSelectedSeparatorLine;
@property (nonatomic, assign)CGFloat leftSeparatorInset;
@property (nonatomic, assign)CGFloat rightSeparatorInset;
@property (nonatomic, strong)UIColor *separatorLineColor;

- (void)configureCell;

@end
