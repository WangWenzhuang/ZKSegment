//
//  ZKSegment.m
//  ZKSegment
//
//  Created by WangWenzhuang on 15/10/20.
//  Copyright © 2015年 WangWenzhuang. All rights reserved.
//

#import "ZKSegment.h"

#define ZK_UIColorFromRGBAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define ZK_ItemFontSize 14.0f
#define ZK_ItemMargin 20.0f
#define ZK_ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ZKSegment()
{
    UIColor *_itemDefaultColor;
    UIColor *_itemSelectedColor;
    UIColor *_backgroundColor;
    UIView *_buttonLine;
    CGFloat _maxWidth;
    NSMutableArray *_buttonList;
    NSMutableArray *_items;
    UIButton *_buttonSelected;
    NSInteger _selectedIndex;
    NSString *_selectedItem;
}

@end

@implementation ZKSegment

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
    _itemDefaultColor=ZK_UIColorFromRGBAlpha(102.0f,102.0f,102.0f, 1.0f);
    _itemSelectedColor=ZK_UIColorFromRGBAlpha(202.0f, 51.0f, 54.0f, 1.0f);
    _backgroundColor=ZK_UIColorFromRGBAlpha(238.0f, 238.0f, 238.0f, 1.0f);
    _maxWidth=ZK_ItemMargin;
    _buttonList=[[NSMutableArray alloc] init];
    _items=[[NSMutableArray alloc]init];
    self.bounces = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    _selectedIndex=-1;
    _buttonLine=[[UIView alloc]initWithFrame:CGRectMake(ZK_ItemMargin,self.frame.size.height-2,0,2)];
    _buttonLine.backgroundColor=_itemSelectedColor;
    [self addSubview:_buttonLine];
    
}

#pragma 暴露给外部的
-(void)zk_setItemDefaultColor:(UIColor *)itemColor
{
    _itemDefaultColor=itemColor;
}

-(void)zk_setItemSelectedColor:(UIColor *)itemSelectedColor
{
    _itemSelectedColor=itemSelectedColor;
    _buttonLine.backgroundColor=_itemSelectedColor;
}

-(void)zk_setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor=backgroundColor;
}

-(void)zk_setItems:(NSArray *)items
{
    if(!items||items.count==0){
        return;
    }
    for (int i=0; i<self.subviews.count; i++) {
        if(self.subviews[i]!=_buttonLine){
            [self.subviews[i--] removeFromSuperview];
        }
    }
    _buttonLine.hidden=NO;
    _maxWidth=ZK_ItemMargin;
    _items=[[NSMutableArray alloc] initWithArray:items];
    _buttonList=nil;
    _buttonList=[[NSMutableArray alloc] init];
    _buttonSelected=nil;
    _selectedItem=nil;
    _selectedIndex=-1;
    if(_items&&_items.count>0){
        self.backgroundColor = _backgroundColor;
        for (int i=0; i<_items.count; i++) {
            [self createItem:_items[i]];
        }
        self.contentSize = CGSizeMake(_maxWidth,-4);
        [self fiexButtonWidth];
    }
}

-(NSArray *)zk_items
{
    return _items;
}

-(void)zk_itemClickByIndex:(NSInteger)index
{
    UIButton *item = (UIButton *)_buttonList[index];
    [self itemClick:item];
}

-(NSInteger)zk_selectedItemIndex
{
    return _selectedIndex;
}

-(NSString *)zk_selectedItem
{
    return _selectedItem;
}

-(void)zk_addItem:(NSString *)item
{
    if(_buttonList.count==0){
        _buttonLine.hidden=NO;
    }
    [_items addObject:item];
    [self createItem:item];
    [self resetButtonsFrame];
    [self fiexButtonWidth];
}

-(void)zk_removeItemAtIndex:(NSInteger)index
{
    if(_items.count==0||index<0||index>=_items.count){
        return;
    }
    [_items removeObjectAtIndex:index];
    UIButton *button=_buttonList[index];
    [_buttonList removeObjectAtIndex:index];
    for (int i=0; i<self.subviews.count; i++) {
        if(self.subviews[i]==button){
            [self.subviews[i] removeFromSuperview];
        }
    }
    if(button==_buttonSelected&&_buttonList.count>0){
        NSInteger _index=index;
        if(_buttonList.count>=index&&index>0){
            _index=index-1;
        }
        [self itemClick:_buttonList[_index]];
        _selectedIndex=_index;
        _selectedItem=_buttonSelected.titleLabel.text;
    }
    if(_buttonList.count==0){
        _buttonSelected=nil;
        _selectedIndex=-1;
        _selectedItem=nil;
        _buttonLine.hidden=YES;
    }
    [self resetButtonsFrame];
    [self fiexButtonWidth];
}

-(void)zk_removeItem:(NSString *)item
{
    if(_items.count==0||![_items containsObject:item]){
        return;
    }
    for (NSInteger i=0; i<_items.count; i++) {
        if ([_items[i] isEqualToString:item]) {
            [self zk_removeItemAtIndex:i];
            return;
        }
    }
}

#pragma 私有的
-(void)fiexButtonWidth
{
    if (ZK_ScreenWidth-_maxWidth>20) {
        CGFloat bigButtonSumWidth=0;
        int bigButtonCount=0;
        _maxWidth=ZK_ItemMargin;
        CGFloat width=(ZK_ScreenWidth-(_buttonList.count+1)*ZK_ItemMargin)/_buttonList.count;
        for (int i=0; i<_buttonList.count; i++) {
            UIButton *button=_buttonList[i];
            if (button.frame.size.width>width) {
                bigButtonCount++;
                bigButtonSumWidth+=button.frame.size.width;
            }
        }
        width=(ZK_ScreenWidth-(_buttonList.count+1)*ZK_ItemMargin-bigButtonSumWidth)/(_buttonList.count-bigButtonCount);
        for (int i=0; i<_buttonList.count; i++) {
            UIButton *button=_buttonList[i];
            if (button.frame.size.width<width) {
                button.frame=CGRectMake(_maxWidth, 0, width, self.frame.size.height);
                _maxWidth+=width+ZK_ItemMargin;
            }else{
                button.frame=CGRectMake(_maxWidth, 0, button.frame.size.width, self.frame.size.height);
                _maxWidth+=button.frame.size.width+ZK_ItemMargin;
            }
            if(button==_buttonSelected){
                _buttonLine.frame=CGRectMake(_maxWidth, self.frame.size.height-2,button.frame.size.width,2);
            }
        }
        self.contentSize = CGSizeMake(_maxWidth,-4);
    }
}

-(void)resetButtonsFrame
{
    _maxWidth=ZK_ItemMargin;
    
    for (int i=0; i<_items.count; i++) {
        CGFloat width=[self textWidthWithFontSize:ZK_ItemFontSize Text:_items[i]];
        UIButton *button=_buttonList[i];
        button.frame=CGRectMake(_maxWidth, 0, width, self.frame.size.height);
        if(button==_buttonSelected){
            _buttonLine.frame=CGRectMake(_maxWidth, self.frame.size.height-2,width,2);
        }
        if (!_buttonSelected) {
            [button setTitleColor:_itemSelectedColor forState:0];
            [self itemClick:button];
        }
        _maxWidth+=width+ZK_ItemMargin;
    }
    
    self.contentSize = CGSizeMake(_maxWidth,-4);
}

-(void)createItem:(NSString *)item
{
    CGFloat itemWidth=[self textWidthWithFontSize:ZK_ItemFontSize Text:item];
    UIButton *buttonItem=[[UIButton alloc]initWithFrame:CGRectMake(_maxWidth, 0, itemWidth, self.frame.size.height)];
    buttonItem.titleLabel.font=[UIFont systemFontOfSize:ZK_ItemFontSize];
    [buttonItem setTitle:item forState:UIControlStateNormal];
    [buttonItem setTitleColor:_itemDefaultColor forState:UIControlStateNormal];
    [buttonItem addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    _maxWidth+=itemWidth+ZK_ItemMargin;
    [_buttonList addObject:buttonItem];
    if (!_buttonSelected) {
        [buttonItem setTitleColor:_itemSelectedColor forState:0];
        _buttonLine.frame  = CGRectMake(buttonItem.frame.origin.x, self.frame.size.height-2, buttonItem.frame.size.width, 2);
        [self itemClick:buttonItem];
    }
    [self addSubview:buttonItem];
}

-(void)itemClick:(id)sender
{
    UIButton *button=sender;
    if (_buttonSelected != button) {
        [_buttonSelected setTitleColor:_itemDefaultColor forState:0];
        [button setTitleColor:_itemSelectedColor forState:0];
        _buttonSelected = button;
        if (self.zk_itemClickBlock) {
            _selectedIndex=[self indexOfItemsWithItem:button.titleLabel.text];
            _selectedItem=button.titleLabel.text;
            self.zk_itemClickBlock(_selectedItem,_selectedIndex);
        }
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _buttonLine.frame  = CGRectMake(button.frame.origin.x, self.frame.size.height-2, button.frame.size.width, 2);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                CGFloat buttonX=button.frame.origin.x;
                CGFloat buttonWidth=button.frame.size.width;
                CGFloat scrollerWidth=self.contentSize.width;
                // 移动到中间
                if(scrollerWidth>ZK_ScreenWidth&&                                       //Scroller的宽度大于屏幕宽度
                   buttonX>ZK_ScreenWidth/2.0f-buttonWidth/2.0f&&                       //按钮的坐标大于屏幕中间位置
                   scrollerWidth>buttonX+ZK_ScreenWidth/2.0f+buttonWidth/2.0f           //Scroller的宽度大于按钮移动到中间坐标加上屏幕一半宽度加上按钮一半宽度
                   ){
                    self.contentOffset = CGPointMake(button.frame.origin.x - ZK_ScreenWidth/2.0f+button.frame.size.width/2.0f, 0);
                }else if(buttonX<ZK_ScreenWidth/2.0f-buttonWidth/2.0f){                 // 移动到开始
                    self.contentOffset=CGPointMake(0, 0);
                }else if (scrollerWidth-buttonX<ZK_ScreenWidth/2.0f+buttonWidth/2.0f||                   // Scroller的宽度减去按钮的坐标小于屏幕的一半，移动到最后
                          buttonX+buttonWidth+ZK_ItemMargin==scrollerWidth){
                    if(scrollerWidth>ZK_ScreenWidth){
                        self.contentOffset = CGPointMake(scrollerWidth-ZK_ScreenWidth, 0);  // 移动到末尾
                    }
                }
            }];
        }];
    }
}

-(NSInteger)indexOfItemsWithItem:(NSString *)item
{
    for (int i =0; i < _items.count; i++) {
        if ([item isEqualToString:_items[i]]) {
            return i;
        }
    }
    return -1;
}

-(CGFloat)textWidthWithFontSize:(CGFloat)fontSize Text:(NSString *)text
{
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    CGRect size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height)
                                     options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attr
                                     context:nil];
    return size.size.width;
}

@end
