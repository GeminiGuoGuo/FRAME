//
//  SingleSheet.m
//  QianXiaZiMember
//
//  Created by FarTeen on 14-10-27.
//  Copyright (c) 2014年 lcworld. All rights reserved.
//

#import "SingleSheet.h"

@implementation SingleSheet

-(id)initWithTitle:(NSString *)title dataArray:(NSArray *)dataArray sheetType:(sheetType)type
{
    if (self = [super initWithTitle:title delegate:nil sheetType:type]) {
        self.dataArray = dataArray;
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
    
    self.firstIndex = (int)row;
    
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
        if (self.myBlock) {
            self.myBlock(self.dataArray,self.firstIndex);
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
