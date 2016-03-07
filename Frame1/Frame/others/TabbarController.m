//
//  TabbarController.m
//  QMWeiboWithARC
//
//  Created by lanouhn on 15-2-2.
//  Copyright (c) 2015年All rights reserved.
//

#import "TabbarController.h"
#import "CustomTabBar.h"
#import "QYNavViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThiredViewController.h"
#import "FourViewController.h"
@interface TabbarController ()<CustomTabBarDelegate>

@property (nonatomic, strong) CustomTabBar *customTabBar;

@end

@implementation TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //重写的set方法,要放在setViewController之前
    
    [self setTabBar];
    [self setViewController];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//移除原来TabBar上面的所有控件
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }

}

/*
(lldb) po [view class]
CustomTabBar//不能移除

(lldb) po [view class]
UITabBarButton//系统没有这个类
(lldb) po [[view class] superclass]
UIControl

(lldb) po [view class]
UITabBarButton
(lldb) po [[view class] superclass]
UIControl
*/
- (void)setViewController
{
    FirstViewController *sc = [[FirstViewController alloc] init];
    [self setNavigationWithChildVC:sc image:@"首页0" selectedImage:@"首页1" title:@"首页"];
    SecondViewController *hc = [[SecondViewController alloc] init];
    [self setNavigationWithChildVC:hc image:@"日志0" selectedImage:@"日志1" title:@"日志"];
    ThiredViewController *fc = [[ThiredViewController alloc] init];
    [self setNavigationWithChildVC:fc image:@"审批0" selectedImage:@"审批1" title:@"审批"];
    FourViewController *mc = [[FourViewController alloc] init];
    [self setNavigationWithChildVC:mc image:@"我的0" selectedImage:@"我的1" title:@"我的"];

}

- (void)setNavigationWithChildVC: (UIViewController *)childVC image:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title
{
    childVC.title = title;
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateSelected];
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
//    //用系统的tabBar的话,加上这个条件不渲染(没有这个条件的话,会渲染成蓝色)
//    childVC.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    QYNavViewController *nv = [[QYNavViewController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nv];
    [self.customTabBar addButtonWithTabBarItem:childVC.tabBarItem];
}


- (void)setTabBar
{
    self.customTabBar = [[CustomTabBar alloc] init];
    self.customTabBar.frame = self.tabBar.bounds;
    _customTabBar.delegate = self;
    [self.tabBar addSubview:_customTabBar];
}

//切换控制器
- (void)tabBar:(CustomTabBar *)tabBar fromIndex:(CustomButton *)selectedButton toIndex:(NSInteger)to
{
    if (_customTabBar.flag) {
        _customTabBar.flag = NO;
    }
    self.selectedIndex = to;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
