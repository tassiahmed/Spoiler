//
//  LogViewerController.h
//  Spoiler_IOS
//
//  Created by Evan Thompson on 3/9/15.
//  Copyright (c) 2015 Spoiler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogViewerController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;

@property (weak, nonatomic) NSString* fileName;

@property (strong, nonatomic) SharedData* sharedData;

@end
