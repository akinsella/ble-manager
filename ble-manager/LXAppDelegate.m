//
//  LXAppDelegate.m
//  ble-manager
//
//  Created by Alexis Kinsella on 08/02/2014.
//  Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//
#import <Crashlytics/Crashlytics.h>
#import "LXAppDelegate.h"
#import "UIColor+XBAdditions.h"
#import "SDURLCache.h"
#import "Appirater.h"
#import "CBIntrospect.h"

//TODO: Need to change AppID
static NSString *const kAppId = @"1234567890";

@interface LXAppDelegate ()

@property (nonatomic, strong) LXStoryboards *storyboards;
@property (nonatomic, strong) LXAppConfiguration *configuration;

@end

@implementation LXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupCrashlytics];

    [self setupURLCache];

    [self setupConfigurationProvider];

    [self setupMainBundle];

    [self setupAppearance];
    [self setupStoryboards];

    [self setupApplicationRating];

    return YES;
}

- (void)setupStoryboards
{
    self.storyboards = [LXStoryboards storyboards];
}

- (void)setupConfigurationProvider
{
    self.configuration = [LXAppConfiguration appConfiguration];
}

- (void)setupAppearance
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [[UINavigationBar appearance] setTitleTextAttributes: @{
        NSForegroundColorAttributeName: [UIColor colorWithHex:@"#FFFFFF"],
        NSFontAttributeName: [UIFont fontWithName:@"Lobster" size:20.0f]
    }];
}

- (void)setupURLCache
{
    SDURLCache *URLCache = [[SDURLCache alloc] initWithMemoryCapacity:1024*1024*2
                                                         diskCapacity:1024*1024*20
                                                             diskPath:[SDURLCache defaultCachePath]];
    [NSURLCache setSharedURLCache:URLCache];
}


- (void)setupMainBundle
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // transfer the current version number into the defaults so that this correct value will be displayed when the user visit settings page later
    NSString *version = [NSString stringWithFormat:@"%@(%@)", self.configuration.bundleShortVersion, self.configuration.bundleVersion];
    [defaults setObject:version forKey:@"version"];
}

- (void)setupApplicationRating
{
    [Appirater setAppId:kAppId];
    [Appirater setDaysUntilPrompt:1];
    [Appirater setUsesUntilPrompt:10];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:2];

#if TARGET_IPHONE_SIMULATOR || defined(DEBUG)
    [Appirater setDebug:YES];
#else
    [Appirater setDebug:NO];
#endif

}

- (void)setupDCIntrospect
{
// always call after makeKeyAndDisplay.
#if TARGET_IPHONE_SIMULATOR
    [[CBIntrospect sharedIntrospector] start];
#endif
}

- (void)setupCrashlytics
{
    [Crashlytics startWithAPIKey:@"48e99a586053e4194936d79b6126ad23e9de4cc7"];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
