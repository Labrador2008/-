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
    self.FrequencyBtn.tag = FREQUENCY_TEST;
    self.BlockFrequencyBtn.tag = BLOCKFREQUENCY_TEST;
    self.CumulativeSumsBtn.tag = CUMULATIVESUM_TEST;
    self.RunsBtn.tag = RUNS_TEST;
    self.LongestRunBtn.tag =LONGERSRUN_TEST;
    self.SerialBtn.tag = SERIAL_TEST;
    self.ApproximateEntropyBtn.tag = APPROXIMATEENTROPY_TEST;
    self.UniversalStaticalBtn.tag = UNIVERSALSTATICAL_TEST;
    self.OverlappingTemplateMatchingBtn.tag = OVERLAPPINGTEMPLATEMATCHING_TEST;
    self.NonOverlappingTemplateMatchingBtn.tag = NONOVERLAPPINGTEMPLATEMATCHING_TEST;
    self.RanksBtn.tag = RANKS_TEST;
    self.LinearComplexityBtn.tag = LINEARCOMPLEXITY_TEST;
    self.RandomExcursionsBtn.tag = RANDOMEXCURSIONS_TEST;
    self.RandomExcursionVariantBtn.tag = RANDOMEXCURSIONVARIANT_TEST;
    self.DFTBtn.tag = DFT_TEST;
    
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
    //[self setRepresentedObject:self.allBtnAry];
    
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
        return;
    }
    
    self.testFileURL = self.dragFilePathControl.URL;
    
        
   
    //依次计算每段的数据的随机性
    //FILE_PART_COUNT
    for (int n = 0; n < 1; n++)
    {
    
        //获取第n段要测试的数据
        NSData *mTestData = [FileMethod divisionFileWithPath:self.testFileURL];
        DLog(@"test data length: %lu", (unsigned long)mTestData.length);
        
        if (!mTestData)
        {
            DLog(@"test data wrong");
            //弹窗
            return;
        }
        
        //epsilon = (unsigned char *)[mTestData bytes];
        //循环测试 测试条目数组 中的所有内容
        for (int i = 0; i < self.selectedItemAry.count; i++)
        {
            //获取数组中的条目
            NSNumber *mTestItemNum = [self.selectedItemAry objectAtIndex:i];
            CalculatorMethod *test = [[CalculatorMethod alloc] init];
            BOOL isOK = [test startCalculatorWithData:mTestData andItemNum:mTestItemNum];
            
            if (isOK)
            {
                DLog(@"calculator wrong");
                //弹窗
                
                break;
            }
            
            
            //更新显示的状态栏
            dispatch_async(dispatch_get_main_queue(), ^{
                self.stateLabel.stringValue = [NSString stringWithFormat:@"第%d个数据块，第%d个测试条目", n, i+1];
                
             
                
                
            });
        }
    
    }
    
    DLog(@"test finish");
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
