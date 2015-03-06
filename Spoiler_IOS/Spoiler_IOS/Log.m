//
//  Log.m
//  Spoiler_IOS
//
//  Created by Evan Thompson on 9/22/14.
//  Copyright (c) 2014 Spoiler. All rights reserved.
//

#import "Log.h"
#import <Foundation/Foundation.h>

@interface Log () @end

@implementation Log

//PUBLIC METHODS

//MODIFIERS

- (Boolean) start:(double)interval id:(NSString*)n {
    //check if the rate is valid
    if (interval < 0) {
        return false;
    }
    //set the active and number of measures
    self.active = true;
    self.numOfMeasures = 0;
    //start the timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(takeSpeedPriv) userInfo:nil repeats:YES];
    return true;
}

- (Boolean) stop {
    //if the timer is running
    if ([self.timer isValid]) {
        //stop the timer
        [self.timer invalidate];
        //set active to false
        self.active = false;
        self.currSpeed = -1;
        return true;
    }
    return false;
}

- (void) takeSpeedPriv {
    //get the current speed
    self.currSpeed = [self.loc speed];
    //increment the number of measurements
    self.numOfMeasures++;
}
//return the last measurement.  If there is no last measurement, return -1.
- (CLLocationSpeed) getSpeed {
    //if the class is active
    return [self.loc speed];
    //*******
    //if ([self active]){
        //return the current speed
    //    return [self currSpeed];
    //}
    //*******
    
    //return -1;
}

//GETTERS

//Returns the log id
/*- (NSString*) getID {
    return [self getIDPriv];
}*/

//Returns the rate of the measurements in milleseconds
/*- (double) getRate {
    return [self getRatePriv];
}*/

// Returns the total number of measurements
- (int) getLogSize {
    if ([self active]) {
        return [self numOfMeasures];
    }
    return -1;
}

//Returns the speed at a given point.
/*- (double) getSpeedAtPoint:(int) index {
    return [self getSpeedAtPointPriv:index];
}*/


//SETTERS

//Sets the ID of the function
/*- (void) setId:(NSString *) n {
    [self setIdPriv:n];
}*/

//Adds a speed of type double to the array of speeds
/*- (Boolean) addSpeed:(double) num {
    return [self addSpeedPriv:num];
}*/

//Sets the rate of the log
/*- (void) setRate:(double)rate {
    [self setRate:rate];
}*/


//PRIVATE METHODS

//GETTERS

//Returns the log id
/*- (NSString*) getIDPriv {
    return self.id;
}*/

//Returns the rate of the measurements in milleseconds
/*- (double) getRatePriv {
    return self.rate;
}*/

//Returns the speed at a given point.
//REQUIRES: index < logSize && index >= 0
//Returns the value at the index provided the value is in bounds.  If it is out of bounds, returns -1
/*- (double) getSpeedAtPointPriv:(int) index {
    if (index >= 0 && index < self.speeds.count) {
        return [[self.speeds objectAtIndex:index] doubleValue];
    }
    return -1;
}*/

//Returns the total number of measurements
/*- (int) getLogSizePriv {
    return (int) self.speeds.count;
}*/


//SETTERS

//Sets the ID of the function
/*- (void) setIdPriv:(NSString*) n {
    if (n != NULL) {
        self.id = n;
    }
    //ID using a date.  Possibility
    //self.id = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}*/

//Adds a speed of type double to the array of speeds
//Returns:  true if the value was added, false otherwise
/*- (Boolean) addSpeedPriv:(double) num {
    if (num >= 0) {
        [self.speeds addObject:[NSNumber numberWithDouble:num]];
        return true;
    }
    return false;
}*/

//Sets the rate of the log
//Required:  rate > 0    if rate <= 0, rate = 1000
/*- (void) setRatePriv:(double)rate {
    if (rate > 0) {
        self.rate = rate;
    } else {
        self.rate = 1000;  //default of 1 second
    }
}*/



@end
