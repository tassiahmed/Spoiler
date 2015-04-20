//
//  SharedData.h
//  Spoiler_Test
//
//  Created by Tausif Ahmed on 4/16/15.
//  Copyright (c) 2015 Tausif. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedData : NSObject

@property double speed_conv;
@property int rate;

-(SharedData*) init;

-(NSString*) get_unit_type;

@end