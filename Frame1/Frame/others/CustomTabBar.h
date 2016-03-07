//
//  CustomTabBar.h
//  QMWeiboWithARC
//
//  Created by lanouhn on 15-2-2.
//  Copyright (c) 2015年 qiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomButton;
@class CustomTabBar;

@protocol CustomTabBarDelegate <NSObject>

- (void)tabBar:(CustomTabBar *)tabBar fromIndex:(CustomButton *)selectedButton toIndex:(NSInteger)to;
//- (void)plusClick:(BOOL)plusSeletFlag;
@end

@interface CustomTabBar : UIView

@property (nonatomic, assign) BOOL flag;
@property (nonatomic, strong) UITabBarItem *item;
@property (nonatomic, weak) id<CustomTabBarDelegate>delegate;

- (void)addButtonWithTabBarItem:(UITabBarItem *)item;

@end
