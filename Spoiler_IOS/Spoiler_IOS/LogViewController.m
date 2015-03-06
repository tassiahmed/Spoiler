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

- (NSString*) convertForTable:(NSString*) string{
    NSString* str1 = [NSString stringWithString:string];
    NSString* str2 = [[str1 substringToIndex:10] stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSString* str3 = [[str1 substringFromIndex:11] stringByReplacingOccurrencesOfString:@"_" withString:@":"];
    return [[NSString stringWithFormat:@"%@_%@", str2, str3] substringToIndex:19];
}

NSArray *logData;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFileManager* manager = [NSFileManager defaultManager];
//    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsDir = [directories objectAtIndex:0];
    logData = [manager contentsOfDirectoryAtPath: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] error:NULL];
    //[self convertForTable:logData];
    NSLog(@"Log Size = %lu",(unsigned long)[logData count]);
    NSLog(@"Path for log viewer: %@", docsDir);
    
    
    // Initialize table data
    //logData = [NSArray arrayWithObjects:@"Test", @"Test", @"Test", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    return [self.logData count];
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
    
    cell.textLabel.text = [self convertForTable:[logData objectAtIndex:indexPath.row]];
    
    return cell;
}

//=========================================//
//======      Overriden Functions     =====//
//=========================================//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFileManager* manager = [NSFileManager defaultManager];
    self.logData = [manager contentsOfDirectoryAtPath: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] error:NULL];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
