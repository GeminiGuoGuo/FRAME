//
//  CustomButton.m
//  QMWeiboWithARC
//
//  Created by lanouhn on 15-2-2.
//  Copyright (c) 2015年 qiaoming. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //image居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = Tabbar_Font;
    }
    return self;
}

//image显示在上边
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(contentRect), (contentRect.size.height) * Tabbar_Image_Scale);
    return rect;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

//文字显示下面
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectMake(0, (contentRect.size.height) * Tabbar_Image_Scale, CGRectGetWidth(contentRect), (contentRect.size.height) * (1 - Tabbar_Image_Scale));
    return rect;
}

- (void)setItem:(UITabBarItem *)item
{
    if (_item != item) {
        _item = item;
    }
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
    //    [self setBackgroundImage:item.image forState:UIControlStateNormal];
    //    [self setBackgroundImage:item.selectedImage forState:UIControlStateSelected];
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setTitleColor:Tabbar_Text_COLOR forState:UIControlStateNormal];
    [self setTitleColor:Tabbar_TextSel_COLOR forState:UIControlStateSelected];

}



@end
