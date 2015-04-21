//
//  SpeedMonitorViewController.m
//  Spoiler_IOS
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
-(void) setupAnimation {
    
    // Setup the pulsing animation for the active label
    self.animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [self.animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.animation setRepeatCount:HUGE_VALF];
    [self.animation setFromValue:[NSNumber numberWithFloat:.25]];
    [self.animation setToValue:[NSNumber numberWithFloat: 1.0]];
    [self.animation setAutoreverses: YES];
    [self.animation setDuration:1.0];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void) setUpSpeedMonitor {
    
    [self.view setBackgroundColor: [UIColor blackColor]];
    
    UILabel *name = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, BUTTON_WIDTH + 125, SPEED_HEIGHT)];
    [name setText: @"Speed Monitor"];
    [name setCenter: CGPointMake(self.view.center.x, self.view.center.y - 200)];
    [name setFont: [name.font fontWithSize: 30]];
    [name setTextColor: [UIColor whiteColor]];
    [name.layer setCornerRadius: 10];
    [name.layer setBorderWidth: 5];
    [name.layer setBorderColor: [UIColor whiteColor].CGColor];
    [name setTextAlignment: NSTextAlignmentCenter];
    [self.view addSubview: name];
    
    self.startButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [self.startButton setTitle: @"Start" forState: UIControlStateNormal];
    [self.startButton setFrame: CGRectMake(0.0, self.view.frame.size.height - BUTTON_HEIGHT - self.tabBarController.tabBar.frame.size.height, BUTTON_WIDTH - 20, BUTTON_HEIGHT - 10)];
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
    
    
    
    self.stopButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [self.stopButton setTitle: @"Stop" forState: UIControlStateNormal];
    [self.stopButton setFrame: CGRectMake(self.view.frame.size.width - BUTTON_WIDTH,
                                          self.view.frame.size.height - BUTTON_HEIGHT - self.tabBarController.tabBar.frame.size.height,
                                          BUTTON_WIDTH - 20, BUTTON_HEIGHT - 10)];
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
    
    self.statusLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT)];
    [self.statusLabel setText: @"Inactive..."];
    [self.statusLabel setCenter: CGPointMake(self.view.center.x,
                                             (self.view.frame.size.height - (BUTTON_HEIGHT/2) - self.tabBarController.tabBar.frame.size.height))];
    [self.statusLabel setFont: [self.startButton.titleLabel.font fontWithSize: 20]];
    [self.statusLabel setTextColor: [UIColor whiteColor]];
    [self.view addSubview: self.statusLabel];
    
    self.speedLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, BUTTON_WIDTH, SPEED_HEIGHT)];
    [self.speedLabel setText: @"0"];
    [self.speedLabel setCenter: CGPointMake(self.view.center.x - 50, self.view.center.y - 10)];
    [self.speedLabel setFont: [self.speedLabel.font fontWithSize: 70]];
    [self.speedLabel setTextColor: [UIColor redColor]];
    [self.view addSubview: self.speedLabel];
    
    self.unitLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_WIDTH)];
    [self.unitLabel setText: [self.sharedData get_unit_type]];
    [self.unitLabel setCenter: CGPointMake(self.view.center.x + 50, self.view.center.y)];
    [self.unitLabel setFont: [self.speedLabel.font fontWithSize: 40]];
    [self.unitLabel setTextColor: [UIColor whiteColor]];
    [self.view addSubview: self.unitLabel];
    
    
    self.log = [[Log alloc] init];
    
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

-(void) runButtonPressed {
    [self.startButton setEnabled: NO];
    [self.stopButton setEnabled: YES];
    
    [self.startButton.layer setBorderColor: [UIColor grayColor].CGColor];
    [self.stopButton.layer setBorderColor: [UIColor blueColor].CGColor];
    
    [self.statusLabel setText: @"Running..."];
    [[[self statusLabel] layer] addAnimation:self.animation forKey:@"pulse"];
    
    
    [self.cllManager startUpdatingLocation];
    [self runFileSetup: self.RATE];
    
}

-(void) stopButtonPressed {
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
-(void) writeToFile:(NSFileHandle*)fileSys data:(NSString*)data {
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
    self.file = path;
    self.fileSys = [NSFileHandle fileHandleForWritingAtPath:self.file];
    
    // Create meta data
    NSString* toWrite = [NSString stringWithFormat:@"%@|%f|", name, rate];
    
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
        velocity *= self.sharedData.speed_conv;
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