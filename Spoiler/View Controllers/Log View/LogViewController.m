//
//  LogViewController.m
//  Spoiler
//
//  Created by Tausif Ahmed on 4/20/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController() @end

@implementation LogViewController

#pragma mark - View & Misc.

-(void) viewDidLoad {
    [super viewDidLoad];
	
    self.file_name = [[NSString alloc] init];
	
	self.file_data = [[NSMutableArray alloc] init];
	
	[self setUpFileLabel];
	
}

-(void) setUpFileLabel {
	self.file_label = [[UILabel alloc] initWithFrame:
					   CGRectMake(0, self.navigationController.navigationBar.frame.size.height,
								  self.view.frame.size.width,
								  self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height)];
	//[self.file_label setCenter:CGPointMake(self.v0iew.center.x, self.view.center.y)];
	[self.file_label setText: self.file_contents];
	[self.file_label setNumberOfLines:0];
	[self.file_label setLineBreakMode:NSLineBreakByWordWrapping];
	[self.file_label setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
	[self.file_label sizeToFit];
	[self.view addSubview: self.file_label];

}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) setUpLogView:(NSString*) file {
	self.file_name = file;
	
	if (!self.sharedData) {
		self.sharedData = [[SharedData alloc] init];
	}
	
	self.title = [self.sharedData parseFileName:self.file_name];
	
	self.file_contents = [NSString stringWithContentsOfFile:
						 [self.sharedData.get_log_dir_path stringByAppendingPathComponent:self.file_name]
						encoding:NSUTF8StringEncoding error:NULL];
	
	[self readData];
}

-(void) readData {
	NSMutableArray *temp_data = [[NSMutableArray alloc] init];
	temp_data = [[self.file_contents componentsSeparatedByString:@"|"] mutableCopy];
	assert([temp_data.firstObject isEqualToString:self.file_name]);
	[temp_data removeObjectAtIndex:0];
	self.speed_measurement = temp_data.firstObject;
	[temp_data removeObjectAtIndex:0];
	self.rate = [[NSDecimalNumber decimalNumberWithString:temp_data.firstObject]floatValue];
	[temp_data removeObjectAtIndex:0];
	for (NSString *item in temp_data) {
		[self.file_data addObject:[NSNumber numberWithInteger:[item integerValue]]];
	}
	self.file_contents = @"";
	for (int i = 0; i < temp_data.count; i++) {
//		NSLog([temp_data objectAtIndex:i]);
		self.file_contents = [self.file_contents
							  stringByAppendingString:[temp_data objectAtIndex:i]];
		self.file_contents = [self.file_contents stringByAppendingString:@" \n"];
		//NSLog(@"Hello");
	}
	
}

@end