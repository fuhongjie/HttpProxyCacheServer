//
//  Md5FileNameGenerator.m
//  MusicCacheDemo
//
//  Created by fuhongjie on 4/20/16.
//  Copyright © 2016 fuhongjie. All rights reserved.
//

#import "Md5FileNameGenerator.h"
#import <CommonCrypto/CommonDigest.h>
#import "HttpProxyCacheServerConfig.h"

@implementation Md5FileNameGenerator

+ (NSString *) generate:(NSString*)url {
    
    const char *cStr = [url UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    
    NSMutableString *hash = [NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        [hash appendFormat:@"%02X",result[i]];
    }
    return [hash lowercaseString];
}


+ (NSString *) generateFilePath:(NSString *)url {
    
    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *cachePath = [docs[0] stringByAppendingPathComponent:k_CACHE_PATH];
    
    NSString *fileName = [Md5FileNameGenerator generate:url];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",cachePath,fileName];
    
    NSLog(filePath);
    
    return filePath;
}

+ (NSString*) generateProxyUrl:(NSString*)url {
    
    return [NSString stringWithFormat:@"http://127.0.0.1:%d/%@",k_PORT,[Md5FileNameGenerator generate:url]];
}


@end
