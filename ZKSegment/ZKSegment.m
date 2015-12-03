//
//  ZKSegment.m
//  ZKSegment
//
//  Created by WangWenzhuang on 15/10/20.
//  Copyright © 2015年 WangWenzhuang. All rights reserved.
//

#import "ZKSegment.h"
#import "ZKSegmentLine.h"

#define ZK_UIColorFromRGBAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define ZK_ItemFontSize 14.0f
#define ZK_ItemMargin 20.0f
#define ZK_ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ZKSegment()
@property(nonatomic, strong) UIColor *itemDefaultColor;
@property(nonatomic, strong) UIColor *itemSelectedColor;
@property(nonatomic, strong) UIView *buttonLine;
@property(nonatomic, assign) CGFloat maxWidth;
@property(nonatomic, strong) NSMutableArray *buttonList;
@property(nonatomic, strong) NSMutableArray *allItems;
@property(nonatomic, weak) UIButton *buttonSelected;
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, strong) NSString *selectedItem;
@end

@implementation ZKSegment

+(ZKSegment *) zk_segmentWithFrame:(CGRect)frame style:(ZKSegmentStyle)style {
    ZKSegment *segment;
    switch (style) {
        case ZKSegmentLineStyle:
            segment = [[ZKSegmentLine alloc] initWithFrame:frame];
            break;
    }
    return segment;
}

#pragma 初始化
-(id)init
{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    if ([super initWithCoder:coder]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.itemDefaultColor = ZK_UIColorFromRGBAlpha(102.0f, 102.0f, 102.0f, 1.0f);
    self.itemSelectedColor = ZK_UIColorFromRGBAlpha(202.0f, 51.0f, 54.0f, 1.0f);
    self.backgroundColor = ZK_UIColorFromRGBAlpha(238.0f, 238.0f, 238.0f, 1.0f);
    self.maxWidth = ZK_ItemMargin;
    self.buttonList = [NSMutableArray array];
    self.allItems = [NSMutableArray array];
    self.bounces = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.selectedIndex = -1;
    self.buttonLine = [[UIView alloc]initWithFrame:CGRectMake(ZK_ItemMargin, self.frame.size.height-2, 0, 2)];
    self.buttonLine.backgroundColor = self.itemSelectedColor;
    [self addSubview:self.buttonLine];
    
}

#pragma 暴露给外部的
- (void)zk_setItemDefaultColor:(UIColor *)color {
    self.itemDefaultColor = color;
}

- (void)zk_setItemSelectedColor:(UIColor *)color {
    self.itemSelectedColor = color;
    self.buttonLine.backgroundColor = self.itemSelectedColor;
}

- (void)zk_setBackgroundColor:(UIColor *)color {
    self.backgroundColor = color;
}

- (void)zk_setItems:(NSArray *)items {
    if (!items || items.count == 0) {
        return;
    }
    for (int i = 0; i < self.subviews.count; i++) {
        if (self.subviews[i] != self.buttonLine) {
            [self.subviews[i--] removeFromSuperview];
        }
    }
    self.buttonLine.hidden = NO;
    self.maxWidth = ZK_ItemMargin;
    [self.allItems removeAllObjects];
    [self.allItems addObjectsFromArray:items];
    self.buttonList = nil;
    self.buttonList = [[NSMutableArray alloc] init];
    self.buttonSelected = nil;
    self.selectedItem = nil;
    self.selectedIndex = -1;
    if (self.allItems && self.allItems.count > 0) {
        self.backgroundColor = self.backgroundColor;
        for (int i = 0; i < self.allItems.count; i++) {
            [self createItem:self.allItems[i]];
        }
        self.contentSize = CGSizeMake(self.maxWidth, -4);
        [self fiexButtonWidth];
    }
}

- (NSArray *)zk_items {
    return self.allItems;
}

- (void)zk_itemClickByIndex:(NSInteger)index {
    if (index < 0) {
        return;
    }
    UIButton *item = (UIButton *)self.buttonList[index];
    [self itemClick:item];
}

- (NSInteger)zk_selectedItemIndex {
    return self.selectedIndex;
}

- (NSString *)zk_selectedItem {
    return self.selectedItem;
}

- (void)zk_addItem:(NSString *)item {
    if (self.buttonList.count == 0) {
        self.buttonLine.hidden = NO;
    }
    [self.allItems addObject:item];
    [self createItem:item];
    [self resetButtonsFrame];
    [self fiexButtonWidth];
}

- (void)zk_removeItemAtIndex:(NSInteger)index {
    if (self.allItems.count == 0 || index < 0 || index >= self.allItems.count) {
        return;
    }
    [self.allItems removeObjectAtIndex:index];
    UIButton *button = self.buttonList[index];
    [self.buttonList removeObjectAtIndex:index];
    for (int i = 0; i < self.subviews.count; i++) {
        if (self.subviews[i] == button) {
            [self.subviews[i] removeFromSuperview];
        }
    }
    if (button == self.buttonSelected && self.buttonList.count > 0) {
        NSInteger _index = index;
        if (self.buttonList.count >= index && index > 0) {
            _index = index - 1;
        }
        [self itemClick:self.buttonList[_index]];
        self.selectedIndex = _index;
        self.selectedItem = self.buttonSelected.titleLabel.text;
    }
    if (self.buttonList.count == 0) {
        self.buttonSelected = nil;
        self.selectedIndex = -1;
        self.selectedItem = nil;
        self.buttonLine.hidden = YES;
    }
    [self resetButtonsFrame];
    [self fiexButtonWidth];
}

- (void)zk_removeItem:(NSString *)item {
    if (self.allItems.count == 0 || ![self.allItems containsObject:item]) {
        return;
    }
    for (NSInteger i = 0; i < self.allItems.count; i++) {
        if ([self.allItems[i] isEqualToString:item]) {
            [self zk_removeItemAtIndex:i];
            return;
        }
    }
}

#pragma 私有的
- (void)fiexButtonWidth {
    if (ZK_ScreenWidth - self.maxWidth > 20) {
        CGFloat bigButtonSumWidth = 0;
        int bigButtonCount = 0;
        self.maxWidth = ZK_ItemMargin;
        CGFloat width = (ZK_ScreenWidth - (self.buttonList.count + 1) * ZK_ItemMargin) / self.buttonList.count;
        for (int i = 0; i < self.buttonList.count; i++) {
            UIButton *button = self.buttonList[i];
            if (button.frame.size.width > width) {
                bigButtonCount++;
                bigButtonSumWidth += button.frame.size.width;
            }
        }
        width = (ZK_ScreenWidth - (self.buttonList.count + 1) * ZK_ItemMargin - bigButtonSumWidth) / (self.buttonList.count - bigButtonCount);
        for (int i = 0; i < self.buttonList.count; i++) {
            UIButton *button = self.buttonList[i];
            if (button.frame.size.width < width) {
                button.frame = CGRectMake(self.maxWidth, 0, width, self.frame.size.height);
                self.maxWidth += width + ZK_ItemMargin;
            } else {
                button.frame = CGRectMake(self.maxWidth, 0, button.frame.size.width,
                                          self.frame.size.height);
                self.maxWidth += button.frame.size.width + ZK_ItemMargin;
            }
            if (button == self.buttonSelected) {
                self.buttonLine.frame = CGRectMake(button.frame.origin.x, self.frame.size.height - 2, button.frame.size.width, 2);
            }
        }
        self.contentSize = CGSizeMake(self.maxWidth, -4);
    }
}

- (void)resetButtonsFrame {
    self.maxWidth = ZK_ItemMargin;
    
    for (int i = 0; i < self.allItems.count; i++) {
        CGFloat width = [self textWidthWithFontSize:ZK_ItemFontSize Text:self.allItems[i]];
        UIButton *button = self.buttonList[i];
        button.frame = CGRectMake(self.maxWidth, 0, width, self.frame.size.height);
        if (button == self.buttonSelected) {
            self.buttonLine.frame = CGRectMake(self.maxWidth, self.frame.size.height - 2, width, 2);
        }
        if (!self.buttonSelected) {
            [button setTitleColor:self.itemSelectedColor forState:0];
            [self itemClick:button];
        }
        self.maxWidth += width + ZK_ItemMargin;
    }
    
    self.contentSize = CGSizeMake(self.maxWidth, -4);
}

- (void)createItem:(NSString *)item {
    CGFloat itemWidth = [self textWidthWithFontSize:ZK_ItemFontSize Text:item];
    UIButton *buttonItem = [[UIButton alloc] initWithFrame:CGRectMake(self.maxWidth, 0, itemWidth, self.frame.size.height)];
    buttonItem.titleLabel.font = [UIFont systemFontOfSize:ZK_ItemFontSize];
    [buttonItem setTitle:item forState:UIControlStateNormal];
    [buttonItem setTitleColor:self.itemDefaultColor forState:UIControlStateNormal];
    [buttonItem addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    self.maxWidth += itemWidth + ZK_ItemMargin;
    [self.buttonList addObject:buttonItem];
    [self addSubview:buttonItem];
    if (!self.buttonSelected) {
        [buttonItem setTitleColor:self.itemSelectedColor forState:0];
        self.buttonLine.frame = CGRectMake(buttonItem.frame.origin.x, self.frame.size.height - 2, buttonItem.frame.size.width, 2);
        [self itemClick:buttonItem];
    }
}

- (void)itemClick:(id)sender {
    UIButton *button = sender;
    if (self.buttonSelected != button) {
        [self.buttonSelected setTitleColor:self.itemDefaultColor forState:0];
        [button setTitleColor:self.itemSelectedColor forState:0];
        self.buttonSelected = button;
        if (self.zk_itemClickBlock) {
            self.selectedIndex = [self indexOfItemsWithItem:button.titleLabel.text];
            self.selectedItem = button.titleLabel.text;
            self.zk_itemClickBlock(self.selectedItem, self.selectedIndex);
        }
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.buttonLine.frame = CGRectMake(button.frame.origin.x, self.frame.size.height - 2, button.frame.size.width, 2);
                             
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:
                              0.3 animations:^{
                                  CGFloat buttonX = button.frame.origin.x;
                                  CGFloat buttonWidth = button.frame.size.width;
                                  CGFloat scrollerWidth = self.contentSize.width;
                                  // 移动到中间
                                  if (scrollerWidth > ZK_ScreenWidth && // Scroller的宽度大于屏幕宽度
                                      buttonX > ZK_ScreenWidth / 2.0f - buttonWidth / 2.0f && //按钮的坐标大于屏幕中间位置
                                      scrollerWidth > buttonX + ZK_ScreenWidth / 2.0f + buttonWidth / 2.0f // Scroller的宽度大于按钮移动到中间坐标加上屏幕一半宽度加上按钮一半宽度
                                      ) {
                                      self.contentOffset = CGPointMake(button.frame.origin.x - ZK_ScreenWidth / 2.0f + button.frame.size.width / 2.0f, 0);
                                  } else if (buttonX < ZK_ScreenWidth / 2.0f - buttonWidth / 2.0f) { // 移动到开始
                                      self.contentOffset = CGPointMake(0, 0);
                                  } else if (scrollerWidth - buttonX < ZK_ScreenWidth / 2.0f + buttonWidth / 2.0f || // Scroller的宽度减去按钮的坐标小于屏幕的一半，移动到最后
                                             buttonX + buttonWidth + ZK_ItemMargin == scrollerWidth) {
                                      if (scrollerWidth > ZK_ScreenWidth) {
                                          self.contentOffset = CGPointMake(scrollerWidth - ZK_ScreenWidth, 0); // 移动到末尾
                                      }
                                  }
                              }];
                         }];
    }
}

- (NSInteger)indexOfItemsWithItem:(NSString *)item {
    for (int i = 0; i < self.allItems.count; i++) {
        if ([item isEqualToString:self.allItems[i]]) {
            return i;
        }
    }
    return -1;
}

- (CGFloat)textWidthWithFontSize:(CGFloat)fontSize Text:(NSString *)text {
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    CGRect size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    return size.size.width;
}

@end
