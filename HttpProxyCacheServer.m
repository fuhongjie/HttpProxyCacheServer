//
//  HttpProxyCacheServer.m
//  MusicCacheDemo
//
//  Created by fuhongjie on 4/20/16.
//  Copyright © 2016 fuhongjie. All rights reserved.
//

#import "HttpProxyCacheServer.h"
#import "AFNetworking.h"
#import "HTTPServer.h"
#import "HttpProxyCacheServerConfig.h"
#import "Md5FileNameGenerator.h"
#import "HPCDownLoadHelper.h"

@interface HttpProxyCacheServer()

@property (nonatomic, strong) HTTPServer *httpServer;

@property (nonatomic, assign) BOOL serverStart;

@end

@implementation HttpProxyCacheServer


- (instancetype)init {
    
    self = [super init];
    if (self) {
        _serverStart = NO;
        [self build];
        
    }
    return self;
}


+ (instancetype)defaultProxyServer {
    
    static id instance;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (NSString *)getProxyUrl:(NSString *)url {
    
    //HttpServer未启动，返回原始url
    if (!_serverStart) {
        return url;
    }
    
    BOOL hasCache = [[[HPCDownLoadHelper alloc] init] doDownLoad:url];
    
    if (hasCache) {
        return [Md5FileNameGenerator generateProxyUrl:url];
    } else {
        NSURL *__url__ = [NSURL URLWithString:url];
        if ([__url__ checkResourceIsReachableAndReturnError:nil]) {
            return [Md5FileNameGenerator generateProxyUrl:url];
        } else{
            return url;
        }
    }
    
}

- (void)build {
    
    _httpServer = [[HTTPServer alloc] init];
    
    [_httpServer setType:@"_http._tcp."];
    
    [_httpServer setPort:k_PORT];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [docs[0] stringByAppendingPathComponent:k_CACHE_PATH];
    
    if(![fileManager fileExistsAtPath:cachePath]) {
        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    [_httpServer setDocumentRoot:cachePath];
    
    [self startServer];
    
}

- (void)startServer {
    
    NSError *error;
    _serverStart = [_httpServer start:&error];
    
}

@end
