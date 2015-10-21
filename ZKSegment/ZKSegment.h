//
//  ZKSegment.h
//  ZKSegment
//
//  Created by WangWenzhuang on 15/10/20.
//  Copyright © 2015年 WangWenzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKSegment : UIScrollView

/**
 *  项切换 Block
 */
@property (nonatomic,copy) void(^zk_itemClickBlock)(NSString *itemName , NSInteger itemIndex);
/**
 *  设置项目集合
 */
-(void)zk_setItems:(NSArray *)items;
/**
 *  获取项目集合
 */
-(NSArray *)zk_items;
/**
 *  设置每一项默认颜色
 *  默认 [r:102.0f,g:102.0f,b:102.0f]
 */
-(void)zk_setItemDefaultColor:(UIColor *)itemColor;

/**
 *  设置选中项颜色
 *
 *  默认[r:202.0, g:51.0, b:54.0]
 */
-(void)zk_setItemSelectedColor:(UIColor *)itemSelectedColor;

/**
 *  设置背景色
 *
 *  默认[r:238.0, g:238.0, b:238.0]
 */
-(void)zk_setBackgroundColor:(UIColor *)backgroundColor;

/**
 *  根据索引触发单击事件
 */
-(void)zk_itemClickByIndex:(NSInteger)index;

/**
 *  获取当前选中项索引
 */
-(NSInteger)zk_selectedItemIndex;

/**
 *  获取当前选中项
 */
-(NSString *)zk_selectedItem;

/**
 *  添加一项
 */
-(void)zk_addItem:(NSString *)item;

/**
 *  根据索引移除一项
 */
-(void)zk_removeItemAtIndex:(NSInteger)index;

/**
 *  移除指定项
 */
-(void)zk_removeItem:(NSString *)item;
@end
