//
//  wrappers.m
//  Spoiler_IOS
//
//  Created by Evan Thompson on 11/15/14.
//  Copyright (c) 2014 Spoiler. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation Wrapper : NSObject 

-(void) writeToFile:(NSFileHandle*)fileSys data:(NsString*)data;


//USE THIS FUNCTION TO WRITE TO FILE
-(void) writeToFile:(NSFileHandle*)fileSys data:(NSString*)data{
    if (fileSys != nil) {
        [fileSys seekToEndOfFile];
        NSMutableString* toWrite = [NSMutableString stringWithString:data];
        [toWrite appendString:@"|"];
        [fileSys writeData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    }
}

@end