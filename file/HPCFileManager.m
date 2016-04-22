//
//  HPCFileManager.m
//  MusicCacheDemo
//
//  Created by fuhongjie on 4/20/16.
//  Copyright © 2016 fuhongjie. All rights reserved.
//

#import "HPCFileManager.h"
#import "HPCFileConfig.h"

@interface HPCFileManager()

@property (nonatomic, strong) HPCFileConfig *config;

@end

@implementation HPCFileManager

+ (instancetype)defaultManager {
    
    static id manager;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}
- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.config = [[HPCFileConfig alloc] init];
    }
    return self;
}

- (void) cacheNewFile:(NSString *)filePath {

    [self.config addNew:filePath];
    
}


//获取文件大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        unsigned long long fileSize =
        [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        return fileSize;
    }
    
    return 0;
}

@end
