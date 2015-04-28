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
    
    //NSLog(self.navigationController.navigationBar.topItem.title);
    //[self.navigationController.navigationBar.topItem setTitle: self.file_name];

}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) setFileName: (NSString* ) name {
    self.file_name = name;
}

@end