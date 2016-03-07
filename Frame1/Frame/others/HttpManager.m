//
//  HttpManager.m
//  HHUserClient
//
//  Created by yh on 15/2/2.
//  Copyright (c) 2015年 yh. All rights reserved.
//

#import "HttpManager.h"
#import "JSONKit.h"
#import "SVProgressHUD.h"
#import "MMSJCommon.h"
#import "AFNetworking.h"

//接口
#define BASE_URL @"http://10.10.10.2:7077/kingkaid/security/" //统一

static HttpManager * manager = nil;
static AFHTTPSessionManager * sessionManager = nil;
static AFHTTPRequestOperationManager *  requestManager = nil;
static NSString * const AFAppDotNetAPIBasseURLString = BASE_URL;

@interface HttpManager()<NSXMLParserDelegate>
{
    BOOL singleFlag;
    BOOL doubleFlage;
    BOOL wrongFlag;
}

@property (nonatomic, strong) NSMutableArray *parserArray;
@property (nonatomic, strong) NSMutableArray *doubleArray;
@property (nonatomic, strong) NSMutableArray *doubleArrOne;
@property (nonatomic, strong) NSMutableArray *doubleArrTwo;
@property (nonatomic, strong) NSMutableArray *wrongArray;
@property (nonatomic, copy) NSString *tempStr;

@end

@implementation HttpManager
+(HttpManager *)shareManager
{
    if (!manager)
    {
       static dispatch_once_t  predicate;
       dispatch_once(&predicate, ^{
           
           manager = [[HttpManager alloc] init];
           requestManager = [AFHTTPRequestOperationManager manager];
           NSLog(@"单例类创建");
           
           sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBasseURLString]];
           sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
           manager.networkStatus = AFNetworkReachabilityStatusReachableViaWiFi;
           [sessionManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
               
               switch (status) {
                       
                   case AFNetworkReachabilityStatusReachableViaWWAN :
                   {
                       NSLog ( @"-------AFNetworkReachabilityStatusReachableViaWWAN------" );
                       manager.networkStatus = AFNetworkReachabilityStatusReachableViaWWAN;
                       SVHUD_HINT(@"蜂窝移动网络");
                   }
                       break ;
                       
                   case AFNetworkReachabilityStatusReachableViaWiFi :
                   {
                       NSLog ( @"-------AFNetworkReachabilityStatusReachableViaWiFi------" );
                       if (manager.networkStatus != AFNetworkReachabilityStatusReachableViaWiFi)
                       {
                           SVHUD_HINT(@"WIFI网络");
                       }
                       manager.networkStatus = AFNetworkReachabilityStatusReachableViaWiFi;
                       
                   }
                       break ;
                       
                   case AFNetworkReachabilityStatusNotReachable :
                   {
                       UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您现在网络中断了！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                       [alert show];
                       NSLog ( @"-------AFNetworkReachabilityStatusNotReachable------" );
                       manager.networkStatus = AFNetworkReachabilityStatusNotReachable;
                   }
                       break ;
                       
                   default :
                       
                       break ;
                       
               }
           }];
           
       });
    }
    return manager;
}

-(BOOL)isCanRequest
{
    if (self.networkStatus == AFNetworkReachabilityStatusReachableViaWiFi || self.networkStatus == AFNetworkReachabilityStatusReachableViaWWAN) {
        return YES;
    }
    SVHUD_HINT(@"没有网络");
    return NO;
}
//-(NSDictionary *)getauth
//{
//    
//    NSDictionary *dic = @{@"appkey": @"123456",
//                          @"imei": @"imei",
//                          @"os": @"Iphone os",
//                          @"osversion": @"7.0",
//                          @"appversion": @"1.0",
//                          @"protocolver": @"0.9",
//                          @"crcstring": @"Cbaq4fxvb"};
//    return dic;
//}

//加密
- (NSString *)getauth
{
    return @"e10adc3949ba59abbe56e057f20f8";
}

- (NSMutableDictionary *)GetData:(NSMutableDictionary *)dict
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:[dict JSONString] forKey:@"info"];
    return dic;
}


- (NSMutableDictionary *)PostData:(NSDictionary *)dict
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
 //   [dic setObject:[[self getauth] JSONString] forKey:@"auth"];
    [dic setObject:[self getauth] forKey:@"auth"];
    [dic setObject:[dict JSONString] forKey:@"info"];
    return dic;
}

-(NSString *)getStrWithInfoDic:(NSMutableDictionary *)infoDic
{
    NSString * authStr = @"{appkey:123456,imei:444012,os:Iphoneos,osversion:5.0,appversion:1.0.0,protocolver:0.9,crcstring:Cbaq4fxvb}";
    NSString * infoStr = @"";
    for (NSString * keyStr in infoDic.allKeys) {
        infoStr = [infoStr stringByAppendingFormat:@"%@=%@",keyStr,infoDic[keyStr]];
    }
    infoStr = [NSString stringWithFormat:@"{%@}",infoStr];
    NSString * resultStr = [NSString stringWithFormat:@"auth=\"%@\"&info=\"%@\"",authStr,infoStr];
    return resultStr;
}




- (NSMutableDictionary *)RemoveNull:(NSMutableDictionary *)dict
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString * oldStr =[[dict JSONString] stringByReplacingOccurrencesOfString:@"\"null\"" withString:@"\"\""];
    NSString *str = [oldStr stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
    dic = [str objectFromJSONString];
    if (!dic) {
        return dict;
    }
    return dic;
}

- (NSMutableDictionary *)RemoveNullWithJsonStr:(NSString *)jsonStr
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString * oldStr =[jsonStr stringByReplacingOccurrencesOfString:@"\"null\"" withString:@"\"\""];
    NSString *str = [oldStr stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
    dic = [str objectFromJSONString];
    return dic;
}
/**
 *  普通网络请求 传入info字典  URL短码 实现成功回调  失败回调
 *
 *  @param infoDic       info字典
 *  @param url           短码
 *  @param success_block 成功回调
 *  @param fail_block    失败回调
 */
-(AFHTTPRequestOperation *)sendRequestWithDic:(NSDictionary *)infoDic opt:(NSString *)opt shortURL:(NSString *)url setSuccessBlock:(void(^)(NSDictionary * responseDic))success_block setFailBlock:(void (^)(id obj))fail_block
{
    if (![self isCanRequest]) {
        return nil;
    }
    SVHUD_NO_Stop(@"正在加载");
    NSString * urlStr = GETSTRING_WITH(BASE_URL, url);
    
    AFHTTPRequestOperation * operation = nil;
    NSDictionary * postDic = [self PostData:infoDic];
    
   // NSLog(@"%@-----%@",urlStr,postDic);
    
    if ([opt isEqualToString:OPT_POST]) {
        //        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
        //        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //如果报接受类型不一致请替换一致text/html或别的
        //        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [requestManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        //        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        operation =  [requestManager POST:urlStr parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //         NSDictionary * getDic = [self RemoveNull:responseObject];

          
            NSDictionary * getDic = [self RemoveNullWithJsonStr:operation.responseString];
            
            if (success_block) {
                success_block(getDic);
            }
            if ([getDic[@"code"] isEqualToString:@"0"])
            {
                //                            HUDNormal(getDic[@"msg"]);
                SVHUD_HTTP_SUCCESS(getDic[@"msg"]);
            }else
            {
                SVHUD_HINT(getDic[@"msg"]);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (fail_block) {
                fail_block(error);
            }
            SVHUD_HTTP_ERROR;
        }];
    }
    else if ([opt isEqualToString:OPT_GET])
    {
        operation = [requestManager GET:urlStr parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            SVHUD_Stop;
            //                        NSDictionary * getDic = [self RemoveNull:responseObject];
            NSDictionary * getDic = [self RemoveNullWithJsonStr:operation.responseString];
            
            //NSLog(@"dic---%@",getDic);

            if (success_block) {
                success_block(getDic);
            }
            if ([getDic[@"code"] isEqualToString:@"0"]) {

            }else
            {
                SVHUD_HINT(getDic[@"msg"]);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (fail_block) {
                fail_block(error);
                NSLog(@"%@",error.localizedDescription);
            }
            SVHUD_Stop;
            SVHUD_HTTP_ERROR;
        }];
        
    }
    return operation;
}





/**
 *  上传图片  传入info字典  URL短码 实现成功回调  失败回调
 *
 *  @param infoDic       info字典
 *  @param urlStr        短码
 *  @param imageArray    图片数组
 *  @param success_block 成功回调
 *  @param fail_block    失败回调
 */
-(void)uploadImagesWithDic:(NSMutableDictionary *)infoDic shortURL:(NSString *)url images:(NSArray *)imageArray imageName:(NSString *)name setSuccessBlock:(void(^)(NSDictionary * responseDic))success_block setFailBlock:(void (^)(id obj))fail_block
{
    if (![self isCanRequest]) {
        return;
    }
    SVHUD_NO_Stop(@"正在加载");
    NSString * urlStr = GETSTRING_WITH(BASE_URL, url);
    NSDictionary * postDic = [self PostData:infoDic];
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i =0; i<imageArray.count; i++)
        {
            UIImage * image = imageArray[i];
            [formData appendPartWithFileData:[SystemManager compactImage:image] name:name fileName:[NSString stringWithFormat:@"image%@",@"01.png"] mimeType:@"Multipart/form-data"];
        }
        
    } error:nil];
    
    if (/* DISABLES CODE */ (0)) {
        AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpecteNSLogoWrite) {
            
        }];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString * responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary * getDic = [responseStr objectFromJSONString];
            SVHUD_Stop;
            if (success_block) {
                success_block(getDic);
            }
            if ([getDic[@"code"] isEqualToString:@"0"]) {
                
            }else
            {
                SVHUD_HINT(getDic[@"msg"]);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (fail_block) {
                fail_block(error);
            }
            SVHUD_Stop;
            SVHUD_HTTP_ERROR;
        }];
        [operation start];
    }
    else
    {
        AFURLSessionManager * manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLSessionUploadTask * uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            SVHUD_Stop;
            if (error) {
                SVHUD_HTTP_ERROR;
                if (fail_block) {
                    fail_block(error);
                }
            }
            else
            {
                NSDictionary * getDic = [self RemoveNull:responseObject];
                if (success_block) {
                    success_block(getDic);
                }
                if ([getDic[@"code"] isEqualToString:@"0"]) {
                    
                }else
                {
                    SVHUD_HINT(getDic[@"msg"]);
                }
            }
        }];
        [uploadTask resume];
    }
    
    
}



/**
 *  取消网络请求
 */
-(void) cancleRequstWithOperation:(AFHTTPRequestOperation *)operation
{
    [operation cancel];
}

/*

//无图网络请求
-(AFHTTPRequestOperation *)sendRequestWithUrl:(NSString *)url data:(NSString *)data setSuccessBlock:(void(^)(id responseDic))success_block setFailBlock:(void (^)(id obj))fail_block
{
    SVHUD_NO_Stop(@"正在加载");
    NSString *str = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
    NSURL *URL = [NSURL URLWithString:str];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    
    
    //设置httpBody
    UserModel *model = [[UserModel alloc] init];
    NSRange bodyRange = [data rangeOfString:@"</message>"];
    NSString *bodyStr = [data substringToIndex:bodyRange.location];
    if (model.isLogin && !model.isRenZheng) {
        NSString *bodyStr2 = [NSString stringWithFormat:@"<annex type=\"http://www.bmsoft.com/datatypes/annex#ELog\"><d>%@</d><d>%@</d><null/><null/><null/><null/><d>%@</d><d>%@</d><null/><null/><null/><null/></annex>", model.MemberId, model.MemberName, model.pinPai, model.caoZuoXiTong];
        NSString *dataStr = [NSString stringWithFormat:@"%@%@</message>", bodyStr, bodyStr2];
        [request setHTTPBody:[dataStr dataUsingEncoding:NSUTF8StringEncoding]];

    } else {
        NSString *bodyStr2 = @"<annex type=\"http://www.bmsoft.com/datatypes/annex#ELog\"><null/><null/><null/><null/><null/><null/><null/><null/><null/><null/><null/><null/></annex>";
        NSString *dataStr = [NSString stringWithFormat:@"%@%@</message>", bodyStr, bodyStr2];
        [request setHTTPBody:[dataStr dataUsingEncoding:NSUTF8StringEncoding]];

    }
    
    //[request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/xml;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {

        //data 转化成字符串
        NSString *str1 = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSString *str1 = @"<message xmlns=\"http://www.webafx.org/ns/lws/1.0\"><record><d>10-0000000049</d><d>10</d><d>13</d><d>1</d><d>03</d><d>湖北金开贷</d><d>6000060001207670</d><d>90001</d><d>100</d><d>2015-02-20</d><d>9</d><null/><d>90002</d><d>80000</d><d>002</d><d></d></record></message>";
        singleFlag = NO;
        doubleFlage = NO;
        wrongFlag = NO;
        //单挑记录
        NSRange range = [str1 rangeOfString:@"<record>"];
        //多条记录
        NSRange range1 = [str1 rangeOfString:@"<recordset>"];
        //异常
        NSRange range2 = [str1 rangeOfString:@"<status code="];
        if (range.length != 0 && range1.length == 0 && range2.length == 0) {
            //单挑记录
            singleFlag = YES;
            NSString *ss = [str1 substringFromIndex:range.location];
            //拼出xml字符串
            NSString *ensureStr = [NSString stringWithFormat:@"%@%@", @"<message>", ss];
            NSData *data = [ensureStr dataUsingEncoding:NSUTF8StringEncoding];
            NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
            xmlParser.delegate = self;
            [xmlParser parse];
            if (success_block) {
                success_block(_parserArray);
            }
            SVHUD_HTTP_SUCCESS(@"加载完成");
        } else if (range.length != 0 && range1.length != 0 && range2.length == 0) {
            //多条记录
            
            //情况一:record  recordSet record
            //情况二:recordSet annex record
            //情况三:recordSet record
            doubleFlage = YES;
            NSString *sub = [str1 substringFromIndex:range1.location];
            NSRange rangeOne = [str1 rangeOfString:@"</record><recordset>"];
            NSRange rangeTwo = [str1 rangeOfString:@"<recordset><record>"];
            NSString *sub1 = [str1 substringFromIndex:range1.location - 2];
            if (!rangeOne.length == 0) {
                //情况一:record  recordSet record
                NSRange subRange = [str1 rangeOfString:@"\"><record>"];
                NSString *ss = [str1 substringFromIndex:subRange.location + 1];
                //拼出xml字符串
                NSString *ensureStr = [NSString stringWithFormat:@"%@%@", @"<message", ss];
                NSData *data = [ensureStr dataUsingEncoding:NSUTF8StringEncoding];
                NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
                xmlParser.delegate = self;
                [xmlParser parse];
                if (success_block) {
                    success_block(_doubleArray);
                }
                SVHUD_HTTP_SUCCESS(@"加载完成");
                
            } else if (rangeTwo.length != 0) {
                //情况三:recordSet record
                NSRange subRange = [str1 rangeOfString:@"\"><recordset"];
                NSString *ss = [str1 substringFromIndex:subRange.location + 1];
                //拼出xml字符串
                NSString *ensureStr = [NSString stringWithFormat:@"%@%@", @"<message", ss];
                NSData *data = [ensureStr dataUsingEncoding:NSUTF8StringEncoding];
                NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
                xmlParser.delegate = self;
                [xmlParser parse];
                if (success_block) {
                    success_block(_doubleArray);
                }
                SVHUD_HTTP_SUCCESS(@"加载完成");
            } else {
                //情况二:recoredSet annex record
                NSRange subRange = [sub rangeOfString:@"\"><d>"];
                NSRange subRange1 = [sub rangeOfString:@"\"><null/>"];
                if (subRange.length != 0) {
                    NSString *ss = [sub substringFromIndex:subRange.location + 1];
                    //拼出xml字符串
                    NSString *ensureStr = [NSString stringWithFormat:@"%@%@", @"<message><recordset><annex", ss];
                    
                    NSData *data = [ensureStr dataUsingEncoding:NSUTF8StringEncoding];
                    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
                    xmlParser.delegate = self;
                    [xmlParser parse];
                    if (success_block) {
                        success_block(_doubleArray);
                    }
                    SVHUD_HTTP_SUCCESS(@"加载完成");
                } else {
                    NSString *ss = [sub substringFromIndex:subRange1.location + 1];
                    //拼出xml字符串
                    NSString *ensureStr = [NSString stringWithFormat:@"%@%@", @"<message><recordset><annex", ss];
                    NSData *data = [ensureStr dataUsingEncoding:NSUTF8StringEncoding];
                    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
                    xmlParser.delegate = self;
                    [xmlParser parse];
                    if (success_block) {
                        success_block(_doubleArray);
                    }
                    SVHUD_HTTP_SUCCESS(@"加载完成");
                    
                }
            }
        } else if (range2.length != 0 && range1.length == 0 &&range.length == 0){
            //异常记录
            wrongFlag = YES;
            NSString *ss = [str1 substringFromIndex:range2.location];
            NSRange ra  = [ss rangeOfString:@"\">"];
            NSString *subss = [ss substringFromIndex:ra.location + 1];
            //拼出xml字符串
            NSString *ensureStr = [NSString stringWithFormat:@"%@%@", @"<message><status", subss];
            NSData *data = [ensureStr dataUsingEncoding:NSUTF8StringEncoding];
            NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
        
            xmlParser.delegate = self;
            [xmlParser parse];
            NSDictionary *dic = @{@"status":_wrongArray};
            if (success_block) {
                success_block(dic);
            }
            SVHUD_HTTP_SUCCESS(@"加载完成");
        } else {
            //recordSet为空,既返回的数组为空
            //情况:recordSet message(recordSet为空)
            if (success_block) {
                NSArray *array = [NSArray array];
                success_block(array);
            }
            SVHUD_HTTP_SUCCESS(@"加载完成");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail_block) {
            fail_block(error);
        }
        SVHUD_Stop;
        SVHUD_HTTP_ERROR;
    }];
    [manager.operationQueue addOperation:operation];
    [operation start];
    return operation;
}

//parse代理
//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    if (singleFlag == YES) {
        self.parserArray = [NSMutableArray array];
    }
    if (doubleFlage == YES) {
        self.doubleArray = [NSMutableArray array];
        self.doubleArrOne = [NSMutableArray array];
        self.doubleArrTwo = [NSMutableArray array];
    }
    if (wrongFlag == YES) {
        self.wrongArray = [NSMutableArray array];
    }
}

//结束解析
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
//    for (NSString *s in _parserArray) {
//        NSLog(@"---%@", s);
//    }
//    for (NSArray *a in _doubleArray) {
//        for (NSString *aa in a) {
//         NSLog(@"---%@", aa);
//        }
//    }
//    for (NSString *ss in _wrongArray) {
//        NSLog(@"---%@", ss);
//    }
    
}

//解析出现错误
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"error:%@", parseError);
}

//遇到开始标签
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"startElement:%@",elementName);
    if (singleFlag == YES) {
        if ([elementName isEqualToString:@"record"]) {
            
        }
    }
    if (doubleFlage == YES) {
        if ([elementName isEqualToString:@"recordset"]) {
            
        }
        if ([elementName isEqualToString:@"record"]) {
            self.doubleArrTwo = [NSMutableArray array];
        }
        if ([elementName  isEqualToString:@"annex"]) {
            self.doubleArrTwo = [NSMutableArray array];
            
        }
    }
    if (wrongFlag == YES) {
        
        if ([elementName  isEqualToString:@"status"]) {
            
        }
    }
    //elementName:标签名字
    //namespaceURI:命名空间
    //attributeDict:标签属性
    
}

//遇到结束标签
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"endElement:%@", elementName);
    if ([elementName isEqualToString:@"record"]) {
        ;
        if (singleFlag == YES) {
            
        }
        if (doubleFlage == YES) {
            [_doubleArray addObject:_doubleArrTwo];
            //[_doubleArrTwo removeAllObjects];
        }
        
    } else if ([elementName isEqualToString:@"annex"]) {
        if (doubleFlage == YES) {
            [_doubleArray addObject:_doubleArrTwo];
            //[_doubleArrTwo removeAllObjects];
        }
    } else if ([elementName isEqualToString:@"d"]) {
        if (singleFlag == YES) {
            [_parserArray addObject:_tempStr];
        }
        
        if (doubleFlage == YES) {
            [_doubleArrTwo addObject:_tempStr];
            
        }
    } else if ([elementName isEqualToString:@"null"]) {
        if (singleFlag == YES) {
            [_parserArray addObject:@""];
        }
        
        if (doubleFlage == YES) {
            [_doubleArrTwo addObject:@""];
            
        }
    } else if ([elementName isEqualToString:@"recordset"]) {
        
    } else if ([elementName isEqualToString:@"status"]) {
        [_wrongArray addObject:_tempStr];
    }
    self.tempStr = @"";
}

//开始和结束标签之间的内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //NSLog(@"content:%@", string);

    NSLog(@"%@", string);
    self.tempStr = [NSString stringWithFormat:@"%@%@", self.tempStr, string];
    NSRange range = [_tempStr rangeOfString:@"(null)"];
    if (range.length != 0) {
        _tempStr = [_tempStr substringFromIndex:range.length];
    }
}

 
*/

@end
