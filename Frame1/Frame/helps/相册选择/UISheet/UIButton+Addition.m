//
//  UIButton+Addition.m
//  WY
//
//  Created by LC_WORLD on 14-4-24.
//  Copyright (c) 2014年 LC_WORLD. All rights reserved.
//

#import "UIButton+Addition.h"
#import <objc/runtime.h>
@implementation UIButton (Addition)


-(NSIndexPath *)indexPath
{
    return objc_getAssociatedObject(self, @"indexPath");
}
-(void)setIndexPath:(NSIndexPath *)indexPath
{
    objc_setAssociatedObject(self, @"indexPath", indexPath, OBJC_ASSOCIATION_RETAIN);
}

-(NSIndexPath *)cell
{
    return objc_getAssociatedObject(self, @"cell");
}
-(void)setCell:(UITableViewCell *)cell
{
    objc_setAssociatedObject(self, @"cell", cell, OBJC_ASSOCIATION_RETAIN);
}

-(void)setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}
-(void)setTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
}

-(void)setBackgroundImage:(UIImage *)image
{
    [self setBackgroundImage:image forState:UIControlStateNormal];
    [self setBackgroundImage:image forState:UIControlStateHighlighted];
}


@end
