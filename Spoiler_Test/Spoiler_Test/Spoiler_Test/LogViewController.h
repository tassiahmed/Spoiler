//
//  LogViewController.h
//  Spoiler_Test
//
//  Created by Tausif Ahmed on 4/20/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogViewController : UIViewController /*<UITableViewDataSource, UITableViewDelegate>*/

@property (strong, nonatomic) UILabel *file_name_label;

@property NSString *file_name;

- (void) setFileName: (NSString* ) name;


@end