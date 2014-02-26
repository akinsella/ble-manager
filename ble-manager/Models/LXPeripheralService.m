//
// Created by Alexis Kinsella on 11/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "LXPeripheralService.h"


@interface LXPeripheralService ()

@property(nonatomic, strong) NSString *identifier;
@property(nonatomic, assign) BOOL primary;

@end

@implementation LXPeripheralService

- (instancetype)initWithIdentifier:(NSString *)identifier primary:(BOOL)primary
{
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.primary = primary;
    }

    return self;
}

+ (instancetype)serviceWithIdentifier:(NSString *)identifier primary:(BOOL)primary
{
    return [[self alloc] initWithIdentifier:identifier primary:primary];
}

@end