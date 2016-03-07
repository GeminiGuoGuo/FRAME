//
//  HttpManager.h
//  HHUserClient
//
//  Created by yh on 15/2/2.
//  Copyright (c) 2015年 yh. All rights reserved.
//





#define OPT_POST @"post"
#define OPT_GET @"get"
#define Request_Sucess [responseDic[@"code"] isEqualToString:@"0"]

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface HttpManager : NSObject

/**
 *  当前网络状况
 */
@property(assign,nonatomic)AFNetworkReachabilityStatus  networkStatus;
/**
 *  实例华请求类对象
 *
 *  @return 返回单例
 */
+(HttpManager *)shareManager;


///**
// *  获取get数据,传入info字典
// */
//- (NSMutableDictionary *)GetData:(NSMutableDictionary *)dict;
//
///**
// *  获取post数据，传入Info字典
// *
// *  @return
// */
//- (NSMutableDictionary *)PostData:(NSMutableDictionary *)dict;
///**
// *  移除数组中的null
// *
// */
//- (NSMutableDictionary *)RemoveNull:(NSMutableDictionary *)dict;



/**
 *  普通网络请求 传入info字典  URL短码 实现成功回调  失败回调
 *
 *  @param infoDic       info字典
 *  @param url           短码
 *  @param opt          post/get
 *  @param success_block 成功回调
 *  @param fail_block    失败回调
 */
-(AFHTTPRequestOperation *)sendRequestWithDic:(NSDictionary *)infoDic opt:(NSString *)opt shortURL:(NSString *)url setSuccessBlock:(void(^)(NSDictionary * responseDic))success_block setFailBlock:(void (^)(id obj))fail_block;

/**
 *  上传图片  传入info字典  URL短码 实现成功回调  失败回调
 *
 *  @param infoDic       info字典
 *  @param urlStr        短码
 *  @param imageArray    图片数组
 *  @param success_block 成功回调
 *  @param fail_block    失败回调
 */
-(void)uploadImagesWithDic:(NSDictionary *)infoDic shortURL:(NSString *)url images:(NSArray *)imageArray imageName:(NSString *)name setSuccessBlock:(void(^)(NSDictionary * responseDic))success_block setFailBlock:(void (^)(id obj))fail_block;


/**
 *  取消网络请求
 */
-(void) cancleRequstWithOperation:(AFHTTPRequestOperation *)operation;

//无图网络请求
-(AFHTTPRequestOperation *)sendRequestWithUrl:(NSString *)url data:(NSString *)data setSuccessBlock:(void(^)(id  responseDic))success_block setFailBlock:(void (^)(id obj))fail_block;

@end
