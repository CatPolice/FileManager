//
//  FileManager.m
//  CreateFile
//
//  Created by gavin on 15/6/9.
//  Copyright (c) 2015年 gavin. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

/**
 *  获取应用沙盒的根路径
 */
- (NSString *)dirHome{
    NSString *dirHome = NSHomeDirectory();
    return dirHome;
}

/*
 获取Documents目录路径
 */
- (NSString *)dirDoc{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = path[0];
    return documentDirectory;
}

/*
 获取Library目录路径
 */
- (NSString *)dirLib{
    //在根目录下找Library目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *librayDirectory = path[0];
    return librayDirectory;
}

/*
 获取Cache目录路径
 */
- (NSString *)dirCache{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = path[0];
    return cachePath;
}


/**
 *  获取Tmp目录路径
 */

- (NSString *)dirTmp{
    NSString *tmpDirectory = NSTemporaryDirectory();
    return tmpDirectory;
}

/**
 *  获取Preference目录路径
 */

- (void)dirPerference{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES);
    NSString *preferencePath = path[0];
    NSLog(@"app_home_lib_preference:%@",preferencePath);
    //该目录下没有文件夹
    
}


#pragma mark createdir
#pragma mark ==========================================================================================================

/**
 * Documents目录下创建新文件夹underDocuments
 */

- (void)createDir{
    NSString *testDirectory = [[self dirDoc]stringByAppendingPathComponent:@"underDocuments"];
    BOOL res = [[NSFileManager defaultManager]createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"创建文件夹成功");
        NSLog(@"%@",testDirectory);
    }else{
        NSLog(@"创建文件夹失败");
    }
}


/**
 *  NSHomeDirectory()/Library/Caches下创建新文件夹
 */

- (void)createDirUnderCaches{
    NSString *directoryUnderCache = [[self dirCache]stringByAppendingPathComponent:@"underCaches"];
    BOOL res = [[NSFileManager defaultManager]createDirectoryAtPath:directoryUnderCache withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"创建文件夹成功");
        NSLog(@"%@",directoryUnderCache);
    }else{
        NSLog(@"创建文件夹失败");
    }
}

#pragma mark - Write Data to File
#pragma mark ==========================================================================================================
/**
 *  写数据到Documents目录下新创建的文件夹underDocuments
 */

- (void)writeFileToUnderDocuments{
    //获取underDocuments文件夹目录的路径
    NSString *underDocumentsPath = [[self dirDoc]stringByAppendingPathComponent:@"underDocuments"];
    NSString *filePath = [underDocumentsPath stringByAppendingPathComponent:@"underDocumentsFile.txt"];
    NSString *writeContent = @"要写入的数据";
    BOOL res = [writeContent writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"数据写入成功");
        NSLog(@"filePath:%@",filePath);
    }else{
        NSLog(@"数据写入失败");
    }
}


/**
 *  写数据到Library/Caches目录下新创建的文件夹underCaches
 */
- (void)writeFileToUnderCaches{
    NSString *underCachesPath = [[self dirCache]stringByAppendingPathComponent:@"underCaches"];
    NSString *filePath = [underCachesPath stringByAppendingPathComponent:@"cachesFile.txt"];
    NSString *writeContent = @"要写入的数据";
    BOOL res = [writeContent writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"数据写入成功");
        NSLog(@"CachesfilePath:%@",filePath);
    }else{
        NSLog(@"数据写入失败");
    }
}

#pragma mark - read file data
#pragma mark ==========================================================================================================

/**
 *  读取写入underDocuments文件夹下的文件
 */
- (void)readFileUnderDocuments{
    //根据写入documents的路径读取文件
    NSString *underDocumentsPath = [[self dirDoc]stringByAppendingPathComponent:@"underDocuments"];
    NSString *filePath = [underDocumentsPath stringByAppendingPathComponent:@"underDocumentsFile.txt"];
    
    NSString *writeContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"underDocuments文件读取成功 %@",writeContent);
}

/**
 *  读取写入underCaches文件夹下的文件
 */
- (void)readFileUnderCaches{
    //根据写入documents的路径读取文件
    NSString *underCachesPath = [[self dirCache]stringByAppendingPathComponent:@"underCaches"];
    NSString *filePath = [underCachesPath stringByAppendingPathComponent:@"cachesFile.txt"];
    
    NSString *writeContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"underCaches文件读取成功 %@",writeContent);
}

#pragma mark - 删除文件
#pragma mark ==========================================================================================================

/**
 *  删除underDocuments文件夹下得文件
 *  删除之前判断该路径下是否存在文件
 */
- (void)deleteUnderDocumentsFile{
    
    NSString *underDocumentsPath = [[self dirDoc]stringByAppendingPathComponent:@"underDocuments"];
    NSString *filePath = [underDocumentsPath stringByAppendingPathComponent:@"underDocumentsFile.exe"];
    
    NSFileManager *manger = [NSFileManager defaultManager];
    if ([manger fileExistsAtPath:filePath]) {
        [manger removeItemAtPath:filePath error:nil];
        
        NSLog(@"文件是否存在:%@",[manger isExecutableFileAtPath:filePath]?@"YES":@"NO");
    }else{
        NSLog(@"");
    }
    
}


/**
 *  删除underCaches文件夹下得文件
 *  删除之前判断该路径下是否存在文件
 */
- (void)deleteUnderCachesFile{
    NSString *underCachesPath = [[self dirCache]stringByAppendingPathComponent:@"underCaches"];
    NSString *filePath = [underCachesPath stringByAppendingPathComponent:@"cachesFile.txt"];
    NSFileManager *manger = [NSFileManager defaultManager];
    if ([manger fileExistsAtPath:filePath]) {
        [manger removeItemAtPath:filePath error:nil];
        NSLog(@"文件是否存在:%@",[manger isExecutableFileAtPath:filePath]?@"YES":@"NO");
    }else{
        NSLog(@"该路径下不存在文件");
    }
}

/**
 *  删除underDocument文件夹
 */
- (void)deleteUnderDocument{
    NSString *underDocPath = [[self dirDoc]stringByAppendingPathComponent:@"underDocuments"];
    NSFileManager *manger = [NSFileManager defaultManager];
    if ([manger fileExistsAtPath:underDocPath]) {
        [manger removeItemAtPath:underDocPath error:nil];
        BOOL isExit = [manger isExecutableFileAtPath:underDocPath];
        NSLog(@"文件夹是否存在%d",isExit);
    }else{
        NSLog(@"不存在该文件夹®");
    }
}




#pragma mark - 文件属性
#pragma mark ==========================================================================================================

/**
 *  获取文件属性
 */
-(void)fileAttriutes{
    
    NSString *testDirectory = [[self dirDoc] stringByAppendingPathComponent:@"underDocuments"];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"underDocumentsFile.txt"];
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:testPath error:nil];
    id key, value;
    NSArray *keys = [fileAttributes allKeys];
    int count = (int)[keys count];
    for (int i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [fileAttributes objectForKey: key];
        NSLog (@"Key: %@ for value: %@", key, value);
    }
}


#pragma mark other
#pragma mark ==========================================================================================================

/*
 判断文件是否存在
 */

- (BOOL) isFileThere:(NSString *)filePath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    
    BOOL isDirExist = [fileManager fileExistsAtPath:filePath
                                        isDirectory:&isDir];
    
    return isDirExist;
}


/*
 判断文件夹是否存在，如果不存在就创建该文件夹
 */
- (void) isFileThereWithCreateFile:(NSString *)filePath{
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
- (void) createMP3ToDocumentMP3File:(NSString *)mp3Name{
    
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



