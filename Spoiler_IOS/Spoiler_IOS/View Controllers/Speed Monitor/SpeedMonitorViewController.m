//
//  SpeedMonitorViewController.m
//  Spoiler_IOS
//
//  Evan Thompson, Tausif Ahmed
//  Copyright (c) 2014 Spoiler. All rights reserved.
//

#import "SpeedMonitorViewController.h"
#import "LogViewController.h"

@interface SpeedMonitorViewController ()  @end

@implementation SpeedMonitorViewController

#pragma mark - File Writing

//=========================================//
//======    File Writing Functions    =====//
//=========================================//

// Function to open up a file to write measurements to
-(void) writeToFile:(NSFileHandle*)fileSys data:(NSString*)data {
//    NSLog(@"Writing to file (%@) : %@", self.currFile, data);
        [self.fileSys seekToEndOfFile];
        [self.fileSys writeData:[data dataUsingEncoding:NSASCIIStringEncoding]];
}

// Function to write a new measurement to the open file
- (BOOL) addMeasurement:(double)val {
    self.fileSys = [NSFileHandle fileHandleForWritingAtPath:self.currFile];
    NSString* valStr = [NSString stringWithFormat:@"%.0f|", val];
    [self writeToFile:self.fileSys data:valStr];
    return TRUE;
}

// Function to close the file for writing
- (void) stopFile {
    [self.fileSys closeFile];
}

// Function to prepare file for writing measurements into
-(void) runFileSetup:(double)rate {
    
    // Retrieve the current date
    NSDate* date = [NSDate date];
    
    // Initialize object to format date correctly
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM_dd_yyyy_HH_mm_ss"];
    
    // Format strings to generate log file name
    NSString* dateStr = [NSString stringWithString:[df stringFromDate:date]];
    NSString* docsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* name = [NSString stringWithFormat:@"%@.log",dateStr];
    
    
    NSString* path = [docsDir stringByAppendingPathComponent:name];
    
    // Make a reference to new file for writing
    self.currFile = path;
    self.fileSys = [NSFileHandle fileHandleForWritingAtPath:self.currFile];
    
    // Create meta data
    NSString* toWrite = [NSString stringWithFormat:@"%@|%f|", name, rate];
        
    // Create file manager for writing measurements
    NSFileManager* manager = [NSFileManager defaultManager];
    [manager createFileAtPath:self.currFile contents: [toWrite dataUsingEncoding:NSASCIIStringEncoding] attributes:nil];
    
    // Write to the file
    [self writeToFile:self.fileSys data:toWrite];
}

#pragma mark - UI

//=========================================//
//======         UI Functions         =====//
//=========================================//

// Function to update the speed displayed on the app page
- (void)lblUpdate:(double)velo {
    NSString * numStr = [NSString stringWithFormat:@"%.0f", velo];
    [self.lbl setText:numStr];
}

// Function to set up animations
-(void) setupAnim {
    
    // Setup the pulsing animation for the active label
    self.anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [self.anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.anim setRepeatCount:HUGE_VALF];
    [self.anim setFromValue:[NSNumber numberWithFloat:.25]];
    [self.anim setToValue:[NSNumber numberWithFloat:1.0]];
    [self.anim setAutoreverses:YES];
    [self.anim setDuration:1.0];
}

// Function to change UI when user starts gathering speed
- (void) runUISetup {
    
    // Enable and disable the correct buttons
    [self.StopBtn setEnabled:YES];
    [self.RunBtn setEnabled:NO];
    
    // Set the descriptive label to running
    [self.activeLabel setText:@"Running..."];
    
    // Enable the animation
    [[[self activeLabel] layer] addAnimation:self.anim forKey:@"pulse"];
}

// Function to change the UI upon user
// indicating they are done recording their speed
- (void) stopUISetup {
    
    // Enable and disable the correct buttons
    [self.RunBtn setEnabled:YES];
    [self.StopBtn setEnabled:NO];
    
    // Set the descriptive label to inactive
    [self.activeLabel setText:@"Inactive..."];
    
    // Disable the animation
    [[[self activeLabel] layer] removeAnimationForKey:@"pulse"];
    [self.lbl setText:@"0"];
}

# pragma mark - Location

//=========================================//
//======      Location Functions      =====//
//=========================================//

// Function that is called at the rate of RATE
// to get location and data and parse needed data from it


- (void) tick {
    
    /*
     
    // Store the retrieved location in loc
    self.loc = [self.cllManager location];
    
    // Retrieve speed from the stored location data
    double velo = self.loc.speed;
    
    // modify it by the appropriate speed system
    velo *= self.sharedData.speed_conv;
    
    // Update the label
    [self lblUpdate:velo];
    
    // Add the measurment and check to see if the measurement has been added,
    // if not print out an error text alerting user
    if(![self addMeasurement:velo]){
        [self lblUpdate:-1];
        [self.activeLabel setText:@"SPEED NOT ADDED"];
    }
    
     */
    
}

// Function to stop retreiving location
- (void) stopLocation {
    
    // Stop updating the location.  Will save battery.
    [self.cllManager stopUpdatingLocation];
}

# pragma mark - Start/Stop

//=========================================//
//======     Start/Stop Functions     =====//
//=========================================//

// Function that intializes all necessary parts for gathering speed
- (void) runInitializations {
    
    // Set up the Log
    self.lblLog = [[Log alloc] init];
    
    // Initialize the CLLocationManager
    self.cllManager = [[CLLocationManager alloc] init];
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.cllManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.cllManager requestWhenInUseAuthorization];
    }
    
    // Set the accuracy of CLLocationManager
    [self.cllManager setDelegate:self];
    [self.cllManager setPausesLocationUpdatesAutomatically:NO];
    [self.cllManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    [self.cllManager setDistanceFilter:kCLDistanceFilterNone];
    
    // Begin updating
    [self.cllManager startUpdatingLocation];
}

// Function that is called when the run button is pressed
- (IBAction)onRun:(id)sender {
    
    // Intitalize the parts needed for log
    [self runInitializations];
    
    // Change the UI for the run state
    [self runUISetup];
    
    // Get the file ready for initiliazation
    [self runFileSetup:self.RATE];
    
    // Start the timer for updating the label
    self.lblTimer = [NSTimer scheduledTimerWithTimeInterval: self.sharedData.rate target:self selector: @selector(tick) userInfo:nil repeats:YES];
}

// Function that executed when the user presse the Stop button
- (IBAction)onStop:(id)sender {
    
    // Set the UI to the stop state
    [self stopUISetup];
    
    // Set the location to a stopped state
    [self stopLocation];
    
    // Close up the file
    [self stopFile];
    
    // End the label timer
    [self.lblTimer invalidate];
}

#pragma mark - Overriden

//=========================================//
//======      Overriden Functions     =====//
//=========================================//


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.StopBtn setEnabled:NO];
    [self.RunBtn setEnabled:YES];
    [self setupAnim];
    
    if (!self.sharedData) {
        self.sharedData = [[SharedData alloc] init];
    }
    
    [self.unitLabel setText: [self.sharedData get_unit_type]];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    // NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
        double velo = currentLocation.speed;
        
        // modify it by the appropriate speed system
        velo *= self.sharedData.speed_conv;
        
        // Update the label
        [self lblUpdate:velo];
        
        // Add the measurment and check to see if the measurement has been added,
        // if not print out an error text alerting user
        if(![self addMeasurement:velo]){
            [self lblUpdate:-1];
            [self.activeLabel setText:@"SPEED NOT ADDED"];
        }
    }
}

@end
