//
//  BaseSheet.h
//  WY
//
//  Created by LC_WORLD on 14-5-21.
//  Copyright (c) 2014年 LC_WORLD. All rights reserved.
//

#define kDuration 0.25
#import <UIKit/UIKit.h>
typedef enum
{
    sheetType_date = 1,
    sheetType_picker = 2,
} sheetType;

@interface BaseSheet : UIActionSheet
{
    UIView  * mbView;
}
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, assign) CGRect superRect;

@property (nonatomic, assign) id myDelegate;
/**
 判断sheet的样式，显示时间还是其他
 */
@property (nonatomic, assign) sheetType myType;
//时间picker使用的参数
@property (nonatomic, retain) UIDatePicker * datePicker;

//picker使用的参数
@property (nonatomic, strong) UIPickerView * myPickerView;
@property (nonatomic, assign) BOOL isStartTime;

/**
 *  关键字 使用者自定义  用来匹配回调
 */
@property (nonatomic, strong) NSString * keyStr;

/**
 *  三块的选中行数   最多支持三层  多余三块 需要子类中自定义
 */
@property (nonatomic, assign) int firstIndex;
@property (nonatomic, assign) int secondIndex;
@property (nonatomic, assign) int thirdIndex;

/**
 *  三层数据源   dataArray 为最外层的
 */
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, strong) NSArray * secondArray;
@property (nonatomic, strong) NSArray * thridArray;


-(void)functionButtonClick:(UIButton *)btn;
-(id)initWithTitle:(NSString *)title delegate:(id)delegate sheetType:(sheetType)type;
- (void)showInView:(UIView *) view;

-(void)setSecondArray:(NSArray *)secondArray;
-(void)setThridArray:(NSArray *)thridArray;
@end


