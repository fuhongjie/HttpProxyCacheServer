//
//  HPCFileConfig.m
//  MusicCacheDemo
//
//  Created by fuhongjie on 4/20/16.
//  Copyright © 2016 fuhongjie. All rights reserved.
//

#import "HPCFileConfig.h"
#import "HttpProxyCacheServerConfig.h"

@implementation CacheFile

@end

@implementation HPCFileConfig

- (void) addNew:(NSString *) filePath {
    
    [self fixCacheArea];
}

- (void) fixCacheArea {
    
    
    unsigned long long cacheTotleSize = 0;

    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *cachePath = [docs[0] stringByAppendingPathComponent:k_CACHE_PATH];
    
    NSArray *cacheFiles = [manager contentsOfDirectoryAtPath:cachePath error:nil];
    
    
    NSMutableArray *cacheFileArr = [NSMutableArray array];
    for (NSString *filePath in cacheFiles) {
        NSString *filePathFull = [cachePath stringByAppendingPathComponent:filePath];
        
        unsigned long long fileSize = [[manager attributesOfItemAtPath:filePathFull error:nil] fileSize];
        
        
        cacheTotleSize += fileSize;
        
        NSDate *creatTime = [[manager attributesOfItemAtPath:filePathFull error:nil] fileCreationDate];
        
        CacheFile *cacheFile = [[CacheFile alloc] init];
        cacheFile.size = fileSize;
        cacheFile.creatTime = creatTime;
        cacheFile.filePath = filePathFull;
        [cacheFileArr addObject:cacheFile];
        
        
    }
    
    
    [cacheFileArr sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
        
        CacheFile *file1 = (CacheFile *)obj1;
        CacheFile *file2 = (CacheFile *)obj2;
        
        if (file1.creatTime == [file1.creatTime earlierDate:file2.creatTime]) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
        
    }];
    
    long long shoudClearSize = cacheTotleSize - k_CACHE_SIZE;
    
    
    while (shoudClearSize >= 0) {
        CacheFile *file = [cacheFileArr firstObject];
        if ( [manager removeItemAtPath:file.filePath error:nil]) {
            
            
            NSLog(@"缓冲区已满， 删除文件:%@",file.filePath);
            
            shoudClearSize -= file.size;
            [cacheFileArr removeObjectAtIndex:0];
        }
  
    }

    
}

@end
