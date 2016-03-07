//
//  UIBarButtonItem+WB.m
//  WeiboDemo
//
//  Created by yh on 14-12-19.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "UIBarButtonItem+MMSJ.h"
#import "UIImage+MMSJ.h"

@implementation UIBarButtonItem (MMSJ)

+ (UIBarButtonItem *)itemWithPic:(NSString *)pic Highlighted:(NSString *)highlightedPic Target:(id)target Action:(SEL)action Size:(CGSize)size
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *normal = [UIImage imageNamed:pic];
    [btn setImage:normal forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedPic] forState:UIControlStateHighlighted];
    
//    btn.bounds  = CGRectMake(0, 0,normal.size.width, normal.size.height);
//    
//    if (normal.size.width > 40 && normal.size.height > 40) {
//        btn.bounds = CGRectMake(0, 0, 35, 35);
//    }
    btn.bounds = CGRectMake(0, 0, size.width, size.height);
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+ (UIBarButtonItem *)itemWithTitle:(NSString *)title Target:(id)target Action:(SEL)action
{
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    titleBtn.bounds = (CGRect){0,0,50,40};
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   // [titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [titleBtn setTitle:title forState:UIControlStateNormal];
    
    [titleBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:titleBtn];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title Target:(id)target Action:(SEL)action Size:(CGSize)size
{
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    titleBtn.bounds = (CGRect){0,0,size};
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [titleBtn setTitle:title forState:UIControlStateNormal];
    
    [titleBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:titleBtn];
    
}


@end
