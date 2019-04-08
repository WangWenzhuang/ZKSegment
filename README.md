![(logo)](https://raw.githubusercontent.com/WangWenzhuang/ZKSegment/master/logo.png)

# ZKSegment

![license](https://img.shields.io/badge/license-MIT-brightgreen.svg)
![CocoaPods](https://img.shields.io/badge/pod-v3.1-brightgreen.svg)
![platform](https://img.shields.io/badge/platform-iOS-brightgreen.svg)

ZKSegment 一个分段选择控件

![1](https://raw.githubusercontent.com/WangWenzhuang/ZKSegment/master/demo.jpg)

> 如果您是*Objective-C*项目，请使用*1.0.3*版本，[请点击](https://github.com/WangWenzhuang/ZKSegment/blob/master/objc.md)

## 运行环境

* iOS 10.0 +
* Swift 4.2 +

## 安装

### CocoaPods

你可以使用 [CocoaPods](http://cocoapods.org/) 安装 `ZKSegment`，在你的 `Podfile` 中添加：

```ogdl
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
    pod 'ZKSegment'
end
```

### 手动安装

拖动 `ZKSegment` 文件夹到您的项目

## 快速使用

### 导入 `ZKSegment`

```swift
import ZKSegment
```

### 初始化函数

* segmentLine           线形样式
* segmentRectangle      矩形样式
* segmentText           纯文本样式
* segmentDot            点样式

### 举个例子

```swift
let segment = ZKSegment.segmentLine(
    frame: CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: 45),
    itemColor: UIColor(red: 102.0 / 255.0, green: 102.0 / 255.0, blue: 102.0 / 255.0, alpha: 1),
    itemSelectedColor: UIColor(red: 202.0 / 255.0, green: 51.0 / 255.0, blue: 54.0 / 255.0, alpha: 1),
    itemFont: UIFont.systemFont(ofSize: 14),
    itemMargin: 20,
    items: ["菜单一", "菜单二", "菜单三", "菜单四", "菜单五", "菜单六", "菜单七", "菜单八"],
    change: { (index, item) in
        print("segmentLine change index:\(index)")
    })
segment.backgroundColor = UIColor(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 238.0 / 255.0, alpha: 1)
```
