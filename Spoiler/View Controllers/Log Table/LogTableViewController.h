//
//  LogTableViewController.h
//  Spoiler
//
//  Created by Tausif Ahmed on 4/20/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"

#define TABLE_FRAME_WIDTH self.view.frame.size.width
#define TABLE_FRAME_HEIGHT self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height

#define NAVBAR_HEIGHT self.navigationController.navigationBar.frame.size.height


@interface LogTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UINavigationBar *navbar;

@property NSArray *logData;

@property NSString *selected_file;

@property (strong, nonatomic) SharedData *sharedData;


@end