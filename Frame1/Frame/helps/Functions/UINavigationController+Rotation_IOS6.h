//
//  UINavigationController+Rotation_IOS6.h
//  SVOD
//
//  Created by liwei on 14-9-25.
//  Copyright (c) 2014年 STV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Rotation_IOS6)

-(BOOL)shouldAutorotate;
-(NSUInteger)supportedInterfaceOrientations;
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;

@end
