//
//  SelectTimeSheet.m
//  WY
//
//  Created by LC_WORLD on 14-5-21.
//  Copyright (c) 2014年 LC_WORLD. All rights reserved.
//

#import "SelectTimeSheet.h"

@implementation SelectTimeSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithTitle:(NSString *)title delegate:(id)delegate sheetType:(sheetType)type
{
    if (self =[super initWithTitle:title delegate:delegate sheetType:type])
    {
        self.datePicker = [[UIDatePicker alloc]initWithFrame:self.bgView.bounds] ;
        self.datePicker.maximumDate = [NSDate new];
        [self.bgView addSubview:self.datePicker];
        self.datePicker.datePickerMode = UIDatePickerModeDate;
    }
    return self;
}

-(void)functionButtonClick:(UIButton *)btn
{
    [super functionButtonClick:btn];
    if (btn.tag == 2) {
        if ([self.myDelegate respondsToSelector:@selector(selectTimeSheet:)]) {
            [self.myDelegate selectTimeSheet:self];
        }else
        {
            if (self.myBlock) {
                self.myBlock(self);
            }
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
