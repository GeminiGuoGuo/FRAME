//
//  QMTextView.m
//  MMTestDriveClient
//
//  Created by LCWORLD_MAC on 15/4/8.
//  Copyright (c) 2015年 MMSJ. All rights reserved.
//

#import "QMTextView.h"

@interface QMTextView()
{
    BOOL _shouldDrawPlaceHloder;
}
@end
@implementation QMTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self drawPlaceholder];
    return;
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    if (![placeHolder isEqual:_placeHolder]) {
        _placeHolder = placeHolder;
        [self drawPlaceholder];
    }
    return;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self configureBase];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_shouldDrawPlaceHloder) {
        [_placeHolderTextColor set];
        [_placeHolder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f,
                                            self.frame.size.height - 16.0f) withFont:self.font];
    }
    return;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configureBase];
        self.directionalLockEnabled = YES;
    }
    return self;
}

- (void)configureBase
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                            selector:@selector(textChanged:)
                                name:UITextViewTextDidChangeNotification
                              object:self];
    
    self.placeHolderTextColor = [UIColor colorWithWhite:0.702f alpha:1.0f];
    _shouldDrawPlaceHloder = NO;
    return;
}

- (void)drawPlaceholder
{
    BOOL prev = _shouldDrawPlaceHloder;
    _shouldDrawPlaceHloder = self.placeHolder && self.placeHolderTextColor && self.text.length == 0;
    
    if (prev != _shouldDrawPlaceHloder) {
        [self setNeedsDisplay];
    }
    return;
}

- (void)textChanged:(NSNotification *)notification {
    [self drawPlaceholder];
    return;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    return;
}

@end
