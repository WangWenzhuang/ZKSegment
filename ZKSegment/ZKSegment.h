//
//  ZKSegment.h
//  ZKSegment
//
//  Created by WangWenzhuang on 15/10/20.
//  Copyright © 2015年 WangWenzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设备支持方向
 */
typedef enum {
    /**
     *  线条样式
     */
    ZKSegmentLineStyle,
    /**
     *  矩形
     */
    ZKSegmentRectangleStyle
} ZKSegmentStyle;

@interface ZKSegment : UIScrollView

/**
 *  工厂方法，创建不同样式的选择器
 */
+(ZKSegment *) zk_segmentWithFrame:(CGRect)frame style:(ZKSegmentStyle)style;

/**
 *  项切换 Block
 */
@property(nonatomic, copy) void (^zk_itemClickBlock)(NSString *itemName, NSInteger itemIndex);
/**
 *  初始化
 */
- (id)zk_initWithFrame:(CGRect)frame style:(ZKSegmentStyle)style;
/**
 *  设置项目集合
 */
- (void)zk_setItems:(NSArray *)items;
/**
 *  获取项目集合
 */
- (NSArray *)zk_items;
/**
 *  设置每一项默认颜色
 *  默认 [r:102.0f,g:102.0f,b:102.0f]
 */
- (void)zk_setItemDefaultColor:(UIColor *)color;

/**
 *  设置选中项颜色
 *
 *  ZKSegmentLineStyle 默认[r:202.0, g:51.0, b:54.0]
 *  ZKSegmentRectangleStyle 默认[r:250.0, g:250.0, b:250.0]
 */
- (void)zk_setItemSelectedColor:(UIColor *)color;
/**
 *  设置选中项样式颜色
 *
 *  默认[r:202.0, g:51.0, b:54.0]
 */
- (void)zk_setItemStyleSelectedColor:(UIColor *)color;

/**
 *  设置背景色
 *
 *  默认[r:238.0, g:238.0, b:238.0]
 */
- (void)zk_setBackgroundColor:(UIColor *)color;

/**
 *  根据索引触发单击事件
 */
- (void)zk_itemClickByIndex:(NSInteger)index;

/**
 *  获取当前选中项索引
 */
- (NSInteger)zk_selectedItemIndex;

/**
 *  获取当前选中项
 */
- (NSString *)zk_selectedItem;

/**
 *  添加一项
 */
- (void)zk_addItem:(NSString *)item;

/**
 *  根据索引移除一项
 */
- (void)zk_removeItemAtIndex:(NSInteger)index;

/**
 *  移除指定项
 */
- (void)zk_removeItem:(NSString *)item;
@end
