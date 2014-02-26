//
// Created by Alexis Kinsella on 11/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LXPeripheralService : NSObject

@property(nonatomic, strong, readonly) NSString *identifier;
@property(nonatomic, assign, readonly) BOOL primary;

- (instancetype)initWithIdentifier:(NSString *)identifier primary:(BOOL)primary;

+ (instancetype)serviceWithIdentifier:(NSString *)identifier primary:(BOOL)primary;


@end