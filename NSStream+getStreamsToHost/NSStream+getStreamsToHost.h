//
//  NSStream+getStreamsToHost.h
//  StreamTest
//
//  Created by questbeat on 2012/10/16.
//  Copyright (c) 2012年 questbeat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStream (getStreamsToHost)

+ (void)getStreamsToHostNamed:(NSString *)hostName
                         port:(NSInteger)port
                  inputStream:(NSInputStream **)inputStreamPtr
                 outputStream:(NSOutputStream **)outputStreamPtr;
@end
