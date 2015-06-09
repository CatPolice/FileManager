//
//  FileManager.m
//  CreateFile
//
//  Created by gavin on 15/6/9.
//  Copyright (c) 2015年 gavin. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager


/*
 获取Documents目录路径
 */
+ (NSString *)getDirDocumentsPath{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"app_home_doc: %@",documentsDirectory);
    return documentsDirectory;
}

/*
 获取Library目录路径
 */
+ (NSString *)getDirLibraryPath{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSLog(@"app_home_lib: %@",libraryDirectory);
    return libraryDirectory;
}

/*
 获取Cache目录路径
 */
+ (NSString *)getDirCachePath{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSLog(@"app_home_lib_cache: %@",cachePath);
    return cachePath;
}

/*
 获取程序的Home目录
 */
+ (NSString *)getDirHomeDirectory{
    NSString *homeDirectory = NSHomeDirectory();
    NSLog(@"path:%@", homeDirectory);
    return homeDirectory;
}



/*
 判断文件是否存在
 */

+ (BOOL) isFileThere:(NSString *)filePath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    
    BOOL isDirExist = [fileManager fileExistsAtPath:filePath
                                        isDirectory:&isDir];
    
    return isDirExist;
}


/*
 判断文件夹是否存在，如果不存在就创建该文件夹
 */
+ (void) isFileThereWithCreateFile:(NSString *)filePath{
//    #define DOCUMENTS_FOLDER_AUDIO @"" //你定义的audio对应的文件目录
//    #define DOCUMENTS_FOLDER_VEDIO @"" //你定义的vedio对应的文件目录
    
    // 判断存放音频、视频的文件夹是否存在，不存在则创建对应文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
        
    BOOL isDir = NO;
        
    BOOL isDirExist = [fileManager fileExistsAtPath:filePath
                                            isDirectory:&isDir];
    
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:filePath
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:nil];
        if(!bCreateDir){
            NSLog(@"Create Audio Directory Failed.");
        }
        NSLog(@"%@",filePath);
    }
    
}


/*
 在NSDocument里面创建 MP3 文件夹，并且存贮文件
 */
#define DOCUMENTS_AUDIO_MP3 @"MP3"
+ (void) createMP3ToDocumentMP3File:(NSString *)mp3Name{
    
    //先判断mp3文件夹是否存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathDocument = [pathList lastObject];
    
    NSString *mp3File = [pathDocument stringByAppendingPathComponent:DOCUMENTS_AUDIO_MP3];
    
    BOOL isMP3There = [self isFileThere:mp3File];
    
    NSString *mp3DirectryPath = [pathDocument stringByAppendingPathComponent:DOCUMENTS_AUDIO_MP3];
    
    if (!isMP3There) {
        //创建文件夹
        [fileManager createDirectoryAtPath:mp3DirectryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    //写入文件到 mp3 文件夹下
    
    NSString *name = [NSString stringWithFormat:@"%@%@",mp3Name,@".mp3"];
    
    NSString *filePath = [mp3DirectryPath stringByAppendingPathComponent:name];
    [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    
}
















@end



















