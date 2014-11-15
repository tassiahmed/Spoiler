//
//  SpeedMonitorViewController.m
//  Spoiler_IOS
//
//  Evan Thompson, Tausif Ahmed
//  Copyright (c) 2014 Spoiler. All rights reserved.
//

#import "SpeedMonitorViewController.h"

@interface SpeedMonitorViewController ()

@end

@implementation SpeedMonitorViewController

- (void)lblUpdate{
    //number of times the lbl was updated
    self.counter++;
    
    //using loc in the header
    self.loc = [self.cllManager location];
    NSString * numStr = [NSString stringWithFormat:@"%.0f", [self.loc speed]];

    [self.lbl setText:numStr];
}

//Handles when the stop button is pressed
- (IBAction)onStop:(id)sender {
    //enable and disable the correct buttons
    [self.RunBtn setEnabled:YES];
    [self.StopBtn setEnabled:NO];
    //set the descriptive label to inactive
    [self.activeLabel setText:@"Inactive..."];
    
    //Stop updating the location.  Will save battery.
    [self.cllManager stopUpdatingLocation];
    self.cllManager = nil;
    
    //remove the animation
    [[[self activeLabel] layer] removeAnimationForKey:@"pulse"];
    //end the label timer
    [self.lblTimer invalidate];
    [self.lbl setText:@"0"];
}

//Handles when the run button is pressed
- (IBAction)onRun:(id)sender{
    self.counter = 0;
    self.lblLog = [[Log alloc] init];
    
    //enable and disable the correct buttons
    [self.StopBtn setEnabled:YES];
    [self.RunBtn setEnabled:NO];
    
    
    //start updating the location
    self.cllManager = [[CLLocationManager alloc] init];
    
    
    //need to check for gps here later
    //No good way of doing it at the moment
    
    [self.cllManager startUpdatingLocation];
    
    //self.loc = [[CLLocation alloc] init];
    
    //set the descriptive label to running
    [self.activeLabel setText:@"Running..."];
    //set the animation
    [[[self activeLabel] layer] addAnimation:self.anim forKey:@"pulse"];
    
    //start the timer for updating the label
    self.lblTimer = [NSTimer scheduledTimerWithTimeInterval: .5 target:self selector: @selector(lblUpdate) userInfo:nil repeats:YES];
}

-(void) setupAnim{
    //setup the pulsing animation for the active label
        self.anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [self.anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.anim setRepeatCount:HUGE_VALF];
    [self.anim setFromValue:[NSNumber numberWithFloat:.25]];
    [self.anim setToValue:[NSNumber numberWithFloat:1.0]];
    [self.anim setAutoreverses:YES];
    [self.anim setDuration:1.0];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.StopBtn setEnabled:NO];
    [self.RunBtn setEnabled:YES];
    [self setupAnim];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
