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

//@property (nonatomic, retain) IBOutlet UIButton *RunBtn;
//@property (nonatomic, retain) IBOutlet UIButton *StopBtn;
@property (weak, nonatomic) IBOutlet UIButton *RunBtn;
@property (weak, nonatomic) IBOutlet UIButton *StopBtn;
@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UILabel *activeLabel;
//updates the label
@property NSTimer * lblTimer;
//the log for the update
@property Log*  lblLog;
//pulsing animation
@property CABasicAnimation * anim;

@property CLLocation* loc;

@property (nonatomic, strong) CLLocationManager* cllManager;

@property NSFileHandle* fileSys;
@property NSString* currFile;

@property NSTimeInterval RATE;

//used for debugging.  Total number of measurements taken
@property int counter;

@end
