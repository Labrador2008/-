//
//  FileMethod.m
//  密码随机性测试
//
//  Created by Lucky_Lay on 17/3/20.
//  Copyright © 2017年 Lay. All rights reserved.
//

#import "FileMethod.h"

@implementation FileMethod

+ (NSData *)divisionFileWithPath:(NSURL *)url
{
    DLog(@"devied File With Path: %@", url);
    
    //获取要处理的文件数据
    
    NSData *fileData = [NSData dataWithContentsOfURL:url];
    
    if (fileData == nil || fileData.length < PART_FILE_DATA_LENGTH /8)
    {
        DLog(@"There is something Wrong With File");
    }

    //对文件进行分割。
    NSUInteger fileDataLength = [fileData length];
    
    NSUInteger startScope = fileDataLength - PART_FILE_DATA_LENGTH/8;
    
    NSUInteger startPos = arc4random() % startScope ;
    
    NSData *partData = [fileData subdataWithRange:NSMakeRange(startPos, PART_FILE_DATA_LENGTH/8)];
    
    [partData writeToFile:@"/Users/LBLD/Desktop/00.pi" atomically:YES];
    
    epsilon = (unsigned char *)[partData bytes];
    
    return partData;
}

+ (FileMethod *)sharedInstance
{
        static dispatch_once_t onceToken;
        static FileMethod * sSharedInstance;
        dispatch_once(&onceToken,^{
            sSharedInstance = [[FileMethod alloc] init];
        });
        return sSharedInstance;
}

@end
