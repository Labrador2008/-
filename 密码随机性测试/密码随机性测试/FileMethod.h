//
//  FileMethod.h
//  密码随机性测试
//
//  Created by Lucky_Lay on 17/3/20.
//  Copyright © 2017年 Lay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"

//对读取的文件进行处理。


@interface FileMethod : NSObject

/*
 参数：
    path:文件路径
 返回值
    截取后的数据；
 */
+ (NSData *)divisionFileWithPath:(NSString *)path;

@end
