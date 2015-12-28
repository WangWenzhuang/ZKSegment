# ZKSegment

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/WangWenzhuang/ZKSegment)
[![license](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://github.com/WangWenzhuang/ZKSegment)
[![CocoaPods](https://img.shields.io/badge/pod-v1.0.1-brightgreen.svg)](https://github.com/WangWenzhuang/ZKSegment)
[![platform](https://img.shields.io/badge/platform-iOS-brightgreen.svg)](https://github.com/WangWenzhuang/ZKSegment)
[![platform](https://img.shields.io/badge/contact-1020304029%40q.com-brightgreen.svg)](https://github.com/WangWenzhuang/ZKSegment)

ZKSegment 是一个分段选择控件

![1](https://raw.githubusercontent.com/WangWenzhuang/ZKSegment/master/1.png)

![2](https://raw.githubusercontent.com/WangWenzhuang/ZKSegment/master/2.png)

![3](https://raw.githubusercontent.com/WangWenzhuang/ZKSegment/master/3.png)

## 安装

### 手动安装

拷贝 `ZKSegment/` 目录下的2个文件 `ZKSegment.h` / `ZKSegment.m` 到项目里即可。

### CocoaPods

```pod 'ZKSegment'```

## 快速使用

### Objective-C:
`#import "ZKSegment.h"`

```objc
_ZKSegment = [ZKSegment
    zk_segmentWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 45)
                  style:ZKSegmentLineStyle];
_ZKSegment.zk_itemClickBlock=^(NSString *itemName , NSInteger itemIndex){
    NSLog(@"click item:%@",itemName);
    NSLog(@"click itemIndex:%d",itemIndex);
};
[_ZKSegment zk_setItems:@[ @"菜单1", @"菜单2" ]];

[self.view addSubview:_ZKSegment];
```

## 自定义

###属性

`zk_itemDefaultColor` 			设置每一项文本默认颜色

`zk_itemSelectedColor` 			设置每一项文本选中颜色

`zk_itemStyleSelectedColor`		选中项样式颜色

`zk_backgroundColor`			背景色

## 运行环境
- iOS 7+
- 支持 armv7/armv7s/arm64
