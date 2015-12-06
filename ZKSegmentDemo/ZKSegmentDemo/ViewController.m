//
//  ViewController.m
//  ZKSegmentDemo
//
//  Created by 王文壮 on 15/11/9.
//  Copyright © 2015年 WangWenzhuang. All rights reserved.
//

#import "ViewController.h"
#import "ZKSegment.h"
#import "SelectStyleViewController.h"

@interface ViewController ()

@property (nonatomic, strong)ZKSegment *segment;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZKSegment";
    
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = returnButtonItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UIBarButtonItem *styleButton=[[UIBarButtonItem alloc]initWithTitle:@"样式" style:UIBarButtonItemStylePlain  target:self action:@selector(styleAction:)];
    self.navigationItem.rightBarButtonItem=styleButton;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 25)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor colorWithRed:150 / 255.0 green:150 / 255.0 blue:150 / 255.0 alpha:1]];
    [self.view addSubview:label];
    
    self.segment = [ZKSegment zk_segmentWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45) style:ZKSegmentLineStyle];
    [self.segment zk_setItemDefaultColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1]];
    [self.segment zk_setItemSelectedColor:[UIColor colorWithRed:202 / 255.0 green:51 / 255.0 blue:54 / 255.0 alpha:1]];
    [self.segment zk_setItemStyleSelectedColor:[UIColor colorWithRed:202 / 255.0 green:51 / 255.0 blue:54 / 255.0 alpha:1]];
    [self.segment zk_setBackgroundColor:[UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1]];
    
    self.segment.zk_itemClickBlock = ^(NSString *itemName, NSInteger itemIndex) {
        [label setText:[NSString stringWithFormat:@"选中项：%@，下标：%d", itemName, (int)itemIndex]];
        NSLog(@"click item:%@", itemName);
        NSLog(@"click itemIndex:%d", (int)itemIndex);
    };
    [self.segment zk_setItems:@[ @"菜单1", @"菜单2" ]];
    [self.view addSubview:self.segment];
    
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addButton setTitle:@"添加一项" forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.4]];
    [addButton setTintColor:[UIColor whiteColor]];
    [addButton setFrame:CGRectMake(10, self.segment.frame.origin.y + 100, self.view.frame.size.width - 20, 46)];
    [addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    UIButton * subButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [subButton setTitle:@"移除一项" forState:UIControlStateNormal];
    [subButton setBackgroundColor:[UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.4]];
    [subButton setTintColor:[UIColor whiteColor]];
    [subButton setFrame:CGRectMake(addButton.frame.origin.x, addButton.frame.origin.y + addButton.frame.size.height + 20, addButton.frame.size.width, addButton.frame.size.height)];
    [subButton addTarget:self action:@selector(subAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subButton];
    
    UILabel *labelVersion = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 25)];
    [labelVersion setTextAlignment:NSTextAlignmentCenter];
    [labelVersion setTextColor:[UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1]];
    [labelVersion setText:[NSString stringWithFormat:@"版本：%@", [self.segment zk_version]]];
    [self.view addSubview:labelVersion];
}

- (void)addAction:(id)sender {
    [self.segment zk_addItem:[NSString stringWithFormat:@"菜单%d", (int)[self.segment zk_items].count + 1]];
}

- (void)subAction:(id)sender {
    if ([self.segment zk_selectedItemIndex] > -1) {
        [self.segment zk_removeItemAtIndex:[self.segment zk_selectedItemIndex]];
    }
}

- (void)styleAction:(id)sender {
    SelectStyleViewController *selectStyleViewController = [[SelectStyleViewController alloc] initWithStyle:UITableViewStylePlain];
    selectStyleViewController.selectSegmentStyleNumber = [NSNumber numberWithInt:1];
    [self.navigationController pushViewController:selectStyleViewController animated:YES];
}

@end
