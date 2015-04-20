//
//  SpeedMonitorViewController.h
//  Spoiler_Test
//
//  Created by Tausif Ahmed on 4/16/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "Log.h"

#define BUTTON_WIDTH 100
#define BUTTON_HEIGHT 50
#define SPEED_HEIGHT 80

@interface SpeedMonitorViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property Log *log;

@property UILabel *speedLabel;

@property UILabel *statusLabel;

@property UILabel *unitLabel;

@property CABasicAnimation *animation;

@property NSTimer *timer;

@property (strong) CLLocation *location;

@property (strong, nonatomic) CLLocationManager *cllManager;

@property NSFileHandle *fileSys;

@property NSString *file;

@property NSTimeInterval RATE;

@property (strong, nonatomic) SharedData *sharedData;

@end
