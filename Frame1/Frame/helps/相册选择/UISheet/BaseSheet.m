//
//  BaseSheet.m
//  WY
//
//  Created by LC_WORLD on 14-5-21.
//  Copyright (c) 2014年 LC_WORLD. All rights reserved.
//

#import "BaseSheet.h"
#import "UIButton+Addition.h"
@implementation BaseSheet

-(id)initWithTitle:(NSString *)title delegate:(id)delegate  sheetType:(sheetType)type
{
//    self  = [[[[NSBundle mainBundle] loadNibNamed:@"BaseSheet" owner:nil options:nil] firstObject] retain];
    
    if (self = [super init]) {
        self.myType = type;
        self.backgroundColor = [UIColor whiteColor];
        self.bounds = CGRectMake(0, 0, ScreenWidth, 260);
        
        
        //背景层，用来存放pickerView或者datePicker
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 216)];
        [self addSubview:_bgView];
        
        //功能视图
        UIView * toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        toolView.backgroundColor = [UIColor colorWithRed:0 green:150 / 255. blue:206 / 255. alpha:1.0];;
        [self addSubview:toolView];
        
        
        UIImageView * bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"boom"]];
        bgImageView.frame = CGRectMake(0, 0, ScreenWidth, 44);
        [toolView addSubview:bgImageView];
        
        
        
        //标题
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth - 40, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [toolView addSubview:_titleLabel];
        
        //右侧按钮
        UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(ScreenWidth - 56, 7, 46, 30);
        [toolView addSubview:rightButton];
        rightButton.tag = 2;
        [rightButton setTitle:@"确定"];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightButton addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //左侧按钮
        UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(10, 7, 46, 30);
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [toolView addSubview:leftButton];
        leftButton.tag = 1;
        [leftButton setTitle:@"取消"];
        [leftButton addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.myDelegate = delegate;
        self.titleLabel.text = title;
        //蒙板
        mbView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        mbView.backgroundColor = [UIColor blackColor];
        mbView.alpha = .1;
    }
    return self;
}


- (void)showInView:(UIView *) view
{
    [view addSubview:mbView];
    [view addSubview:self];
    
    self.superRect = view.frame;
    
    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
    [UIView animateWithDuration:kDuration animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
    

    
    return;
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DDLocateView"];
    
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:mbView];
    [view addSubview:self];
    
    
}


-(void)setSecondArray:(NSArray *)secondArray
{
    if (_secondArray != secondArray) {
        _secondArray = secondArray;
    }
}
-(void)setThridArray:(NSArray *)thridArray
{
    if (_thridArray != thridArray) {
        _thridArray = thridArray;
    }
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)functionButtonClick:(UIButton *)btn
{
//    int index = btn.tag;

    [UIView animateWithDuration:kDuration animations:^{
        self.frame = CGRectMake(0, self.superRect.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [mbView removeFromSuperview];
    }];
    
    /*
    if([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:index];
    }
     
    return;
    
    
    
    
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"TSLocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    [mbView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:index];
    }
     */
}
@end
