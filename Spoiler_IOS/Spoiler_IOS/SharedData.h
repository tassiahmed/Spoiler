//
//  SharedData.h
//  Spoiler_IOS
//
//  Created by Evan Thompson on 3/9/15.
//  Copyright (c) 2015 Spoiler. All rights reserved.
//

#ifndef Spoiler_IOS_SharedData_h
#define Spoiler_IOS_SharedData_h

@interface SharedData : NSObject

@property NSString* logFileName;

@property double rate;

//functions

-(SharedData*) init;

-(NSString *) getFileNameLog;

-(void) setFileNameLog: (NSString *) str;

@end

#endif
