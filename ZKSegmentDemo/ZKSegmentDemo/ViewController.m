//
//  ViewController.m
//  ZKSegmentDemo
//
//  Created by 王文壮 on 15/11/9.
//  Copyright © 2015年 WangWenzhuang. All rights reserved.
//

#import "ViewController.h"
#import "ZKSegment.h"

@interface ViewController () {
    ZKSegment *_ZKSegment;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZKSegment";
    
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 25)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor colorWithRed:150 / 255.0 green:150 / 255.0 blue:150 / 255.0 alpha:1]];
    [self.view addSubview:label];
    
    _ZKSegment = [ZKSegment zk_segmentWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45) style:ZKSegmentRectangleStyle];
    [_ZKSegment zk_setItemDefaultColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1]];
    [_ZKSegment zk_setItemSelectedColor:[UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1]];
    [_ZKSegment zk_setItemStyleSelectedColor:[UIColor colorWithRed:202 / 255.0 green:51 / 255.0 blue:54 / 255.0 alpha:1]];
    [_ZKSegment zk_setBackgroundColor:[UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1]];
    
    _ZKSegment.zk_itemClickBlock = ^(NSString *itemName, NSInteger itemIndex) {
        [label setText:[NSString stringWithFormat:@"选中项：%@，下标：%d", itemName, (int)itemIndex]];
        NSLog(@"click item:%@", itemName);
        NSLog(@"click itemIndex:%d", (int)itemIndex);
    };
    [_ZKSegment zk_setItems:@[ @"菜单1", @"菜单2" ]];
    [self.view addSubview:_ZKSegment];
    
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addButton setTitle:@"添加一项" forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.4]];
    [addButton setTintColor:[UIColor whiteColor]];
    [addButton setFrame:CGRectMake(10, _ZKSegment.frame.origin.y + 100, self.view.frame.size.width - 20, 46)];
    [addButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    UIButton * subButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [subButton setTitle:@"移除一项" forState:UIControlStateNormal];
    [subButton setBackgroundColor:[UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.4]];
    [subButton setTintColor:[UIColor whiteColor]];
    [subButton setFrame:CGRectMake(addButton.frame.origin.x, addButton.frame.origin.y + addButton.frame.size.height + 20, addButton.frame.size.width, addButton.frame.size.height)];
    [subButton addTarget:self action:@selector(sub:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subButton];
}

- (void)add:(id)sender {
    [_ZKSegment zk_addItem:[NSString stringWithFormat:@"菜单%d", (int)[_ZKSegment zk_items].count + 1]];
}

- (void)sub:(id)sender {
    if ([_ZKSegment zk_selectedItemIndex] > -1) {
        [_ZKSegment zk_removeItemAtIndex:[_ZKSegment zk_selectedItemIndex]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
