//
//  SystemManager.m
//  WY
//
//  Created by LC_WORLD on 14-4-18.
//  Copyright (c) 2014年 LC_WORLD. All rights reserved.
//

#import "SystemManager.h"
#import "MBProgressHUD.h"
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "MMSJCommon.h"
@implementation SystemManager
static SystemManager * manager = Nil;

+(SystemManager *)shareSystemManager
{
    @synchronized(self)
    {
        if (!manager) {
            manager = [[SystemManager alloc]init];
            
        }
        return manager;
    }
}


+(id)alloc
{
    @synchronized(self)
    {
        if (!manager) {
            manager =[super alloc];
        }
        return manager;
    }
}

-(id)init
{
    if (self = [super init]) {
        self.systemControlDataDic = [NSMutableDictionary dictionaryWithCapacity:0];
        [self readSystemControlDataFromFile];
    }
    return self;
}



+ (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

+(NSDictionary *)getauth
{
    
    NSDictionary *dic = @{@"app_key": @"123456",
                          @"imei": @"imei",
                          @"os": @"Iphone os",
                          @"os_version": @"7.0",
                          @"app_version": @"1.0",
                          @"source_id": @"1.0",
                          @"ver": @"1.0.0",
                          @"ver": @"0.9",
                          @"mobile":@"18703479583",
                          @"wuid": @"2",
                          @"crc": @"Cbaq4fxvb",
                          @"time_stamp": @"20141016"};
    return dic;
}





/**
 *  获取字符串201X-MM-dd 传入date
 *
 *  @param date date
 *
 *  @return 字符串
 */
+(NSString *)getDateStrFromDate:(NSDate *)date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * str = [formatter stringFromDate:date];
    return str;
}

/**
 *  获取字符串date 传入201X-MM-dd HH:mm:DD
 *
 *  @param date date
 *
 *  @return 字符串
 */

+(NSDate *)getDateFromDateStr:(NSString *)dateStr
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [formatter dateFromString:dateStr];
    return date;
}

+(NSDate *)getDateFromDateStr1:(NSString *)dateStr
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [formatter dateFromString:dateStr];
    //    NSLocale* local =[[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hant"];
    //    [formatter setLocale: local];
    
    return date;
}

/**
 *  获取字符串201X-MM-dd HH:mm:DD
 *
 *  @param
 *
 *  @return 字符串
 */
+(NSString *)getNowStr
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:DD"];
    NSString * str = [formatter stringFromDate:[NSDate date]];
    return str;
}


+(CGSize)getSizeWithWidth:(CGFloat)width content:(NSString *)str font:(int)font
{
    if (str.length == 0 || !str) {
        return CGSizeZero;
    }
    NSDictionary * attDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor whiteColor],[UIFont systemFontOfSize:font], nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName,NSFontAttributeName, nil]];
    
    
    NSAttributedString * attStr = [[NSAttributedString alloc]initWithString:str attributes:attDic];
    NSRange range = NSMakeRange(0, attStr.length);
    NSDictionary * dic = [attStr attributesAtIndex:0 effectiveRange:&range];
    
    CGRect  rect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:Nil];
    return rect.size;
 

}


//读取系统的ControlData
-(BOOL)readSystemControlDataFromFile
{
    self.systemControlDataDic = [SystemManager loadFromFile:@"system_control_data"];
    if (self.systemControlDataDic == nil) {
        self.systemControlDataDic = [NSMutableDictionary dictionary];
        return NO;
    }
    return YES;
}

//获取文件路径
+ (NSString *)dataFilePath:(NSString *) dataPath {
    dataPath = [dataPath stringByAppendingString:@".plist"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // NSLog(@"%@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:dataPath];
}

//将本地plist文件加载到内存
+(NSMutableDictionary *)loadFromFile:(NSString *) plistName{
    NSString *error = nil;
    NSPropertyListFormat format;
    NSMutableDictionary *dict = nil;
    NSString *filePath = [self dataFilePath:plistName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        filePath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:filePath];
    dict = (NSMutableDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML
                                                                   mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                                                             format:&format
                                                                   errorDescription:&error];
    return dict;
}
//保存文件到沙盒
+(BOOL)saveToFile:(NSMutableDictionary *)withData fileName:(NSString *) fileName{
    NSString *error = nil;
    NSData    *plistData = [NSPropertyListSerialization dataFromPropertyList:withData format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    if(plistData) {
        return [plistData writeToFile:[self dataFilePath:fileName] atomically:YES];
    } else {
        return NO;
    }
}

//根据属性的名字取得属性的值
-(id)getPropertyWithKey:(NSString *)propertyName
{
    if (propertyName == nil) {
        return nil;
    }
    
    id propertyValue = [self.systemControlDataDic objectForKey:propertyName];
    if (propertyValue == nil) {
        propertyValue = @"";
    }
    
    /*
    
     *  取值的时候判断,如果取到用户名和密码,则复制全局变量
     
    if ([propertyName isEqualToString:_USER_NAME]) {
        self.userName = propertyValue;
    }else if ([propertyName isEqualToString:_USER_UID])
    {
        self.uid = propertyValue;
        self.isLogin = YES;
    }
    */
    
    return propertyValue;
}

//设置属性的值
-(BOOL)setPropertyWithKey:(NSString *)propertyName value:(id)propertyValue
{
    [self.systemControlDataDic setValue:propertyValue forKey:propertyName];
    

    //将内存中的数据保存进入plist
    return [self saveSystemControlDataToFile];
}

//写入系统的ControlData
-(BOOL)saveSystemControlDataToFile
{
    //写入本地的dic
    //将整个字典写入文件
    BOOL rst = [SystemManager saveToFile:self.systemControlDataDic fileName:@"system_control_data"];
    return rst;
}

//是否允许震动
static BOOL isEnableVibrate = YES;
/*手机震动*/
-(void)vibrate
{
    if (isEnableVibrate) {
        isEnableVibrate = NO;
        [self performSelector:@selector(isEnabledAction) withObject:nil afterDelay:3];
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}
-(void)isEnabledAction
{
    isEnableVibrate = YES;
}


#pragma mark   图片处理
//生成指定大小图片
+ (UIImage *)compressImage:(UIImage *)imgSrc
{
    CGSize size = {320, 480};
    UIGraphicsBeginImageContext(size);
    CGRect rect = {{0,0}, size};
    [imgSrc drawInRect:rect];
    UIImage *compressedImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return compressedImg;
}

/*图片压缩*/
static float scale = 1.0;
+(NSData *)compactImage:(UIImage *)image
{
    NSData * resultData= nil;
    NSData * data = UIImageJPEGRepresentation(image, scale);
    resultData = data;
    while (resultData.length > 1024 * 100 && scale > 0.1) {
        scale -= 0.05;
        UIImage * newImage = [UIImage imageWithData:data];
        NSData * newData = UIImageJPEGRepresentation(newImage, scale);
        resultData = newData;
    }
    
    return resultData;
}

//创建自定义颜色image
+(UIImage*) imageWithRect:(CGRect)ImageRect  Color:(UIColor*)color
{
    CGRect rect = ImageRect;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark 手机号码/密码/邮箱/身份证格式校验
//校验手机号码
-(BOOL)isValidateMobile:(NSString *)mobile
{
    if ([RightString(mobile) isEqualToString:@""])
    {
        HUDNormal(Mobile_EmptError);
        return NO;
    }
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:mobile];
    
    if (!isMatch)
    {
        HUDNormal(Mobile_LengthError);
    }
    return isMatch;
}

// 匹配6-15个由字母/数字组成的字符串的正则表达式
-(BOOL)isValidateMessageCode:(NSString *)messageCode
{
    if ([RightString(messageCode) isEqualToString:@""])
    {
        HUDNormal(MessageCode_EmptError);
        return NO;
    }
    NSString * regex = @"^[0-9]{4,6}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:messageCode];
    if (!isMatch)
    {
        HUDNormal(MessageCode_LengthError);
    }
    return isMatch;
}

// 匹配8-20个由字母和数字组成的字符串的正则表达式
-(BOOL)isValidatePassWord:(NSString *)password 
{
    if ([RightString(password) isEqualToString:@""])
    {

        HUDNormal(Password_EmptError);
        return NO;
    }
    if (password.length < 8) {
        HUDNormal(@"密码长度至少为8位");
        return NO;
    }
//    NSString * regex = @"^[A-Za-z0-9]{6,16}$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isMatch = [pred evaluateWithObject:password];
    
    //纯数字
    NSString * regexNum = @"^[0-9]{8,20}$";
    NSPredicate *predNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexNum];
    BOOL isMatchNum = [predNum evaluateWithObject:password];
    //纯字母
    NSString * regexChar = @"^[A-Za-z]{8,20}$";
    NSPredicate *predChar = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexChar];
    BOOL isMatchChar = [predChar evaluateWithObject:password];
//    if (isMatch)
//    {
//        HUDNormal(@"密码必须由6-16位数字和字母混合组成");
//        return NO;
//    } else
    if (isMatchChar) {
        HUDNormal(@"密码不能由纯字母组成");
        return NO;
    } else if (isMatchNum) {
        HUDNormal(@"密码不能由纯数字组成");
        return NO;
    }
    else if (!isMatchNum && !isMatchChar) {
        return YES;
    } else {
        HUDNormal(@"密码长度至少为8-20位");
        return NO;
    }
    
}

// 匹配6-20个由字母和数字组成的字符串的正则表达式(用户名)
-(BOOL)isValidateUserName:(NSString *)password
{
    if ([RightString(password) isEqualToString:@""])
    {
        
        HUDNormal(@"用户名不能为空");
        return NO;
    }
    if (password.length < 6) {
        HUDNormal(@"用户名长度至少为6位");
        return NO;
    }
    NSString * regex = @"^[A-Za-z_0-9]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:password];
    
    //纯数字
    NSString * regexNum = @"^[0-9]{6,20}$";
    NSPredicate *predNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexNum];
    BOOL isMatchNum = [predNum evaluateWithObject:password];
    //字母开头
    NSString *subchar = [password substringToIndex:1];
    NSString * regexChar = @"^[A-Za-z]{1,1}$";
    NSPredicate *predChar = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexChar];
    BOOL isMatchChar = [predChar evaluateWithObject:subchar];
    if (!isMatch)
    {
        HUDNormal(@"用户名必须由6-20位数字、字母和下划线组成");
        return NO;
    } else if (isMatchNum || !isMatchChar) {
        HUDNormal(@"用户名必须必须以字母开头");
        return NO;
    } else if (!isMatchNum && isMatchChar) {
        return YES;
    } else {
        HUDNormal(@"用户名长度至少为6位");
        return NO;
    }
    
}


-(BOOL)isValidateEmailOrPhone:(NSString *)string{
    if ([RightString(string) isEqualToString:@""])
    {
        
        HUDNormal(@"联系方式为空");
        return NO;
    }
    NSString * regex = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    if (!isMatch)
    {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        BOOL isMatch1 = [pred1 evaluateWithObject:string];
        if(!isMatch1){
            HUDNormal(@"手机号或者邮箱错误");
        }
        return isMatch1;
        
    }
    return isMatch;
}


//利用正则限制邮箱格式
-(BOOL)isValidateEmail:(NSString *)email
{
    if ([RightString(email) isEqualToString:@""])
    {
        HUDNormal(Email_EmptError);
        return NO;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
     BOOL isMatch =[emailTest evaluateWithObject:email];
    if (!isMatch)
    {
        HUDNormal(Email_LengthError);
    }
    return isMatch;
}

//利用正则限制身份证号
- (BOOL) isValidateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
- (BOOL) isValidateMoney: (NSString *)Money
{
    BOOL flag;
    if (Money.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 =   @"^\\d+(.?\\d{1,2})?$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:Money];
    
    
}



// 天数小时分钟秒的倒计时
- (NSString *)timerFireMethod:(NSTimer*)theTimer{
    
    id obj = [theTimer userInfo];
    NSDateFormatter *f1 = [[NSDateFormatter alloc] init];
    [f1 setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
    
    NSDate *theDay = [f1 dateFromString:(NSString*)obj];
    
    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    
    NSDate *today = [NSDate date];//得到当前时间
    
    //用来得到具体的时差
    unsigned int unitFlags =  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:theDay options:0];
    
    NSString *countdown = [NSString stringWithFormat:@"%ld日%ld时%ld分%ld秒",(long)[d day],(long) [d hour], (long)[d minute], (long)[d second]];
    NSLog(@"%@",countdown);
    //    self.timeLabel.text = countdown;
    
    return countdown;
    
}


@end
