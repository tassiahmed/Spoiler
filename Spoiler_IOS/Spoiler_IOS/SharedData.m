//
//  SharedData.m
//  Spoiler_IOS
//
//  Created by Evan Thompson on 3/9/15.
//  Copyright (c) 2015 Spoiler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SharedData.h"

@implementation SharedData : NSObject 


-(SharedData*) init{
    self = [super init];
    
    self.rate = 1.0;
    
    return self;
}

-(void) setFileNameLog:(NSString *)str {
    self.logFileName = [NSString stringWithString:str];
}

-(NSString *) getFileNameLog {
    
    return [NSString stringWithString:self.logFileName];
}


@end
