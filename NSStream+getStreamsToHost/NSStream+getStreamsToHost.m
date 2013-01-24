//
//  NSStream+getStreamsToHost.m
//  StreamTest
//
//  Created by questbeat on 2012/10/16.
//  Copyright (c) 2012年 questbeat. All rights reserved.
//

#import "NSStream+getStreamsToHost.h"

@implementation NSStream (getStreamsToHost)

+ (void)getStreamsToHostNamed:(NSString *)hostName
                         port:(NSInteger)port
                  inputStream:(NSInputStream **)inputStreamPtr
                 outputStream:(NSOutputStream **)outputStreamPtr
{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    assert(hostName != nil);
    assert((port > 0) && (port < 65536));
    assert((inputStreamPtr != NULL) || (outputStreamPtr != NULL));
    
    readStream = NULL;
    writeStream = NULL;
    
    CFStreamCreatePairWithSocketToHost(NULL,
                                       (CFStringRef)hostName,
                                       port,
                                       ((inputStreamPtr != nil) ? &readStream : NULL),
                                       ((outputStreamPtr != nil) ? &writeStream : NULL)
                                       );
    
    if(inputStreamPtr != NULL) {
        *inputStreamPtr = [NSMakeCollectable(readStream) autorelease];
    }
    
    if(outputStreamPtr != NULL) {
        *outputStreamPtr = [NSMakeCollectable(writeStream) autorelease];
    }
}

@end
