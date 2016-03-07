//
//  UINavigationController+GONavigationController.m
//  LiveShow3.0
//
//  Created by liwei on 14-12-13.
//  Copyright (c) 2014年 novelsupertv. All rights reserved.
//

#import "UINavigationController+GONavigationController.h"

@implementation UINavigationController (GONavigationController)

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)lock
{
    if (!lock || self.topViewController == lock)
    {
        [self pushViewController:viewController animated:animated];
    }
}

- (id)navigationlock
{
    return self.topViewController;
}

- (NSArray *)popViewControllerAnimated:(BOOL)animated navigationLock:(id)lock
{
    if (!lock || self.topViewController == lock)
    {
        [self popViewControllerAnimated:animated];
    }
    return @[];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated navigationLock:(id)lock
{
    if (!lock || self.topViewController == lock)
    {
        [self popToRootViewControllerAnimated:animated];
    }
    return @[];
}

@end
