# ZKSegment

[![Build Status](https://img.shields.io/travis/rust-lang/rust.svg)](https://github.com/WangWenzhuang/ZKSegment)

ZKSegment 是一个分段选择控件

## 安装 ##

拷贝 `ZKSegment/` 目录下的2个文件 `ZKSegment.h` / `ZKSegment.m` 到项目里即可。

## 快速使用 ##

### Objective-C:
1. `#import "ZKSegment.h"`

```objc
_ZKSegment=[[ZKSegment alloc]initWithFrame:
            CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,45)];

_ZKSegment.zk_itemClickBlock=^(NSString *itemName , NSInteger itemIndex){
    NSLog(@"click item:%@",itemName);
    NSLog(@"click itemIndex:%d",itemIndex);
};
[_ZKSegment zk_setItems:[[NSArray alloc] initWithObjects:
                         @"菜单1",@"菜单2", nil]];

[self.view addSubview:_ZKSegment];
```

## 运行环境
- iOS 7+
- 支持 armv7/armv7s/arm64
