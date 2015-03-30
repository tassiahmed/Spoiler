//
//  SharedData.m
//  Spoiler_IOS
//
//  Created by Evan Thompson on 3/25/15.
//  Copyright (c) 2015 Spoiler. All rights reserved.
//

#import "SharedData.h"

#define MS_TO_MPH 2.23694
#define MS_TO_KPH 3.6

@implementation SharedData

-(SharedData*) init{
    self = [super init];
    
    //Future, read from file for settings  *****************
    
    //setup speed conversion
    self.speed_conv = MS_TO_MPH;
    
    //create a rate time
    self.rate = 1;  //should definitely get from a settings file
    
    return self;
}

-(NSString*) get_unit_type{
    if (self.speed_conv == MS_TO_MPH) {
        return @"mph";
    }else{
        return @"km/h";
    }
}

@end
