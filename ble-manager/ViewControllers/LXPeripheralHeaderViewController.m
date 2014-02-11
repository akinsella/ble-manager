//
// Created by Alexis Kinsella on 11/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "LXPeripheralHeaderViewController.h"
#import "LXConstant.h"


@implementation LXPeripheralHeaderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UISwipeGestureRecognizer *swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureForControllerView:)];
    swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUpGestureRecognizer];
    UISwipeGestureRecognizer *swipeDownGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureForControllerView:)];
    swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDownGestureRecognizer];
}

- (void)handleGestureForControllerView:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionDown) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LXShowPeripheralsViewControllerNotification object:self userInfo:@{}];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:LXHidePeripheralsViewControllerNotification object:self userInfo:@{}];
    }
}


@end