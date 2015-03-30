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

-(SharedData*) init;

-(NSString*) get_unit_type;

@end
