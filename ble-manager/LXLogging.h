//
// Created by Alexis Kinsella on 17/01/2014.
// Copyright (c) 2014 Xebia IT Architects. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LXLogger.h"

#define kLogLevelVerbose @"VERBOSE"
#define kLogLevelDebug @"DEBUG"
#define kLogLevelInfo @"INFO"
#define kLogLevelWarn @"WARN"
#define kLogLevelError @"ERROR"

#ifdef DEBUG
    #define LXLog(fmt, logLevel, ...) \
            [LXLogger logWithSourceFile:__FILE__ level:logLevel lineNumber:__LINE__ format:fmt, ##__VA_ARGS__]
#else
    #defineLXLog
#endif

#ifdef DEBUG
    #define LXLogVerbose(fmt, ...) LXLog(fmt, kLogLevelVerbose, ##__VA_ARGS__)
    #define LXLogDebug(fmt, ...)   LXLog(fmt, kLogLevelDebug, ##__VA_ARGS__)
#else
    #defineLXLogVerbose
    #defineLXLogDebug
#endif

#define LXLogInfo(fmt, ...)    LXLog(fmt, kLogLevelInfo, ##__VA_ARGS__)
#define LXLogWarn(fmt, ...)    LXLog(fmt, kLogLevelWarn, ##__VA_ARGS__)
#define LXLogError(fmt, ...)   LXLog(fmt, kLogLevelError, ##__VA_ARGS__)




#ifdef DEBUG
    #define XBLog(fmt, logLevel, ...) LXLog(fmt, logLevel, ##__VA_ARGS__)
#else
    #define XBLog(...)
#endif

#ifdef DEBUG
    #define XBLogVerbose(fmt, ...) XBLog(fmt, kLogLevelVerbose, ##__VA_ARGS__)
    #define XBLogDebug(fmt, ...)   XBLog(fmt, kLogLevelDebug, ##__VA_ARGS__)
#else
    #define XBLogVerbose(fmt, ...)
    #define XBLogDebug(...)
#endif

#define XBLogInfo(fmt, ...)    XBLog(fmt, kLogLevelInfo, ##__VA_ARGS__)
#define XBLogWarn(fmt, ...)    XBLog(fmt, kLogLevelWarn, ##__VA_ARGS__)
#define XBLogError(fmt, ...)   XBLog(fmt, kLogLevelError, ##__VA_ARGS__)



#define NSLog(...) LXLog(fmt, kLogLevelInfo, ##__VA_ARGS__)

