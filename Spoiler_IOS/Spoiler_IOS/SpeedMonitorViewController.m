//
//  SpeedMonitorViewController.m
//  Spoiler_IOS
//
//  Created by Tausif Ahmed on 9/16/14.
//  Copyright (c) 2014 Spoiler. All rights reserved.
//

#import "SpeedMonitorViewController.h"

@interface SpeedMonitorViewController ()

@end

@implementation SpeedMonitorViewController

- (void)lblUpdate{
    //number of times the lbl was updated
    self.counter++;
    
    //DEBUGGING LINE FOR THE TIMER
    //NSString * numStr = [NSString stringWithFormat:@"%d",self.counter];
    
    //The correct version but using above for debugging
    NSString * numStr = [NSString stringWithFormat:@"%.0f", [self.lblLog getSpeed]];
    [self.lbl setText:numStr];
}

//Handles when the stop button is pressed
- (IBAction)onStop:(id)sender {
    //enable and disable the correct buttons
    [self.RunBtn setEnabled:YES];
    [self.StopBtn setEnabled:NO];
    //set the descriptive label to inactive
    [self.activeLabel setText:@"Inactive..."];
    //remove the animation
    [[[self activeLabel] layer] removeAnimationForKey:@"pulse"];
    //end the label timer
    [self.lblTimer invalidate];
}

//Handles when the run button is pressed
- (IBAction)onRun:(id)sender{
    self.counter = 0;
    self.lblLog = [[Log alloc] init];
    
    //enable and disable the correct buttons
    [self.StopBtn setEnabled:YES];
    [self.RunBtn setEnabled:NO];
    
    //set the descriptive label to running
    [self.activeLabel setText:@"Running..."];
    //set the animation
    [[[self activeLabel] layer] addAnimation:self.anim forKey:@"pulse"];
    
    //start the timer for updating the label
    self.lblTimer = [NSTimer scheduledTimerWithTimeInterval: .5 target:self selector: @selector(lblUpdate) userInfo:nil repeats:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.StopBtn setEnabled:NO];
    [self.RunBtn setEnabled:YES];
    
    //setup the pulsing animation for the active label
    self.anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [self.anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.anim setRepeatCount:HUGE_VALF];
    [self.anim setFromValue:[NSNumber numberWithFloat:.25]];
    [self.anim setToValue:[NSNumber numberWithFloat:1.0]];
    [self.anim setAutoreverses:YES];
    [self.anim setDuration:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
