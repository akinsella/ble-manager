//
//  LXAppDelegate.h
//  ble-manager
//
//  Created by Alexis Kinsella on 08/02/2014.
//  Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXAppConfiguration.h"
#import "LXStoryboards.h"

@interface LXAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong, readonly) LXStoryboards *storyboards;

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong, readonly) LXAppConfiguration *configuration;

@end
