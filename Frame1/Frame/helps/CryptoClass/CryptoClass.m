
#import "CryptoClass.h"
const char keysvalue[10]="abcdabcd";
 

const int encodenum=400;//加密的字节长度
@implementation CryptoClass

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (bool)desBurrer:(char *)inbuffer outbuffer:(char*)outbuffer length:(int)length key:(NSString *)keyString CCOperation:(CCOperation)op
{
    //kCCEncrypt
    size_t bufferNumBytes;
    CCCryptorStatus cryptStatus = CCCrypt(op,
                                          
                                          kCCAlgorithmDES,
                                          
                                          kCCOptionECBMode,
                                          
                                          [keyString UTF8String],
                                          
                                          kCCKeySizeDES,
                                          
                                          NULL,
                                          
                                          inbuffer,
                                          
                                          length,
                                          
                                          outbuffer,
                                          
                                          length,
                                          
                                          &bufferNumBytes);
    
    if(cryptStatus == kCCSuccess)
    {
        return  YES;
        
    }
    else
        return NO;
    
}

- (NSData *)desData:(NSData *)data key:(NSString *)keyString CCOperation:(CCOperation)op
{
    Byte buffer [encodenum] ;
    memset(buffer, 0, sizeof(buffer));
    size_t bufferNumBytes;
    CCCryptorStatus cryptStatus = CCCrypt(op, 
                                          
                                          kCCAlgorithmDES, 
                                          
                                            kCCOptionECBMode,
                                          
                                          [keyString UTF8String], 
                                          
                                          kCCKeySizeDES,
                                          
                                          NULL, 
                                          
                                          [data bytes], 
                                          
                                          [data length],
                                          
                                          buffer, 
                                          
                                          encodenum,
                                          
                                          &bufferNumBytes);
    if(cryptStatus == kCCSuccess)
    {
        NSData *returnData =  [NSData dataWithBytes:buffer length:bufferNumBytes];
        return returnData;
    
    }
    NSLog(@"des failed！");
    return nil;
    
}


-(bool)ENorDecrypt:(NSString *)videoPath type:(bool)type
{
    
    NSFileHandle * fileHandledes = [NSFileHandle fileHandleForUpdatingAtPath:videoPath];
    NSData*  fileDatades  = [fileHandledes readDataOfLength:encodenum];
    CCOperation op;
      NSString *strkeydes =[NSString stringWithFormat:@"%s",keysvalue];
    if (type) {
          op=kCCEncrypt;
    }
    else
    {
          op= kCCDecrypt;
    }
    NSData * desdatades  = [self desData:fileDatades  key:strkeydes  CCOperation:op];
    if (!desdatades) 
    {
        return NO;
    }
 
    [fileHandledes  seekToFileOffset:0];
     [fileHandledes  writeData:desdatades ]; //将NSData数据写入文件
    [fileHandledes  closeFile]; 
    return YES;
    
}

@end
