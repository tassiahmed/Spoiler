//
//  LogViewController.m
//  Spoiler_Test
//
//  Created by Tausif Ahmed on 4/20/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController() @end

@implementation LogViewController

#pragma mark - View & Misc.

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.file_name = [[NSString alloc] init];
    self.file_name_label = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 100, 40)];
    
    [self.file_name_label setCenter: CGPointMake(self.view.center.x, self.view.center.y - 280)];
    [self.view addSubview: self.file_name_label];
    
    //[self.navigationController.navigationBar.topItem setTitle: self.file_name];

}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) setFileName: (NSString* ) name {
    self.file_name = name;
    [self.file_name_label setText:self.file_name];
}

@end