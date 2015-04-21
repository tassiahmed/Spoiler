//
//  LogViewController.m
//  Spoiler_IOS
//
//  Created by Tausif Ahmed on 10/28/14.
//  Copyright (c) 2014 Spoiler. All rights reserved.
//
/*
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

#pragma mark - Table

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
        // Get set the log viewer filename to the name of the detail
        NSString* description = [path description];
        NSLog(@"%@", description);
        //[lgv setFileName:description];
        NSLog(@"Set the fileName");
        //NSLog(@"file name for path is %@", lgv.fileName);
    }
    
    NSLog(@"After the if");
    
}

#pragma mark - Overriden

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
*/

//
//  LogTableViewController.m
//  Spoiler_Test
//
//  Created by Tausif Ahmed on 4/20/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import "LogViewController.h"
#import "LogViewerController.h"

static NSString* const SEGUE_LOGVIEW = @"LogSegue";

@interface LogViewController() @end

@implementation LogViewController

#pragma mark - View & Misc.

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handle_data) name:@"reload_data" object:nil];
    
    /*
    UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    //do something like background color, title, etc you self
    
    [navbar setBackgroundColor: [UIColor whiteColor]];
    [navbar.topItem setTitle: @"Logs"];
    [self.view addSubview:navbar];
    
    UILabel *tab_name = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 100, 40)];
    [tab_name setText: @"Logs"];
    [tab_name setCenter: CGPointMake(self.view.center.x, self.view.center.y - 280)];
    [tab_name setFont: [tab_name.font fontWithSize: 30]];
    [self.view addSubview: tab_name];*/
    
    
    NSFileManager* manager = [NSFileManager defaultManager];
    self.logData = [manager contentsOfDirectoryAtPath: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] error:NULL];
    
    self.logData = [[self.logData reverseObjectEnumerator] allObjects];
    
    self.log_table = [[UITableView alloc] init];
    [self.log_table setFrame: CGRectMake(0, self.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - self.navigationBar.frame.size.height)];
    [self.log_table setDataSource: self];
    [self.log_table setDelegate: self];
    [self.log_table setBackgroundColor: [UIColor clearColor]];
    [self.log_table setAutoresizingMask: UIViewAutoresizingFlexibleHeight |
     UIViewAutoresizingFlexibleWidth];
    [self.log_table reloadData];
    [self.view addSubview: self.log_table];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)handle_data {
    NSFileManager* manager = [NSFileManager defaultManager];
    self.logData = [manager contentsOfDirectoryAtPath: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] error:NULL];
    
    self.logData = [[self.logData reverseObjectEnumerator] allObjects];
    
    [self.log_table reloadData];
}

#pragma mark - Table Data View

// Function to retrieve # of sections
- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    return 1;
}

// Function to retrieve # of rows in table
- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
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

- (void) tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath {
    /*UIAlertView *messageAlert = [[UIAlertView alloc]
     initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
     
     // Display Alert Message
     [messageAlert show];*/
    NSLog(@"%@", [self.logData objectAtIndex: indexPath.row]);
    self.selected_file = [self.logData objectAtIndex: indexPath.row];
    [self performSegueWithIdentifier: SEGUE_LOGVIEW sender: self];
    
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString: SEGUE_LOGVIEW]) {
        LogViewerController *log = [segue destinationViewController];
        [log setFileName: [self parseFileName:self.selected_file]];
    }
}



#pragma mark - Table View

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *log = @"LogItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:log];
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


@end
