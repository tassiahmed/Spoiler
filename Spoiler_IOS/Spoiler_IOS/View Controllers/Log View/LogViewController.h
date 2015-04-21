//
//  LogViewController.h
//  Spoiler_IOS
//
//  Created by Tausif Ahmed on 10/28/14.
//  Copyright (c) 2014 Spoiler. All rights reserved.
//

/*
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Log.h"
#import "SharedData.h"

@interface LogViewController : UITableViewController

@property NSArray *logData;

@property UIRefreshControl *refresh;

@property (strong, nonatomic) SharedData* sharedData;

@end
*/

//
//  LogTableViewController.h
//  Spoiler_Test
//
//  Created by Tausif Ahmed on 4/20/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"

@interface LogViewController : UINavigationController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *log_table;

@property NSArray *logData;

@property NSString *selected_file;

@property (strong, nonatomic) SharedData *sharedData;


@end