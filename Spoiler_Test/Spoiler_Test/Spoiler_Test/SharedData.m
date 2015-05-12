//
//  SharedData.m
//  Spoiler_Test
//
//  Created by Tausif Ahmed on 4/16/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import "SharedData.h"

#define MS_TO_MPH 2.23694
#define MS_TO_KPH 3.6
#define MS_TO_KNOTS 1.94384

#define SETTINGS_FILE_STR "Library/settings.ini"

#define DEFAULT_NUM_SYS 0
#define DEFAULT_RATE 5
#define DEFAULT_PARENT 0
#define DEFAULT_PHONE 00000000000

@implementation SharedData

//saves the save file
-(void) save{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    //needs to write all of the settings information to the settings file
    
    //potentially needs to be called after every change.  Would be slower but allows for a cleaner interface
    
    
    
    
    
}

//checks if the save file exists
-(BOOL) save_exists{
    NSFileManager* manager = [NSFileManager defaultManager];
    NSLog(@"Checking if save exists...");
    NSLog(@"save status: %d", [manager fileExistsAtPath:@SETTINGS_FILE_STR]);
    return [manager fileExistsAtPath:@SETTINGS_FILE_STR];
}

//creates the default save file
-(void) create_save_defaults{
    
    NSLog(@"Creating the save file");
    
    //NOT THE CORRECT FILE PATH --- NEEDS TO BE FIXED
    
    //NULL address for the file.  Need to fix that.  Once thats fixed this all should work well enough
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    //trying to set it up so that the settings file is inaccessible to the user in any way
    
    [manager createFileAtPath: @SETTINGS_FILE_STR contents: nil attributes: nil];
    
    NSFileHandle* output = [NSFileHandle fileHandleForWritingAtPath:@SETTINGS_FILE_STR];
    
    //NSLog(@"file path: %s\n", @SETTINGS_FILE_STR);
    
    //[output writeData:]];
    NSString* contents_to_write = [NSString stringWithFormat:@"%d\n%d\n%d\n00000000000", DEFAULT_NUM_SYS, DEFAULT_RATE, DEFAULT_PARENT];
    
    [output writeData: [contents_to_write dataUsingEncoding:NSASCIIStringEncoding]];
    
    [output closeFile];

}

-(SharedData*) init{
    self = [super init];
    
    if (![self save_exists]) {
        [self create_save_defaults];
    }
    
    //Future, read from file for settings  *****************
    
    //setup speed conversion
    self.speed_conv = MS_TO_MPH;
    
    //create a rate time
    self.rate = 1;  //should definitely get from a settings file
    
    return self;
}

//pass in val -> 0 (MPH) 1 (KPH) 2 (Knots)
-(void) set_speed_conv: (int) val{
    if (val == 0){
        self.speed_conv = MS_TO_MPH;
    }else if(val == 1){
        self.speed_conv = MS_TO_KPH;
    }else if(val == 2){
        self.speed_conv = MS_TO_KNOTS;
    }
    
    [self save];
}

-(NSString*) get_unit_type {
    if (self.speed_conv == MS_TO_MPH) {
        return @"mph";
    }else{
        return @"km/h";
    }
}

@end
