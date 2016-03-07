//
//  NSString+MMSJ.m
//  MMTestDriveClient
//
//  Created by yh on 15/4/9.
//  Copyright (c) 2015年 MMSJ. All rights reserved.
//

#import "NSString+MMSJ.h"
#import "SystemManager.h"

@implementation NSString (MMSJ)

- (NSString *)firstLetterByEnglish
{
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, (__bridge CFMutableStringRef)[NSMutableString stringWithString:self]);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSMutableString *aNSString = (__bridge NSMutableString *)string;
    NSString *finalString = [aNSString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%c", 32] withString:@""];
    
    
    NSString *firstLetter = [[finalString substringToIndex:1]uppercaseString];
    if (!firstLetter||firstLetter.length<=0) {
        firstLetter = @"#";
    }else{
        unichar letter = [firstLetter characterAtIndex:0];
        if (letter<65||letter>90) {
            firstLetter = @"#";
        }
    }
    return firstLetter;
}

//md5加密
+ (NSString *)Md5Stringwithpassword:(NSString *)password userName:(NSString *)userName
{
    NSString *str = [NSString stringWithFormat:@"%@", [SystemManager md5:password]];
    NSString *userStr = [userName substringFromIndex:userName.length - 2];
    NSString *str1 = [NSString stringWithFormat:@"%@%@", [str uppercaseString], userStr];
    NSString *str2 = [SystemManager md5:str1];
    NSString *str3 = [str2 uppercaseString];
    return str3;
}

@end
