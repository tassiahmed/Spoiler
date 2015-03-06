//
//  SpeedMonitorViewController.h
//  Spoiler_IOS
//
//  Created by Tausif Ahmed on 9/16/14.
//  Copyright (c) 2014 Spoiler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Log.h"

@interface SpeedMonitorViewController : UIViewController

// Action variables connected to app page
@property (weak, nonatomic) IBOutlet UIButton *RunBtn;
@property (weak, nonatomic) IBOutlet UIButton *StopBtn;
@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UILabel *activeLabel;

// Timer for updating the label
@property NSTimer * lblTimer;

// Log that is being measured
@property Log*  lblLog;

// Pulsing animation that occurs during app runtime
@property CABasicAnimation * anim;

// Object to retrieve location and to return current driving speed
@property (strong) CLLocation* loc;

// Object to handle the CLLocation object so that it behaves as desired
@property (nonatomic, strong) CLLocationManager* cllManager;

// Variables to handle loging and storing information into log and then
// insert that into device's local memory
@property NSFileHandle* fileSys;
@property NSString* currFile;

// The rate at which measurements from CLLocation is gathered
@property NSTimeInterval RATE;

// DEBUGGING purposes.  Total number of measurements taken
@property int counter;

@end
