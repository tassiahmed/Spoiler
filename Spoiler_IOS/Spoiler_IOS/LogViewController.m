//
//  LogViewController.m
//  Spoiler_IOS
//
//  Created by Tausif Ahmed on 10/28/14.
//  Copyright (c) 2014 Spoiler. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController () @end

@implementation LogViewController


// Array of logs
NSArray *logData;

#pragma mark - Table view data source

//=========================================//
//======        Table Functions       =====//
//=========================================//

// Function to retrieve # of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Function to retrieve # of rows in table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [logData count];
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


// Function to set up and create table vieww to look at past log files
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    // Establish the row element will be a log item
    static NSString *log = @"LogItem";
    
    // Generate a cell in a table
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:log];
    
    // Intialize the cell if it is nil
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:log];
    }
    
    // Format the name of the table element
    NSString *format = [logData objectAtIndex:indexPath.row];
    format = [self parseFileName:format];
    
    // Set the cell's text to the log name
    cell.textLabel.text = format;
    
    return cell;
}

//=========================================//
//======      Overriden Functions     =====//
//=========================================//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFileManager* manager = [NSFileManager defaultManager];
    logData = [manager contentsOfDirectoryAtPath: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] error:NULL];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
