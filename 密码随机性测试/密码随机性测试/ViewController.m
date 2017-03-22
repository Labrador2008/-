//
//  ViewController.m
//  密码随机性测试
//
//  Created by Lucky_Lay on 17/3/18.
//  Copyright © 2017年 Lay. All rights reserved.
//

#import "ViewController.h"
#import "Global.h"



@implementation ViewController


- (NSArray *)allBtnAry
{
    if (!_allBtnAry)
    {
        _allBtnAry = @[self.FrequencyBtn, self.BlockFrequencyBtn, self.RunsBtn, self.LongestRunBtn, self.RanksBtn, self.DFTBtn, self.NonOverlappingTemplateMatchingBtn,
                       self.OverlappingTemplateMatchingBtn, self.UniversalStaticalBtn, self.LinearComplexityBtn, self.SerialBtn, self.ApproximateEntropyBtn, self.CumulativeSumsBtn,
                       self.RandomExcursionsBtn, self.RandomExcursionVariantBtn];
    }
    return _allBtnAry;
}

- (NSMutableArray *)selectedItemAry
{
    
    if (!_selectedItemAry)
    {
        _selectedItemAry = [NSMutableArray arrayWithCapacity:15];
        
        for (int i = 1; i <= 15 ; i++)
        {
            NSNumber *itemNum = [NSNumber numberWithInt:i];
            [_selectedItemAry addObject:itemNum];
        }
    }
    
    return _selectedItemAry;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置NSPathControl的格式；  
    self.dragFilePathControl.pathStyle = NSPathStylePopUp;
    

    //设置item btn的tag；
    self.FrequencyBtn.tag = 1;
    self.BlockFrequencyBtn.tag = 2;
    self.CumulativeSumsBtn.tag = 3;
    self.RunsBtn.tag = 4;
    self.LongestRunBtn.tag =5;
    self.SerialBtn.tag = 6;
    self.ApproximateEntropyBtn.tag = 7;
    self.UniversalStaticalBtn.tag = 8;
    self.OverlappingTemplateMatchingBtn.tag = 9;
    self.NonOverlappingTemplateMatchingBtn.tag = 10;
    self.RanksBtn.tag = 11;
    self.LinearComplexityBtn.tag = 12;
    self.RandomExcursionsBtn.tag = 13;
    self.RandomExcursionVariantBtn.tag = 14;
    self.DFTBtn.tag = 15;
    
    //设置全选按钮点击的次数，从0开始；
    clickSelecteAllBtnTime = 0;
    

    

    // Do anonatomic, ny additional setup after loading the view.
}

//响应单独点击一个Btn
- (IBAction)selectedItem:(NSButton *)sender
{
    NSNumber *selectedItemNum = [NSNumber numberWithInteger:sender.tag];
    if (sender.state)
    {
        [self.selectedItemAry addObject:selectedItemNum];
        DLog(@"add item : %@", selectedItemNum);
    }
    else
    {
        [self.selectedItemAry removeObject:selectedItemNum];
        DLog(@"remove item : %@", selectedItemNum);
    }
    
    //DLog(@"now the ary is \n %@", self.selectedItemAry);
    
}

//相应 全选 按钮
- (IBAction)selectedAllItem:(NSButton *)sender
{
    
    //把Btn的状态标记为选中。
    for (NSButton *btn  in self.allBtnAry)
    {
        btn.state = 1;
    }
    [self setRepresentedObject:self.allBtnAry];
    
    //清除之前的所有内容；
    [self.selectedItemAry removeAllObjects];
    
    //把所有内容都添加进去；
    for (int i = 1; i <= 15; i++)
    {
        NSString *itemNumStr = [NSString stringWithFormat:@"%d", i];
        DLog(@"itemNum %d is %@", i, itemNumStr);
        [self.selectedItemAry addObject:itemNumStr];
    }
    DLog(@"selecteTestItemAry is %@", self.selectedItemAry);

}

//相应 全不选 按钮
- (IBAction)selectedNoItem:(id)sender
{
    for (NSButton *btn in self.allBtnAry)
    {
        btn.state = 0;
    }
//    [self setRepresentedObject:self.allBtnAry];
    
    //删除说有的数组
    [self.selectedItemAry removeAllObjects];
    
}


//开始测试
- (IBAction)startTest:(id)sender
{
    //判断测试条目数组中的内容是否正确
    if (!self.selectedItemAry || self.selectedItemAry.count == 0)
    {
        DLog(@"test item wrong");
        //弹窗
    }
    
    self.testFilePath = [self.dragFilePathControl.URL absoluteString];
    
    DLog(@"test file path : %@", self.testFilePath);
    
    //判断待测试文件路径是否正确
    if (!self.testFilePath)
    {
        DLog(@"test file path wrong");
        //弹窗
    }
    
    //依次计算每段的数据的随机性
    for (int n = 0; n < FILE_PART_COUNT; n++)
    {
    
        //获取第n段要测试的数据
        NSData *mTestData = [FileMethod divisionFileWithPath:_testFilePath];
        
        if (!mTestData)
        {
            DLog(@"test data wrong");
            //弹窗
        }
        
        //循环测试 测试条目数组 中的所有内容
        for (int i = 0; i < self.selectedItemAry.count; i++)
        {
            //获取数组中的条目
            NSNumber *mTestItemNum = [self.selectedItemAry objectAtIndex:i];
            BOOL isOK = [CalculatorMethod startCalculatorWithData:mTestData andItmeNum:mTestItemNum];
            
            if (isOK)
            {
                DLog(@"calculator wrong");
                //弹窗
                
                break;
            }
        }
    
    }
}

//显示测试的结果
- (IBAction)showResults:(id)sender
{
    
}




- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}




@end
