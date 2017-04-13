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
    

//用来存储结果；
@property(strong, nonatomic)NSMutableDictionary *allResDic;

@end
