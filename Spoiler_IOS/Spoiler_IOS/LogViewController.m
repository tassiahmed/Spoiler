//
//  LogViewController.m
//  Spoiler_IOS
//
//  Created by Tausif Ahmed on 10/28/14.
//  Copyright (c) 2014 Spoiler. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController ()

@end

@implementation LogViewController

NSArray *logData;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFileManager* manager = [NSFileManager defaultManager];
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [directories objectAtIndex:0];
    logData = [manager contentsOfDirectoryAtPath: docsDir error:NULL];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [logData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *log = @"LogItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:log];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:log];
    }
    
    cell.textLabel.text = [logData objectAtIndex:indexPath.row];
    return cell;
}

@end
