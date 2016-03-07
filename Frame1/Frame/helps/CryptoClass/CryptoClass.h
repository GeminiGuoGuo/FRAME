//
//  CryptoClass .h
//  FFPlayer
//
//  Created by user on 12-5-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

@interface CryptoClass: NSObject
{
    
}

 //对内存数据加密解密,参数op判断是加密还是解密  inbuffer为原始数据，outbuffer为加解密之后的数据，length为加密的长度。

- (bool)desBurrer:(char *)inbuffer outbuffer:(char*)outbuffer length:(int)length key:(NSString *)keyString CCOperation:(CCOperation)op;


//- (NSData *)desData:(NSData *)data key:(NSString *)keyString CCOperation:(CCOperation)op;

-(bool)ENorDecrypt:(NSString *)videoPath type:(bool)type;


@end
