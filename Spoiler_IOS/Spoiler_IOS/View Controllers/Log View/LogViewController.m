//
//  LogViewController.m
//  Spoiler_IOS
//
//  Created by Tausif Ahmed on 10/28/14.
//  Copyright (c) 2014 Spoiler. All rights reserved.
//

#import "LogViewController.h"
#import "LogViewerController.h"

static NSString* const SEGUE_LOGVIEW = @"LogSegue";

@interface LogViewController () @end

@implementation LogViewController

- (NSString*) convertForTable:(NSString*) string{
    NSString* str1 = [NSString stringWithString:string];
    NSString* str2 = [[str1 substringToIndex:10] stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSString* str3 = [[str1 substringFromIndex:11] stringByReplacingOccurrencesOfString:@"_" withString:@":"];
    return [[NSString stringWithFormat:@"%@_%@", str2, str3] substringToIndex:19];
}

#pragma mark - Table Functions

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
    NSString *format = [self.logData objectAtIndex:indexPath.row];

    format  = [self parseFileName:format];
    
    // Set the cell's text to the log name
    cell.textLabel.text = format;
    
    return cell;
}

//Segue handling for cell
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Preparing for a segue with segue identifier: %@ Looking for: %@", [segue identifier], SEGUE_LOGVIEW);
    
    //if this is the correct segue
    if( [[segue identifier] isEqualToString: SEGUE_LOGVIEW]){
        NSLog(@"in if");
        LogViewerController* lgv = [segue destinationViewController];
        NSIndexPath* path = [self.tableView indexPathForSelectedRow];
        NSLog(@"Got path");
        //get set the log viewer filename to the name of the detail
        lgv.fileName = [path description];
        NSLog(@"Set the fileName");
        //[lgv.fileNameLabel setText:lgv.fileName];
        NSLog(@"file name for path is %@", lgv.fileName);
    }
    
    NSLog(@"After the if");
    
}

#pragma mark - Overriden Functions

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

/*- (void)viewDidLoad {
 [super viewDidLoad];
 
 NSFileManager* manager = [NSFileManager defaultManager];
 //    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 //    NSString *docsDir = [directories objectAtIndex:0];
 logData = [manager contentsOfDirectoryAtPath: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] error:NULL];
 //[self convertForTable:logData];
 NSLog(@"Log Size = %lu",(unsigned long)[logData count]);
 //NSLog(@"Path for log viewer: %@", docsDir);
 
 
 // Initialize table data
 //logData = [NSArray arrayWithObjects:@"Test", @"Test", @"Test", nil];
 
 // Uncomment the following line to preserve selection between presentations.
 // self.clearsSelectionOnViewWillAppear = NO;
 
 // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
 // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 }
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
