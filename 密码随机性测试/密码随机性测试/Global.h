//
//  Global.h
//  密码随机性测试
//
//  Created by Lucky_Lay on 17/3/20.
//  Copyright © 2017年 Lay. All rights reserved.
//

#ifndef Global_h
#define Global_h


#pragma mark - Foundation
//单次测试传入的数据长度
#define PART_FILE_DATA_LENGTH (1000000 / 8)
//一个待测文件截取的段数
#define FILE_PART_COUNT 10



#pragma mark - DEBUG
#ifdef DEBUG
// 定义是输出Log
#define DLog(format, ...) NSLog(@"Line[%d] %s " format, __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__)
#else
// 定义是输出Log
#define DLog(format, ...)
#endif
// 只输出类名
#define LogClassName DLog(@"")


//测试项目
typedef NS_ENUM(NSInteger, TestItem)
{
    
    FrequenceTest,                              //频率测试
    FrequencyTestWithinBlock,                       //块内频率测试
    RunsTest,                                       //游程测试
    LongRunOfOnesInBlock,                           //块内最长游程测试
    BinaryMatrixRankTest,                           //二元矩阵秩测试
    DiscreteFourierTransformTest,                   //离散傅里叶变换测试
    NonOverlappingTemplateMatchingTest,             //非重叠模块匹配测试
    OverlappingTemplateMatchingTest,                //重叠模块匹配测试
    UniversalStaticticalTest,                       //通用测试
    LinearComplexityTest,                           //线性复杂度测试
    SerialTest,                                     //序列测试
    ApproximateEntropyTest,                         //近似熵测试
    CumulativeSumsTest,                             //累加和测试
    RandomExcursionsTest,                           //随机游动测试
    RandomExcursionsVariantTest,                    //随机游动状态频数测试
    
};

#endif /* Global_h */
