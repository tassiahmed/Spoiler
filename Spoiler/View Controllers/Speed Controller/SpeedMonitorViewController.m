//
//  SpeedMonitorViewController.m
//  Spoiler
//
//  Created by Tausif Ahmed on 4/16/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import "SpeedMonitorViewController.h"

@interface SpeedMonitorViewController() @end

@implementation SpeedMonitorViewController

#pragma mark - View & Misc.

- (void) viewDidLoad {
    [super viewDidLoad];
    
    if (!self.sharedData) {
        self.sharedData = [[SharedData alloc] init];
    }
	
	[self setupAnimation];
	[self setUpSpeedMonitor];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be created
}

#pragma mark - Initialization

// Function to set up animations
- (void) setupAnimation {
    
    // Setup the pulsing animation for the active label
    self.animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [self.animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.animation setRepeatCount:HUGE_VALF];
    [self.animation setFromValue:[NSNumber numberWithFloat:.25]];
    [self.animation setToValue:[NSNumber numberWithFloat: 1.0]];
    [self.animation setAutoreverses: YES];
    [self.animation setDuration:1.0];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void) setUpSpeedMonitor {
	
    [self.view setBackgroundColor: [UIColor blackColor]];
    
	[self setUpNameLabel];
    
	[self setUpStartButton];
    
	[self setUpStopButton];
	
	[self setUpStatusLabel];
    
	[self setUpSpeedLabel];
    
	[self setUpUnitLabel];
	
	self.madeValidMeasurement = false;
    
//	self.log = [[Log alloc] init];
	
	[self setUpCLLManager];
}

- (void) setUpNameLabel {
	UILabel *name = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, BUTTON_WIDTH + 125, SPEED_HEIGHT)];
	[name setText: @"Speed Monitor"];
	[name setCenter: CGPointMake(CENTER_X, CENTER_Y/3)];
	[name setFont: [name.font fontWithSize: 30]];
	[name setTextColor: [UIColor whiteColor]];
	[name.layer setCornerRadius: 10];
	[name.layer setBorderWidth: 5];
	[name.layer setBorderColor: [UIColor whiteColor].CGColor];
	[name setTextAlignment: NSTextAlignmentCenter];
	[self.view addSubview: name];
}

- (void) setUpStartButton {
	self.startButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
	[self.startButton setTitle: @"Start" forState: UIControlStateNormal];
	[self.startButton setFrame: CGRectMake(0.0,
										   FRAME_HEIGHT - BUTTON_HEIGHT,
										   BUTTON_WIDTH,
										   BUTTON_HEIGHT)];
	[self.startButton setEnabled: YES];
	[self.startButton setTitleColor: [UIColor blueColor] forState: UIControlStateNormal];
	[self.startButton setTitleColor: [UIColor grayColor] forState: UIControlStateDisabled];
	[self.startButton setUserInteractionEnabled: YES];
	[self.startButton.titleLabel setFont: [self.startButton.titleLabel.font fontWithSize: 25]];
	[self.startButton addTarget: self action: @selector(runButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.startButton.layer setCornerRadius: 10];
	[self.startButton.layer setBorderWidth: 5];
	[self.startButton.layer setBorderColor: [UIColor blueColor].CGColor];
	[self.view addSubview: self.startButton];
}

- (void) setUpStopButton {
	self.stopButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
	[self.stopButton setTitle: @"Stop" forState: UIControlStateNormal];
	[self.stopButton setFrame: CGRectMake(FRAME_WIDTH - BUTTON_WIDTH,
										  FRAME_HEIGHT - BUTTON_HEIGHT,
										  BUTTON_WIDTH,
										  BUTTON_HEIGHT)];
	[self.stopButton setEnabled: NO];
	[self.stopButton setTitleColor: [UIColor blueColor] forState: UIControlStateNormal];
	[self.stopButton setTitleColor: [UIColor grayColor] forState: UIControlStateDisabled];
	[self.stopButton setUserInteractionEnabled: YES];
	[self.stopButton.titleLabel setFont: [self.startButton.titleLabel.font fontWithSize: 25]];
	[self.stopButton addTarget: self action: @selector(stopButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.stopButton.layer setCornerRadius: 10];
	[self.stopButton.layer setBorderWidth: 5];
	[self.stopButton.layer setBorderColor: [UIColor grayColor].CGColor];
	[self.view addSubview: self.stopButton];
}

- (void) setUpStatusLabel {
	self.statusLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT)];
	[self.statusLabel setText: @"Inactive..."];
	[self.statusLabel setCenter: CGPointMake(CENTER_X + CENTER_X/20,
											 FRAME_HEIGHT - (BUTTON_HEIGHT/2))];
	[self.statusLabel setFont: [self.startButton.titleLabel.font fontWithSize: 20]];
	[self.statusLabel setTextColor: [UIColor whiteColor]];
	[self.view addSubview: self.statusLabel];
}

- (void) setUpSpeedLabel {
	self.speedLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, BUTTON_WIDTH, SPEED_HEIGHT)];
	[self.speedLabel setText: @"0"];
	[self.speedLabel setCenter: CGPointMake((self.startButton.center.x + self.stopButton.center.x)/2,
											CENTER_Y - (SPEED_HEIGHT - BUTTON_HEIGHT)/2)];
	[self.speedLabel setFont: [self.speedLabel.font fontWithSize: 70]];
	[self.speedLabel setTextColor: [UIColor redColor]];
	[self.view addSubview: self.speedLabel];
}

- (void) setUpUnitLabel {
	self.unitLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_WIDTH)];
	[self.unitLabel setText: [self.sharedData get_unit_type]];
	[self.unitLabel setCenter: CGPointMake(CENTER_X + (BUTTON_WIDTH/2), CENTER_Y)];
	[self.unitLabel setFont: [self.speedLabel.font fontWithSize: 40]];
	[self.unitLabel setTextColor: [UIColor whiteColor]];
	[self.view addSubview: self.unitLabel];
}

- (void) setUpCLLManager {
	self.cllManager = [[CLLocationManager alloc] init];
	
	if ([self.cllManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
		[self.cllManager requestWhenInUseAuthorization];
	}
	
	[self.cllManager setDelegate: self];
	[self.cllManager setPausesLocationUpdatesAutomatically: NO];
	[self.cllManager setDesiredAccuracy: kCLLocationAccuracyBestForNavigation];
	[self.cllManager setDistanceFilter: kCLDistanceFilterNone];
}

#pragma mark - User Actions

- (void) runButtonPressed {
    [self.startButton setEnabled: NO];
    [self.stopButton setEnabled: YES];
    
    [self.startButton.layer setBorderColor: [UIColor grayColor].CGColor];
    [self.stopButton.layer setBorderColor: [UIColor blueColor].CGColor];
    
    [self.statusLabel setText: @"Running..."];
    [[[self statusLabel] layer] addAnimation:self.animation forKey:@"pulse"];
    
    
    [self.cllManager startUpdatingLocation];
    [self runFileSetup: self.RATE];
    
}

- (void) stopButtonPressed {
    [self.startButton setEnabled: YES];
    [self.stopButton setEnabled: NO];
    
    [self.startButton.layer setBorderColor: [UIColor blueColor].CGColor];
    [self.stopButton.layer setBorderColor: [UIColor grayColor].CGColor];
    
    [self.statusLabel setText: @"Inactive..."];
    [[[self statusLabel] layer] removeAnimationForKey:@"pulse"];
    [self.speedLabel setText: @"0"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reload_data" object:self];
    
    [self stopLocation];
    [self stopFile];
    
}

#pragma mark - File Writing

// Function to write a new measurement to the open file
- (void) writeToFile:(NSFileHandle*)fileSys data:(NSString*)data {
    // NSLog(@"Writing to file (%@) : %@", self.file, data);
    [self.fileSys seekToEndOfFile];
    [self.fileSys writeData:[data dataUsingEncoding:NSASCIIStringEncoding]];
}

// Function to write a new measurement to the open file
- (BOOL) addMeasurement:(double)val {
    self.fileSys = [NSFileHandle fileHandleForWritingAtPath:self.file];
    NSString* valStr = [NSString stringWithFormat:@"%.0f|", val];
    [self writeToFile:self.fileSys data:valStr];
    return TRUE;
}

// Function to close the file for writing
- (void) stopFile {
    [self.fileSys closeFile];
	if (!self.madeValidMeasurement) {
		// Delete empty file
		NSFileManager* manager = [NSFileManager defaultManager];
		NSError *error;
		[manager removeItemAtPath:self.file error:&error];
	}
}

// Function to prepare file for writing measurements into
- (void) runFileSetup:(double)rate {
    
    // Retrieve the current date
    NSDate* date = [NSDate date];
    
    // Initialize object to format date correctly
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM_dd_yyyy_HH_mm_ss"];
	
    NSString* dateStr = [NSString stringWithString:[df stringFromDate:date]];
    NSString* name = [NSString stringWithFormat:@"%@.log", dateStr];
	    
    NSString* path = [self.sharedData.log_path stringByAppendingPathComponent:name];
    
    // Make a reference to new file for writing
    self.file = path;
    self.fileSys = [NSFileHandle fileHandleForWritingAtPath:self.file];
    
    // Create meta data
    NSString* toWrite = [NSString stringWithFormat:@"%@|%@|%f|", name,
						 [self.sharedData get_unit_type] ,rate];
    
    // Create file manager for writing measurements
    NSFileManager* manager = [NSFileManager defaultManager];
    [manager createFileAtPath:self.file contents: [toWrite dataUsingEncoding:NSASCIIStringEncoding] attributes:nil];
    
    // Write to the file
    [self writeToFile:self.fileSys data:toWrite];
}

# pragma mark - Location

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithErr or: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    
    double velocity = 0.0;
	
    
    if (self.location != nil) {
        velocity = self.location.speed;
		if (velocity == -1) {
			velocity = 0.0;
		}
        velocity *= self.sharedData.speed_conv;
    }

	if (velocity > 0 && !self.madeValidMeasurement) {
		self.madeValidMeasurement = !self.madeValidMeasurement;
	}
	
    NSString *string_velocity = [NSString stringWithFormat:@"%.0f", velocity];
    [self.speedLabel setText: string_velocity];
    
    if(![self addMeasurement:velocity]){
        velocity = -1;
        string_velocity = [NSString stringWithFormat:@"%.0f", velocity];
        [self.speedLabel setText: string_velocity];
        [self.statusLabel setText:@"SPEED NOT ADDED"];
    }
}

- (void) stopLocation {
    [self.cllManager stopUpdatingLocation];
}

@end