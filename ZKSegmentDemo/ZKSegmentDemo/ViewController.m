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
//    _ZKSegment = [ZKSegment zk_segmentWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45) style:ZKSegmentLineStyle];
    _ZKSegment = [[ZKSegment alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45)];
    [_ZKSegment zk_setItemDefaultColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1]];
    [_ZKSegment zk_setItemSelectedColor:[UIColor colorWithRed:202 / 255.0 green:51 / 255.0 blue:54 / 255.0 alpha:1]];
    [_ZKSegment zk_setBackgroundColor:[UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1]];
    
    _ZKSegment.zk_itemClickBlock = ^(NSString *itemName, NSInteger itemIndex) {
        NSLog(@"click item:%@", itemName);
        NSLog(@"click itemIndex:%d", (int)itemIndex);
    };
    [_ZKSegment zk_setItems:@[ @"菜单1", @"菜单2" ]];
    
    [self.view addSubview:_ZKSegment];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    self.navigationItem.rightBarButtonItem = add;
    UIBarButtonItem *sub = [[UIBarButtonItem alloc] initWithTitle:@"-" style:UIBarButtonItemStylePlain target:self action:@selector(sub:)];
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:add, sub, nil];
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
