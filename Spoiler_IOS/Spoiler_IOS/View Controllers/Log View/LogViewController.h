//
//  LogViewController.h
//  Spoiler_Test
//
//  Created by Tausif Ahmed on 4/20/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"


@interface LogViewController : UIViewController /*<UITableViewDataSource, UITableViewDelegate>*/

@property NSString *file_name;

@property UILabel *file_data;

@property (strong, nonatomic) SharedData *sharedData;

-(void) setUpLogView: (NSString*) file;

@end