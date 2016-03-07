//
//  UIImage+WB.h
//  WeiboDemo
//
//  Created by yh on 14-12-19.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MMSJ)

+ (UIImage *)resizedImage:(NSString *)pic;

+ (UIImage *)resizedImage:(NSString *)pic leftScale:(CGFloat)leftScale topScale:(CGFloat)topScale;

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

@end
