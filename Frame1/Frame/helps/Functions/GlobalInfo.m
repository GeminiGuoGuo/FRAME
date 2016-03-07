//
//  GlobalInfo.m
//  HealthyWalk
//
//  Created by 张博 on 15/2/6.
//  Copyright (c) 2015年 LC. All rights reserved.
//

#import "GlobalInfo.h"

@implementation GlobalInfo

static GlobalInfo *globalInfoInstance = nil;

+ (GlobalInfo *)sharedGlobalInfoInstance
{
    @synchronized(self)
    {
        if (!globalInfoInstance)
        {
            globalInfoInstance = [[self alloc] init];
        }
        return globalInfoInstance;
    }
}

@end
