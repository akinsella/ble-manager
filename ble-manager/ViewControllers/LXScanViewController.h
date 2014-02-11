//
// Created by Alexis Kinsella on 10/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "CERoundProgressView.h"

@interface LXScanViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet CERoundProgressView *scanRoundProgressView;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;
@property (weak, nonatomic) IBOutlet UIView *peripheralInformationView;

-(IBAction)startScanningAction:(id)sender;

@end
