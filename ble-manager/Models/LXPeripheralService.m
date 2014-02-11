//
// Created by Alexis Kinsella on 11/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "LXPeripheralService.h"


@interface LXPeripheralService ()

@property(nonatomic, strong) NSString *identifier;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *type;

@end

@implementation LXPeripheralService

- (instancetype)initWithIdentifier:(NSString *)identifier name:(NSString *)name type:(NSString *)type
{
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.name = name;
        self.type = type;
    }

    return self;
}

+ (instancetype)serviceWithIdentifier:(NSString *)identifier name:(NSString *)name type:(NSString *)type
{
    return [[self alloc] initWithIdentifier:identifier name:name type:type];
}

@end