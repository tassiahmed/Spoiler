//
//  LogViewController.m
//  Spoiler_Test
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
	
	self.file_data = [[UILabel alloc] initWithFrame:
					  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	[self.file_data setCenter:CGPointMake(self.view.center.x, self.view.center.y)];
	[self.view addSubview: self.file_data];

}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) setUpLogView:(NSString *)file {
	self.file_name = file;
	
	if (!self.sharedData) {
		self.sharedData = [[SharedData alloc] init];
	}
	
	self.title = [self.sharedData parseFileName:self.file_name];
	
	NSString* content = [NSString stringWithContentsOfFile:
						 [self.sharedData.get_log_dir_path stringByAppendingPathComponent:self.file_name]
						encoding:NSUTF8StringEncoding error:NULL];
	
	[self.file_data setText:content];

	
}

@end