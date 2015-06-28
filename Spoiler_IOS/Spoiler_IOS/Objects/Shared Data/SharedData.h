//
//  SharedData.h
//  Spoiler_IOS
//
//  Created by Evan Thompson on 3/25/15.
//  Copyright (c) 2015 Spoiler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedData : NSObject

@property double speed_conv;
@property int rate;
@property NSString* current_date;
@property NSString* log_path;

-(SharedData*) init;

-(NSString*) get_current_date;

-(NSString*) get_log_dir_path;

-(void) create_dir_path: (NSString*) dataPath;

- (NSString *) parseFileName: (NSString*) name;

- (NSString *) unparseFileName: (NSString*) name;



-(NSString*) get_unit_type;

@end
