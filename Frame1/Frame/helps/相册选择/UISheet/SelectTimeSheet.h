//
//  SelectTimeSheet.h
//  WY
//
//  Created by LC_WORLD on 14-5-21.
//  Copyright (c) 2014年 LC_WORLD. All rights reserved.
//
@class SelectTimeSheet;
typedef void(^TimeBlcok)(SelectTimeSheet *);
#import "BaseSheet.h"

@interface SelectTimeSheet : BaseSheet

@property (nonatomic, copy)TimeBlcok myBlock;

@end


@protocol SelectTimeSheetDelegate <NSObject>

-(void)selectTimeSheet:(SelectTimeSheet *)sheet;

@end