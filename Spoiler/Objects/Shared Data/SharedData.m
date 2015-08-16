//
//  SharedData.m
//  Spoiler
//
//  Created by Evan Thompson on 3/25/15.
//  Copyright (c) 2015 Spoiler. All rights reserved.
//

#import "SharedData.h"

#define MS_TO_MPH 2.23694
#define MS_TO_KPH 3.6

@implementation SharedData

-(SharedData*) init {
    self = [super init];
    
    // Future, read from file for settings  *****************
    
    // Setup speed conversion
    self.speed_conv = MS_TO_MPH;
    
    // Create a rate time
    self.rate = 1;  //should definitely get from a settings file
	
	// Get the current date
	self.current_date = [self get_current_date];

	// Get the current path for log storage
	self.log_path = [self get_log_dir_path];
    
    return self;
}

-(NSString*) get_current_date {
	// Initialize object to format date correctly
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"MM_dd_yyyy"];
	
	return [NSString stringWithString: [df stringFromDate: [NSDate date]]];
}

-(NSString*) get_log_dir_path {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"Spoiler_Logs"];
	
	[self create_dir_path:dataPath];
	
//	dataPath = [dataPath stringByAppendingPathComponent: self.current_date];
//	[self create_dir_path:dataPath];
	
	return dataPath;
}

-(void) create_dir_path:(NSString*) dataPath {
	if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
		[[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error: NULL];
	}
}



// Function to format the file name of the Log File
- (NSString *) parseFileName: (NSString*) name {
	// Copy of original input
	NSString *format = [NSString stringWithFormat:@"%@", name];
	
	// Format the string to show a proper log name
	format = [format stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
	format = [format substringWithRange:NSMakeRange(0, 19)];
	NSString *date = [format substringWithRange:NSMakeRange(0, 10)];
	NSString *time = [format substringWithRange:NSMakeRange(11, 8)];
	time = [time stringByReplacingOccurrencesOfString:@"/" withString:@"."];
	format = [date stringByAppendingFormat:@" %@", time];
	
	return format;
}

// Function to undo the format of the Log File Name
- (NSString *) unparseFileName: (NSString *) name {
	NSString * format = [NSString stringWithFormat:@"%@", name];
	
	format = [format stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
	format = [format stringByReplacingOccurrencesOfString:@" " withString:@"_"];
	format = [format stringByReplacingOccurrencesOfString:@"." withString:@"_"];
	format = [format stringByAppendingFormat:@".log"];
	
	return format;
}


-(NSString*) get_unit_type {
    if (self.speed_conv == MS_TO_MPH) {
        return @"mph";
    } else {
        return @"km/h";
    }
}

@end
