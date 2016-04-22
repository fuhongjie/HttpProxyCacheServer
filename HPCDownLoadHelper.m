//
//  HPCDownLoadHelper.m
//  MusicCacheDemo
//
//  Created by fuhongjie on 4/20/16.
//  Copyright © 2016 fuhongjie. All rights reserved.
//

#import "HPCDownLoadHelper.h"
#import "AFNetworking.h"
#import "HttpProxyCacheServerConfig.h"
#import "Md5FileNameGenerator.h"
#import "HPCFileManager.h"

@interface HPCDownLoadHelper()


@property (nonatomic,strong) NSOperationQueue *_queue;

@end

@implementation HPCDownLoadHelper

- (BOOL)doDownLoad:(NSString *)url {

    NSString *filePath =[Md5FileNameGenerator generateFilePath:url];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    
    AFURLSessionManager  *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    //添加请求接口
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //发送下载请求
    NSURLSessionDownloadTask *downloadTask = [sessionManager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        //设置存放文件的位置
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePathUrl, NSError *error) {
        
        HPCFileManager *manager = [HPCFileManager defaultManager];
        
        [manager cacheNewFile:filePath];
        
    }];
    
    //开始下载
    [downloadTask resume];
    
    return NO;

}

@end
