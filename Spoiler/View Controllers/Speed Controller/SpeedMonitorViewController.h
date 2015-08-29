//
//  SpeedMonitorViewController.h
//  Spoiler
//
//  Created by Tausif Ahmed on 4/16/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "Log.h"

#define CENTER_X self.view.center.x
#define CENTER_Y self.view.center.y

#define FRAME_WIDTH self.view.frame.size.width
#define FRAME_HEIGHT self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height

#define BUTTON_WIDTH self.view.frame.size.width/3
#define BUTTON_HEIGHT (self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height)/10

#define SPEED_HEIGHT (self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height)/8

@interface SpeedMonitorViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UIButton *stopButton;

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

@property bool madeValidMeasurement;

@property (strong, nonatomic) SharedData *sharedData;

@end
