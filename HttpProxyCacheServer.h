//
//  HttpProxyCacheServer.h
//  MusicCacheDemo
//
//  Created by fuhongjie on 4/20/16.
//  Copyright © 2016 fuhongjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpProxyCacheServer : NSObject

- (NSString *)getProxyUrl: (NSString *) url;

+ (instancetype) defaultProxyServer;

@end
