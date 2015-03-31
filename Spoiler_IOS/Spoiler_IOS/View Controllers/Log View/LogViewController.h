//
//  LogViewController.h
//  Spoiler_IOS
//
//  Created by Tausif Ahmed on 10/28/14.
//  Copyright (c) 2014 Spoiler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Log.h"
#import "SharedData.h"

@interface LogViewController : UITableViewController

@property NSArray *logData;

@property (strong, nonatomic) SharedData* sharedData;

@end
