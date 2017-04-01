//
//  ViewController.h
//  密码随机性测试
//
//  Created by Lucky_Lay on 17/3/18.
//  Copyright © 2017年 Lay. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
{
    int clickSelecteAllBtnTime;
}

//存储待测试文件的路径
@property (strong, nonatomic) NSURL *testFileURL;
//文件路径选择控件
@property (weak) IBOutlet NSPathControl *dragFilePathControl;

//记录要测试的条目
@property (strong, nonatomic) NSMutableArray *selectedItemAry;

//存储所有测试条目的数组
@property (strong, nonatomic) NSArray *allBtnAry;
//存储所有的btn
@property (weak) IBOutlet NSButton *allItemBtn;


//测试条目btn
@property (weak) IBOutlet NSButton *FrequencyBtn;
@property (weak) IBOutlet NSButton *BlockFrequencyBtn;
@property (weak) IBOutlet NSButton *CumulativeSumsBtn;
@property (weak) IBOutlet NSButton *RunsBtn;
@property (weak) IBOutlet NSButton *LongestRunBtn;
@property (weak) IBOutlet NSButton *SerialBtn;
@property (weak) IBOutlet NSButton *ApproximateEntropyBtn;
@property (weak) IBOutlet NSButton *UniversalStaticalBtn;
@property (weak) IBOutlet NSButton *OverlappingTemplateMatchingBtn;
@property (weak) IBOutlet NSButton *NonOverlappingTemplateMatchingBtn;
@property (weak) IBOutlet NSButton *RanksBtn;
@property (weak) IBOutlet NSButton *LinearComplexityBtn;
@property (weak) IBOutlet NSButton *RandomExcursionsBtn;
@property (weak) IBOutlet NSButton *DFTBtn;
@property (weak) IBOutlet NSButton *RandomExcursionVariantBtn;

//状态栏
@property (weak) IBOutlet NSTextField *stateLabel;




@end

