//
//  LogViewController.h
//  Spoiler
//
//  Created by Tausif Ahmed on 4/20/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"

#define FRAME_WIDTH self.view.frame.size.width
#define FRAME_HEIGHT self.view.frame.size.height

#define NAVBAR_HEIGHT self.navigationController.navigationBar.frame.size.height


@interface LogViewController : UIViewController 

@property NSString *file_name;

@property NSMutableArray *file_data;

@property UILabel *file_label;

@property NSString *file_contents;

@property NSString *speed_measurement;

@property NSString *data;

@property float rate;

@property (strong, nonatomic) SharedData *sharedData;

-(void) setUpLogView: (NSString*) file;

@end