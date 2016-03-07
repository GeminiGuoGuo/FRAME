//
//  UIImage+WB.m
//  WeiboDemo
//
//  Created by yh on 14-12-19.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "UIImage+MMSJ.h"

@implementation UIImage (MMSJ)



+ (UIImage *)resizedImage:(NSString *)pic
{
    UIImage *img = [UIImage imageNamed:pic];
    
    return [img stretchableImageWithLeftCapWidth:img.size.width*0.5 topCapHeight:img.size.height * 0.5];
}

+ (UIImage *)resizedImage:(NSString *)pic leftScale:(CGFloat)leftScale topScale:(CGFloat)topScale
{
    UIImage *img = [UIImage imageNamed:pic];
    
    return [img stretchableImageWithLeftCapWidth:img.size.width*leftScale topCapHeight:img.size.height * topScale];
}

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

@end
