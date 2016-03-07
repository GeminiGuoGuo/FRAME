//
//  GlobalInfo.h
//  HealthyWalk
//
//  Created by 张博 on 15/2/6.
//  Copyright (c) 2015年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalInfo : NSObject

//软件身份key
@property (nonatomic, retain) NSString *app_key;
//手机唯一标识
@property (nonatomic, retain) NSString *imei;
//操作系统名称
@property (nonatomic, retain) NSString *os;
//操作系统版本
@property (nonatomic, retain) NSString *os_version;
//APP版本
@property (nonatomic, retain) NSString *app_version;
//通讯协议版本
@property (nonatomic, retain) NSString *ver;
//业主ID
@property (nonatomic, retain) NSString *uid;
//crc验证的字符串
@property (nonatomic, retain) NSString *crc;
//时间戳格式
@property (nonatomic, retain) NSString *time_stamp;

+ (GlobalInfo *)sharedGlobalInfoInstance;

@end
