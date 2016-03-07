//
//  NSString+MMSJ.h
//  MMTestDriveClient
//
//  Created by yh on 15/4/9.
//  Copyright (c) 2015年 MMSJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MMSJ)
/**
 *  获取中文中的首字母并大写
 *
 *  @return 大写字母
 */
- (NSString*)firstLetterByEnglish;

+ (NSString *)Md5Stringwithpassword:(NSString *)password userName:(NSString *)userName;

@end
