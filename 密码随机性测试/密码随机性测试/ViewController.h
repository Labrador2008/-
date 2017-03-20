//
//  ViewController.h
//  密码随机性测试
//
//  Created by Lucky_Lay on 17/3/18.
//  Copyright © 2017年 Lay. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

//存储待测试文件的路径
@property (strong, nonatomic) NSString *testFilePath;
//文件路径选择控件
@property (weak) IBOutlet NSPathControl *dragFilePathControl;

//记录要测试的条目
@property (strong, nonatomic) NSMutableArray *selectedItemAry;


@end

