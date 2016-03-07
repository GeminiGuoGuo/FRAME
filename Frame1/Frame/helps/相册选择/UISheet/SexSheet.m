//
//  SexSheet.m
//  Fitness
//
//  Created by FarTeen on 14-7-23.
//  Copyright (c) 2014年 LYP. All rights reserved.
//

#import "SexSheet.h"

@implementation SexSheet

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
    if (self = [super initWithTitle:title delegate:delegate sheetType:type]) {
        self.dataArray = @[@"男",@"女"];
        self.myPickerView = [[UIPickerView alloc]initWithFrame:self.bgView.bounds];
        [self.bgView addSubview:self.myPickerView];
        self.myPickerView.delegate = self;
        self.myPickerView.dataSource = self;
        self.firstIndex = 0;
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.firstIndex = row;
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumScaleFactor = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}



-(void)functionButtonClick:(UIButton *)btn
{
    [super functionButtonClick:btn];
    if (btn.tag == 2) {
        if ([self.myDelegate respondsToSelector:@selector(sexSheet:selectIndex:)]) {
            [self.myDelegate sexSheet:self selectIndex:self.firstIndex];
        }
        else
        {
            if (self.myBlock) {
                self.myBlock(self,self.firstIndex);
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
