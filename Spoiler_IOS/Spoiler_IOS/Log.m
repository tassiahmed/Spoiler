//
//  Log.m
//  Spoiler_IOS
//
//  Created by Evan Thompson on 9/22/14.
//  Copyright (c) 2014 Spoiler. All rights reserved.
//

#import "Log.h"
#import <Foundation/Foundation.h>

@implementation Log

//GETTERS

//Returns the log id
- (NSString*)getID{
    return self.id;
}
//returns the rate of the measurements in milleseconds
- (double) getRate{
    return self.rate;
}
//returns the speed at a given point.
//REQUIRES: index < logSize && index >= 0
//returns the value at the index provided the value is in bounds.  If it is out of bounds, returns -1
- (double) getSpeedAtPoint:(int)index{
    if (index >= 0 && index < self.speeds.count) {
        return [[self.speeds objectAtIndex:index] doubleValue];
    }
    return -1;
}
//returns the total number of measurements
- (int) getLogSize{
    return (int)self.speeds.count;
}

//SETTERS

//sets the ID of the function
- (void) setId:(NSString*) n {
    if (n != NULL) {
        self.id = n;
    }
    //ID using a date.  Possibility
    //self.id = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

//adds a speed of type double to the array of speeds
//returns:  true if the value was added, false otherwise
- (Boolean) addSpeed:(double)num{
    if (num >= 0) {
        [self.speeds addObject:[NSNumber numberWithDouble:num]];
        return true;
    }
    return false;
}

//sets the rate of the log
//Required:  rate > 0    if rate <= 0, rate = 1000
- (void) setRate:(double)rate{
    if (rate > 0) {
        self.rate = rate;
    }else{
        self.rate = 1000;  //default of 1 second
    }
}



@end
