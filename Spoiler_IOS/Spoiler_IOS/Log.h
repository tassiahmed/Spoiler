//
//  Log.h
//  Spoiler_IOS
//
//  Created by Evan Thompson on 9/22/14.
//  Copyright (c) 2014 Spoiler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Log : NSObject

//Representation Invariant:  all doubles in speeds >= 0
//                           rate > 0


@property(nonatomic) NSString *id;

@property(nonatomic) NSDate *date;

@property(nonatomic) double rate;

@property NSMutableArray *speeds;


//GETTERS  *************

//Gets the ID of the log.  Date_TimeStarted_n (n being the number started at that time)
- (NSString*) getID;
//Gets the speed of a current
- (double) getSpeedAtPoint:(int)index;
//get the total number of measurement points
- (int) getLogSize;
//get the rate at which the measurement was taken in seconds
- (double) getRate;


//SETTERS  *************

//Sets the Id of the string
- (void) setId :(NSString*) n;
//add a speed to the array of speeds
- (Boolean) addSpeed :(double) num;
//set the rate of measurement in milleseconds
- (void) setRate :(double) rate;


@end
