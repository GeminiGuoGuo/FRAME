//
//  CustomTabBar.m
//  QMWeiboWithARC
//
//  Created by lanouhn on 15-2-2.
//  Copyright (c) 2015年 qiaoming. All rights reserved.
//

#import "CustomTabBar.h"
#import "CustomButton.h"

@interface CustomTabBar ()

@property (nonatomic, strong) CustomButton *selectedButton;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIButton *plusButton;

@end
@implementation CustomTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //添加自定义的加号按钮
//        self.plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_plusButton setImage:[UIImage imageNamed:@"chatBar_more"] forState:UIControlStateNormal];
//        [_plusButton setBackgroundImage:[UIImage imageNamed:@"chatBar_more"] forState:UIControlStateNormal];
//        [_plusButton setImage:[UIImage imageNamed:@"chatBar_more"] forState:UIControlStateHighlighted];
//        [_plusButton setBackgroundImage:[UIImage imageNamed:@"chatBar_more"] forState:UIControlStateHighlighted];
//        self.plusButton.frame = CGRectMake(0, 0, self.plusButton.currentBackgroundImage.size.width, self.plusButton.currentBackgroundImage.size.height);
//        [self addSubview:_plusButton];
//        _plusButton.tag = 103;
//        [_plusButton addTarget:self action:@selector(clickPlus:) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = Tabbar_COLOR;
        self.buttonArray = [NSMutableArray array];
    }
    return self;
    
}

//- (void)clickPlus:(UIButton *)button
//{
//    _flag = !_flag;
//    [_delegate plusClick:_flag];
//}

- (void)addButtonWithTabBarItem:(UITabBarItem *)item
{
    CustomButton *button = [[CustomButton alloc] init];
    button.item = item;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
   // NSLog(@"%d", self.subviews.count);
    [self.buttonArray addObject:button];
    //默认第一个按钮是被点击的
    if (self.buttonArray.count == 1) {
        [self clickButton:button];
    }
}

- (void)clickButton:(CustomButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBar:fromIndex:toIndex:)]) {
        [self.delegate tabBar:self fromIndex:self.selectedButton toIndex:button.tag - 100];
    }
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    self.selectedButton.selected = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat W = [UIScreen mainScreen].bounds.size.width / (self.buttonArray.count );
    //注意点:自定义的tabBar要继承于UIView, 不能继承与UITabBar, 因为UITabBar内部自带的有UIImageView也算它的subView, 会影响self.subviews.count
    CGFloat H = self.bounds.size.height;
    for (int i = 0; i < self.buttonArray.count; i++) {
        CGFloat X = i * W;
//        if (i == 2 || i == 3) {
//            X = X + W;
//        }
        CustomButton *button = self.buttonArray[i];
        button.frame = CGRectMake(X, 0, W, H);
        button.tag = 100 + i;
    }

    //中间按钮的尺寸
  //  self.plusButton.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, H * 0.5);
}

@end
