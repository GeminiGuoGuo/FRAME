//
//  SystemManager.h
//  WY
//
//  Created by LC_WORLD on 14-4-18.
//  Copyright (c) 2014年 LC_WORLD. All rights reserved.
//






#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define LOG_USER_NAME @"logUserName"
#define LOG_PAS_WORD @"logpassword"
#define HTTP_BASE_URL @"http://123.56.110.143/honghclient/"

#define HUD_ERROR (HUDNormal(@"网络异常"))


@interface SystemManager : NSObject

/**
 *  地址数组,每次进入程序的时候读取本地地址
 */
@property(nonatomic,retain)NSArray * regionArray;



//用户存储本地plist文件信息到内存中
@property(nonatomic,retain)NSMutableDictionary * systemControlDataDic;



+( SystemManager *)shareSystemManager;


+ (NSString *) md5:(NSString *) input;


/**
 *  获取post数据，传入Info字典
 *
 *  @param dict
 *
 *  @return 
 */
+ (NSMutableDictionary *)PostData:(NSMutableDictionary *)dict;
/**
 *  字典去空
 *
 *  @param dict 数据字典
 *
 *  @return 处理后字典
 */
+ (NSMutableDictionary *)RemoveNull:(NSMutableDictionary *)dict;

/**
 *  获取字符串201X-MM-dd 传入date
 *
 *  @param date date
 *
 *  @return 字符串
 */
+(NSString *)getDateStrFromDate:(NSDate *)date;
/**
 *  获取字符串date 传入201X-MM-dd HH:mm:DD
 *
 *  @param date date
 *
 *  @return 字符串
 */
+(NSDate *)getDateFromDateStr:(NSString *)dateStr;
+(NSDate *)getDateFromDateStr1:(NSString *)dateStr;


/**
 *  获取字符串201X-MM-dd HH:mm:DD
 *
 *  @param
 *
 *  @return 字符串
 */
+(NSString *)getNowStr;

+(CGSize)getSizeWithWidth:(CGFloat)width content:(NSString *)str font:(int)font;

//根据属性的名字取得属性的值
-(id)getPropertyWithKey:(NSString *)propertyName;
//设置属性的值
-(BOOL)setPropertyWithKey:(NSString *)propertyName value:(id)propertyValue;

/*手机震动*/
-(void)vibrate;
/*图片压缩*/
+(NSData *)compactImage:(UIImage *)image;

/**
 *  自定义某种色值image
 *
 *  @param ImageRect image尺寸
 *  @param color     色值
 *
 *  @return image对象
 */
+(UIImage*) imageWithRect:(CGRect)ImageRect  Color:(UIColor*)color;

/**
 *  手机号码格式是否正确
 *
 *  @param mobile 手机号码
 *
 *  @return 是否正确
 */
-(BOOL)isValidateMobile:(NSString *)mobile;
/**
 *  验证码格式是否正确
 *
 *  @param mobile 验证码
 *
 *  @return 是否正确
 */
-(BOOL)isValidateMessageCode:(NSString *)messageCode;
/**
 *  密码格式是否正确
 *
 *  @param password 密码
 *
 *  @return 是否正确
 */
-(BOOL)isValidatePassWord:(NSString *)password;
/**
 *  邮箱格式是否正确
 *
 *  @param email 邮箱
 *
 *  @return 是否正确
 */

// 匹配6-20个由字母和数字组成的字符串的正则表达式(用户名)
-(BOOL)isValidateUserName:(NSString *)password;


-(BOOL)isValidateEmail:(NSString *)email;
/**
 *  身份证号码格式是否正确
 *
 *  @param identityCard 身份证号码
 *
 *  @return 是否正确
 */
- (BOOL) isValidateIdentityCard: (NSString *)identityCard;
-(BOOL)isValidateEmailOrPhone:(NSString *)string;
- (BOOL) isValidateMoney: (NSString *)Money;
@end
