//
//  NSObject+LogDealloc.m
//  JASidePanels
//
//  Created by Juniorchen on 14-3-18.
//
//

#import "NSObject+LogDealloc.h"
#import <objc/runtime.h>

static char __logDeallocAssociatedKey__;

@interface LogDealloc : NSObject
@property (strong) NSString* message;
@end

@implementation NSObject (LogDealloc)

- (void)logOnDealloc
{
    if( objc_getAssociatedObject( self, &__logDeallocAssociatedKey__ ) == nil ) {
        LogDealloc* log = [[LogDealloc alloc] init];
        log.message = NSStringFromClass( self.class );
        objc_setAssociatedObject( self, &__logDeallocAssociatedKey__, log, OBJC_ASSOCIATION_RETAIN );
    }
}

@end

@implementation LogDealloc

- (void)dealloc
{
    //前边这一步最好放在appdelegate中
    static const int ddLogLevel = LOG_LEVEL_VERBOSE;
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    DDLogError(@"this is a error info");
    DDLogWarn(@"this is a warn info");
    DDLogInfo(@"this is a info");
    DDLogDebug(@"log debug");
    DDLogVerbose(@"Meet George Jetson");
    
    DDLogInfo( @"dealloc: %@", self.message );
}

@end
