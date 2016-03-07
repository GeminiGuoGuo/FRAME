//
//  UIBarButtonItem+WB.h
//  WeiboDemo
//
//  Created by yh on 14-12-19.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MMSJ)

+ (UIBarButtonItem *)itemWithPic:(NSString *)pic Highlighted:(NSString *)highlightedPic Target:(id)target Action:(SEL)action Size:(CGSize)size;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title Target:(id)target Action:(SEL)action;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title Target:(id)target Action:(SEL)action Size:(CGSize)size;



@end
