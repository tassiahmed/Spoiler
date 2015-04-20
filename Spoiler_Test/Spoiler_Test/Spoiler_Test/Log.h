//
//  Log.h
//  Spoiler_Test
//
//  Created by Tausif Ahmed on 4/16/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Log : NSObject

//Representation Invariant:  all doubles in speeds >= 0
//                           rate > 0


@property(nonatomic) NSString *id;

@property(nonatomic) double rate;

@property int numOfMeasures;

@property NSTimer *timer;

@property CLLocation *loc;

@property Boolean active;

@property NSString *fileName;

@property double currSpeed;

//MODIFIERS  *************

//starts the timer of the Logging
- (Boolean) start:(double)interval id:(NSString*)n;

//ends the timer of the logging
- (Boolean) stop;

//measures the speed of the vehicle
- (void) takeSpeedPriv;

//returns current speed
- (CLLocationSpeed) getSpeed;

//setup the log for measurement taking
//- (void) setup:(double)r id:(NSString*)n;

//stops the logging
//- (void) stop;

//GETTERS  *************

//Gets the ID of the log.  Date_TimeStarted_n (n being the number started at that time)
//- (NSString*) getID;

//Gets the speed of a current
//- (double) getSpeedAtPoint:(int)index;

//get the total number of measurement points
- (int) getLogSize;

//get the rate at which the measurement was taken in seconds
//- (double) getRate;


//SETTERS  *************

//Sets the Id of the string
//- (void) setId :(NSString*) n;
//add a speed to the array of speeds
//- (Boolean) addSpeed :(double) num;
//set the rate of measurement in milleseconds
//- (void) setRate :(double) rate;



@end

