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


//WRAPPERS



//USE THIS FUNCTION TO WRITE TO FILE
-(void) writeToFile:(NSFileHandle*)fileSys data:(NSString*)data{
    if (self.fileSys != nil) {
        [self.fileSys seekToEndOfFile];
        NSMutableString* toWrite = [NSMutableString stringWithString:data];
        [toWrite appendString:@"|"];
        [self.fileSys writeData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    }
}

//*******************************************************************************

- (void)lblUpdate:(double)velo{
    NSString * numStr = [NSString stringWithFormat:@"%.0f", velo];

    [self.lbl setText:numStr];
}

- (BOOL) addMeasurement:(double)val{
    self.fileSys = [NSFileHandle fileHandleForWritingAtPath:self.currFile];
    //if (self.fileSys != nil) {
        NSString* valStr = [NSString stringWithFormat:@"%.0f", val];
        [self writeToFile:self.fileSys data:valStr];
        return TRUE;
    //}
    //return FALSE;
}

- (void) tick{
    //get the location
    self.loc = [self.cllManager location];
    //get the speed
    double velo = self.loc.speed;
    
    //update the label
    [self lblUpdate:velo];
    
    //add the measurement and alert user if measurement was not added
    if(![self addMeasurement:velo]){
        [self lblUpdate:-1];
        [self.activeLabel setText:@"SPEED NOT ADDED"];
    }
}

- (void) stopUISetup{
    //enable and disable the correct buttons
    [self.RunBtn setEnabled:YES];
    [self.StopBtn setEnabled:NO];
    //set the descriptive label to inactive
    [self.activeLabel setText:@"Inactive..."];
    //remove the animation
    [[[self activeLabel] layer] removeAnimationForKey:@"pulse"];
    [self.lbl setText:@"0"];
}

- (void) stopLocation{
    //Stop updating the location.  Will save battery.
    [self.cllManager stopUpdatingLocation];
    self.cllManager = nil;
}

- (void) stopFile{
    [self.fileSys closeFile];
}

//Handles when the stop button is pressed
- (IBAction)onStop:(id)sender {
    
    //set the UI to the stop state
    [self stopUISetup];
    
    //set the location to a stopped state
    [self stopLocation];
    
    //close up the file
    [self stopFile];
    
    //end the label timer
    [self.lblTimer invalidate];
}

//sets up the initialization of all of the parts when run is called
- (void) runInitializations{
    
    self.lblLog = [[Log alloc] init];
    self.cllManager = [[CLLocationManager alloc] init];
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.cllManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.cllManager requestWhenInUseAuthorization];
    }
    
    //set the accuracy
    self.cllManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    //begin updating
    [self.cllManager startUpdatingLocation];
    
}

- (void) runUISetup{
    
    //enable and disable the correct buttons
    [self.StopBtn setEnabled:YES];
    [self.RunBtn setEnabled:NO];
    
    //set the descriptive label to running
    [self.activeLabel setText:@"Running..."];
    
    //set the animation
    [[[self activeLabel] layer] addAnimation:self.anim forKey:@"pulse"];
}

-(void) runFileSetup:(double)rate{
    NSDate* date = [NSDate date];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM_dd_yyyy___HH_mm_ss"];
    NSString* dateStr = [NSString stringWithString:[df stringFromDate:date]];
    NSMutableString* path = [NSMutableString stringWithString:@"Documents/"];
    [path appendString:dateStr];
    [path appendString:@".log"];
    self.currFile = path;
    self.fileSys = [NSFileHandle fileHandleForWritingAtPath:self.currFile];
    
    //create meta data
    NSMutableString* toWrite = [NSMutableString stringWithString:dateStr];
    [toWrite appendString:@"|"];
    [toWrite appendString:[NSString stringWithFormat:@"%f|", rate]];
    
    //write to the file
    [self writeToFile:self.fileSys data:toWrite];
}

//Handles when the run button is pressed
- (IBAction)onRun:(id)sender{
    
    //intitalize the parts needed for log
    [self runInitializations];
    
    //change the UI for the run state
    [self runUISetup];
    
    //get the file ready for initiliazation
    [self runFileSetup:self.RATE];
    
    //start the timer for updating the label
    self.lblTimer = [NSTimer scheduledTimerWithTimeInterval: self.RATE target:self selector: @selector(tick) userInfo:nil repeats:YES];
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
    
    self.RATE = 1.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
