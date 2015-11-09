# ZKSegment

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/WangWenzhuang/ZKSegment)
[![license](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://github.com/WangWenzhuang/ZKSegment)
[![CocoaPods](https://img.shields.io/badge/pod-v1.0.1-brightgreen.svg)](https://github.com/WangWenzhuang/ZKSegment)
[![platform](https://img.shields.io/badge/platform-iOS-brightgreen.svg)](https://github.com/WangWenzhuang/ZKSegment)
[![platform](https://img.shields.io/badge/contact-1020304029%40q.com-brightgreen.svg)](https://github.com/WangWenzhuang/ZKSegment)

ZKSegment 是一个分段选择控件

## 安装 ##

### 手动安装 ###

拷贝 `ZKSegment/` 目录下的2个文件 `ZKSegment.h` / `ZKSegment.m` 到项目里即可。

### CocoaPods ###

```pod 'ZKSegment'```

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
