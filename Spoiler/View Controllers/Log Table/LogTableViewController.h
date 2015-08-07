//
//  LogTableViewController.h
//  Spoiler
//
//  Created by Tausif Ahmed on 4/20/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"

@interface LogTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UINavigationBar *navbar;

//@property (strong, nonatomic) UITableView *log_table;

@property NSArray *logData;

@property NSString *selected_file;

@property (strong, nonatomic) SharedData *sharedData;


@end