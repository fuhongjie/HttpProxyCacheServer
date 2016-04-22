//
//  HPCFileConfig.h
//  MusicCacheDemo
//
//  Created by fuhongjie on 4/20/16.
//  Copyright © 2016 fuhongjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheFile : NSObject

@property (nonatomic, assign) long long size;

@property (nonatomic, strong) NSDate *creatTime;

@property (nonatomic, strong) NSString *filePath;

@end

@interface HPCFileConfig : NSObject

- (void) addNew:(NSString *) filePath;

@end
