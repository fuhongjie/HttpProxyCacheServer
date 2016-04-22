//
//  HPCFileManager.h
//  MusicCacheDemo
//
//  Created by fuhongjie on 4/20/16.
//  Copyright © 2016 fuhongjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPCFileManager : NSObject

- (void) cacheNewFile:(NSString *)filePath;

+ (instancetype)defaultManager;

@end
