//
// Created by Alexis Kinsella on 13/02/2014.
// Copyright (c) 2014 Xebia IT Architects. All rights reserved.
//

#import "LXStoryboards.h"

@implementation LXStoryboards

+ (instancetype)storyboards
{
    return [[LXStoryboards alloc] init];
}

- (UIStoryboard *)mainStoryboard
{
    return [UIStoryboard storyboardWithName:IS_IPAD ? @"MainStoryboard~iPad" : @"MainStoryboard~iPhone" bundle:nil];
}

@end