//
//  UINavigationController+GONavigationController.h
//  LiveShow3.0
//
//  Created by liwei on 14-12-13.
//  Copyright (c) 2014年 novelsupertv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (GONavigationController)

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)lock;
- (id)navigationlock;
- (NSArray *)popViewControllerAnimated:(BOOL)animated navigationLock:(id)lock;
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated navigationLock:(id)lock;

@end
