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

@interface ViewController () <SelectStyleViewControllerDelegate>

@property (nonatomic, strong)ZKSegment *zkSegment;
@property (nonatomic, strong)UILabel *msgLabel;
@property (nonatomic,assign)ZKSegmentStyle zkSegmentStyle;

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
    
    self.msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 25)];
    [self.msgLabel setTextAlignment:NSTextAlignmentCenter];
    [self.msgLabel setTextColor:[UIColor colorWithRed:150 / 255.0 green:150 / 255.0 blue:150 / 255.0 alpha:1]];
    [self.view addSubview:self.msgLabel];
    
    self.zkSegmentStyle = ZKSegmentLineStyle;
    [self resetSegment];
    
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addButton setTitle:@"添加一项" forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.4]];
    [addButton setTintColor:[UIColor whiteColor]];
    [addButton setFrame:CGRectMake(10, 60, self.view.frame.size.width - 20, 46)];
    [addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UIButton * subButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [subButton setTitle:@"移除一项" forState:UIControlStateNormal];
    [subButton setBackgroundColor:[UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.4]];
    [subButton setTintColor:[UIColor whiteColor]];
    [subButton setFrame:CGRectMake(addButton.frame.origin.x, addButton.frame.origin.y + addButton.frame.size.height + 20, addButton.frame.size.width, addButton.frame.size.height)];
    [subButton addTarget:self action:@selector(subAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subButton];
    
    UILabel *labelVersion = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 25)];
    [labelVersion setTextAlignment:NSTextAlignmentCenter];
    [labelVersion setTextColor:[UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1]];
    [labelVersion setText:[NSString stringWithFormat:@"版本：%@", self.zkSegment.zk_version]];
    [self.view addSubview:labelVersion];
}

- (void)resetSegment {
    if (self.zkSegment) {
        [self.zkSegment removeFromSuperview];
    }
self.zkSegment = [ZKSegment
    zk_segmentWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 45)
                  style:self.zkSegmentStyle];
    // 可手动设置各种颜色；
    // 如不设置则使用默认颜色
    self.zkSegment.zk_itemDefaultColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    switch (self.zkSegmentStyle) {
        case ZKSegmentLineStyle:
            self.zkSegment.zk_itemSelectedColor = [UIColor colorWithRed:202 / 255.0 green:51 / 255.0 blue:54 / 255.0 alpha:1];
            break;
        case ZKSegmentRectangleStyle:
            self.zkSegment.zk_itemSelectedColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
            break;
        case ZKSegmentTextStyle:
            self.zkSegment.zk_itemSelectedColor = [UIColor colorWithRed:202 / 255.0 green:51 / 255.0 blue:54 / 255.0 alpha:1];
            break;
    }
    self.zkSegment.zk_itemStyleSelectedColor = [UIColor colorWithRed:202 / 255.0 green:51 / 255.0 blue:54 / 255.0 alpha:1];
    self.zkSegment.zk_backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    __weak typeof(self) weakSelf = self;
    self.zkSegment.zk_itemClickBlock = ^(NSString *itemName, NSInteger itemIndex) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.msgLabel setText:[NSString stringWithFormat:@"选中项：%@，下标：%d", itemName, (int)itemIndex]];
    };
    [self.zkSegment zk_setItems:@[ @"菜单1", @"菜单2" ]];
    [self.view addSubview:self.zkSegment];
}

- (void)addAction:(id)sender {
    [self.zkSegment zk_addItem:[NSString stringWithFormat:@"菜单%d", (int)[self.zkSegment zk_items].count + 1]];
}

- (void)subAction:(id)sender {
    if (self.zkSegment.zk_selectedItemIndex > -1) {
        [self.zkSegment zk_removeItemAtIndex:self.zkSegment.zk_selectedItemIndex];
    }
}

- (void)styleAction:(id)sender {
    SelectStyleViewController *selectStyleViewController = [[SelectStyleViewController alloc] initWithStyle:UITableViewStylePlain];
    selectStyleViewController.selectSegmentStyle = self.zkSegmentStyle;
    selectStyleViewController.delegate = self;
    [self.navigationController pushViewController:selectStyleViewController animated:YES];
}

#pragma mark - SelectStyleViewControllerDelegate
- (void)SelectStyleViewController:(SelectStyleViewController *)selectStyleViewController didSelectSegmentStyle:(ZKSegmentStyle)segmentStyle {
    self.zkSegmentStyle = segmentStyle;
    [self resetSegment];
}

@end
