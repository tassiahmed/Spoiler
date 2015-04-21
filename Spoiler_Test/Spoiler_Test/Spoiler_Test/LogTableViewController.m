//
//  LogTableViewController.m
//  Spoiler_Test
//
//  Created by Tausif Ahmed on 4/20/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import "LogTableViewController.h"
#import "LogViewController.h"

static NSString* const SEGUE_LOGVIEW = @"LogSegue";

@interface LogTableViewController() @end

@implementation LogTableViewController

#pragma mark - View & Misc.

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handle_data) name:@"reload_data" object:nil];
	
	[self.navigationController.navigationBar.topItem setTitle: @"Logs"];
	
    NSFileManager* manager = [NSFileManager defaultManager];
    self.logData = [manager contentsOfDirectoryAtPath: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] error:NULL];
    
    self.logData = [[self.logData reverseObjectEnumerator] allObjects];
    
    self.log_table = [[UITableView alloc] init];
    [self.log_table setFrame: CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height)];
    [self.log_table setDataSource: self];
    [self.log_table setDelegate: self];
    [self.log_table setBackgroundColor: [UIColor colorWithWhite: 235/255.0 alpha:1]];
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
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString: SEGUE_LOGVIEW]) {
        LogViewController *log = [segue destinationViewController];
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