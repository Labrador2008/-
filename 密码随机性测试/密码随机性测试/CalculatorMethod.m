//
//  CalculatorMethod.m
//  密码随机性测试
//
//  Created by LuckyMan on 17/3/22.
//  Copyright © 2017年 Lay. All rights reserved.
//

#import "CalculatorMethod.h"

@implementation CalculatorMethod
+ (BOOL)startCalculatorWithData:(NSData *)data andItemNum:(NSNumber *)num
{
    BOOL isFinish = FALSE;
    
    NSInteger testItemNum = [num integerValue];
    
    switch (testItemNum)
    {
        case FREQUENCY_TEST:
            DLog(@"FREQUENCY_TEST");
            
            break;
        
        case BLOCKFREQUENCY_TEST:
            DLog(@"BLOCKFREQUENCY_TEST");
            
            break;
        
        case CUMULATIVESUM_TEST:
            DLog(@"CUMULATIVESUM_TEST");
            
            break;
        
        case RUNS_TEST:
            DLog(@"RUNS_TEST");
        
            break;
        
        case LONGERSRUN_TEST:
            DLog(@"LONGERSRUN_TEST");
            
            break;
        
        case SERIAL_TEST:
            DLog(@"SERIAL_TEST");

            break;
        
        case APPROXIMATEENTROPY_TEST:
            DLog(@"APPROXIMATEENTROPY_TEST");
            
            break;
        
        case UNIVERSALSTATICAL_TEST:
            DLog(@"UNIVERSALSTATICAL_TEST");
            
            break;
        
        case OVERLAPPINGTEMPLATEMATCHING_TEST:
            DLog(@"OVERLAPPINGTEMPLATEMATCHING_TEST");
            
            break;
        
        case NONOVERLAPPINGTEMPLATEMATCHING_TEST:
            DLog(@"NONOVERLAPPINGTEMPLATEMATCHING_TEST");

            break;
        
        case RANKS_TEST:
            DLog(@"RANKS_TEST");

            break;
        
        case LINEARCOMPLEXITY_TEST:
            DLog(@"LINEARCOMPLEXITY_TEST");
            
            break;
        
        case RANDOMEXCURSIONS_TEST:
            DLog(@"RANDOMEXCURSIONS_TEST");
            
            break;
        
        case DFT_TEST:
            DLog(@"DFT_TEST");
            
            break;
        
        case RANDOMEXCURSIONVARIANT_TEST:
            DLog(@"RANDOMEXCURSIONVARIANT_TEST");
            
            break;
        
        default:
            DLog(@"测试条目编号有错误");
            break;
    }
    
    
    
    
    return isFinish;
}

@end
