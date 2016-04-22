//
//  Md5FileNameGenerator.h
//  MusicCacheDemo
//
//  Created by fuhongjie on 4/20/16.
//  Copyright © 2016 fuhongjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Md5FileNameGenerator : NSObject

+ (NSString*) generate:(NSString*)url;

+ (NSString*) generateFilePath:(NSString*)url;

+ (NSString*) generateProxyUrl:(NSString*)url;

@end
