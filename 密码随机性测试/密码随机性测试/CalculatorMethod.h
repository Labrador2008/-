//
//  CalculatorMethod.h
//  密码随机性测试
//
//  Created by LuckyMan on 17/3/22.
//  Copyright © 2017年 Lay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"


@interface CalculatorMethod : NSObject
{
    //unsigned char *epsilon;
}
/*计算数据的随机性
 data：待测试数据
 num：测试条目编号
 */
- (BOOL)startCalculatorWithData:(NSData *)data andItemNum:(NSNumber *)num;

+ (CalculatorMethod *)sharedInstance;

//用来存储结果；
@property(strong, nonatomic)NSMutableDictionary *allResDic;

//用来存储每个结果成功的次数
@property (nonatomic) NSUInteger timeOfFrequencyTest;
@property (nonatomic) NSUInteger timeOfBlockFrequencyTest;
@property (nonatomic) NSUInteger timeOfRunsTest;
@property (nonatomic) NSUInteger timeOfLongRunOfOnesInBlock;
@property (nonatomic) NSUInteger timeOfBinaryMatrixRankTest;
@property (nonatomic) NSUInteger timeOfDiscreteFourierTransformTest;
@property (nonatomic) NSUInteger timeOfNonOverlappingTemplateMatchingTest;
@property (nonatomic) NSUInteger timeOfOverlappingTemplateMatchingTest;
@property (nonatomic) NSUInteger timeOfUniversalStaticticalTest;
@property (nonatomic) NSUInteger timeOfLinearComplexityTest;
@property (nonatomic) NSUInteger timeOfSerialTest;
@property (nonatomic) NSUInteger timeOfApproximateEntropyTest;
@property (nonatomic) NSUInteger timeOfCumulativeSumsTest;
@property (nonatomic) NSUInteger timeOfRandomExcursionsTest;
@property (nonatomic) NSUInteger timeOfRandomExcursionsVariantTest;



@end
