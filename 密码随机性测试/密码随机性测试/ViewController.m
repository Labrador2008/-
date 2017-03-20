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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dragFilePathControl.pathStyle = NSPathStylePopUp;
    
    TestItem testItem;
    TestItem.FrequenceTest = 1;
    

    // Do anonatomic, ny additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}




@end
