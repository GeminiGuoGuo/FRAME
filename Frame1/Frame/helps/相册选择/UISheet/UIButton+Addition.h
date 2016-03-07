//
//  UIButton+Addition.h
//  WY
//
//  Created by LC_WORLD on 14-4-24.
//  Copyright (c) 2014年 LC_WORLD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Addition)


@property (nonatomic, retain)NSIndexPath * indexPath;
@property (nonatomic, retain)UITableViewCell * cell;


-(void)setTitle:(NSString *)title;
-(void)setTitleColor:(UIColor *)color;
-(void)setBackgroundImage:(UIImage *)image;

@end
