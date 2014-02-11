//
// Created by Alexis Kinsella on 11/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LXPeripheralService : NSObject

@property(nonatomic, strong, readonly) NSString *identifier;
@property(nonatomic, strong, readonly) NSString *name;
@property(nonatomic, strong, readonly) NSString *type;

- (instancetype)initWithIdentifier:(NSString *)identifier name:(NSString *)name type:(NSString *)type;

+ (instancetype)serviceWithIdentifier:(NSString *)identifier name:(NSString *)name type:(NSString *)type;


@end