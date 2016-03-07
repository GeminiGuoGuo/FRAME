//
//  SexSheet.h
//  Fitness
//
//  Created by FarTeen on 14-7-23.
//  Copyright (c) 2014年 LYP. All rights reserved.
//

@class SexSheet;
typedef void(^SexBlock)(SexSheet *, int );
#import "BaseSheet.h"

@interface SexSheet : BaseSheet<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,copy) SexBlock myBlock;
-(id)initWithTitle:(NSString *)title delegate:(id)delegate sheetType:(sheetType)type;
@end

@protocol SexSheetDelegate <NSObject>

-(void)sexSheet:(SexSheet *)sheet selectIndex:(int)index;

@end