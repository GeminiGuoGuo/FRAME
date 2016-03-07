//
//  LSDataModel.h
//  LiveShow3.0
//
//  Created by zhangxinming on 11/10/14.
//  Copyright (c) 2014 novelsupertv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSDiscoverInfo : NSObject

@property (nonatomic,copy) NSString *catalogCode;
@property (nonatomic,copy) NSArray *poster;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *dataUrl;
@property (nonatomic,assign) int listType;
@property (nonatomic,assign) int catalogType;
@property (nonatomic,copy) NSArray *subCatalog;

@end



