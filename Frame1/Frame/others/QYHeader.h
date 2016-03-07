//
//  QYHeader.h
//  QYHlper
//
//  Created by guoqingyang on 16/1/19.
//  Copyright © 2016年 guoqingyang. All rights reserved.
//

#ifndef QYHeader_h
#define QYHeader_h

//--------------手机系统---------------------------
#define IOS7  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define IOS8  [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0




//--------获取屏幕 宽度、高度-----------------------
//#define kWidth  ([UIScreen mainScreen].bounds.size.width)
//#define kHeight ([UIScreen mainScreen].bounds.size.height)


//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define GLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define GLog(...)
#endif


//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define mainColor        @"#ff645c"
#define bluebtnColor    @"#66ccee"
#define grayBtnColor   @"#cdcdcd"
#define oneFont    @"#202020"
#define twoFont   @"#929292"
#define threeFont  @"#bababa"
#define tabbarTextColor  @"#878787"
#define speGrayColor  @"#bababa"
#define speLightColor  @"#dcdcdc"
#define navColor  @"#F8F8F8"
#define bgColor  @"#f2f5f4"

//通过数值获取颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//字符串拼接
#define GETSTRING_WITH(x,y) [NSString stringWithFormat:@"%@%@",x,y]


// 判断字符串是否有值
#define StringHasValue(str)            (str && [str isKindOfClass:[NSString class]] && [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0)
// 判断字典是否有值
#define DictionaryHasValue(dic)   (dic && [dic isKindOfClass:[NSDictionary class]] && [dic count] > 0)
// 判断数组是否有值
#define ArrayHasValue(array)        (array && [array isKindOfClass:[NSArray class]] && [array count] > 0)
// 判断对象是否为null值
#define ObjectEqualNSNull(obj)   ([obj isEqual:[NSNull null]])

/**
 *  打印日志
 *
 *  @param ...
 *
 *  @return
 */

#ifdef DEBUG
#define Log(...) NSLog(@"%s---%d---%@",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__ ])
#else

#define Log(...)
#endif
#endif /* QYHeader_h */
