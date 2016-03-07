//
//  SingleSheet.h
//  QianXiaZiMember
//
//  Created by FarTeen on 14-10-27.
//  Copyright (c) 2014年 lcworld. All rights reserved.
//

@class SingleSheet;

typedef void(^SingleBlock)(NSArray * dataArray, int index);
#import "BaseSheet.h"

@interface SingleSheet : BaseSheet<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, copy) SingleBlock myBlock;
-(id)initWithTitle:(NSString *)title dataArray:(NSArray *)dataArray sheetType:(sheetType)type;
@end
