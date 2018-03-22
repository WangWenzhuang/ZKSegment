# ZKSegment

![license](https://img.shields.io/badge/license-MIT-brightgreen.svg)
![build](https://img.shields.io/badge/build-passing-brightgreen.svg)
![CocoaPods](https://img.shields.io/badge/pod-v1.0.1-brightgreen.svg)
![platform](https://img.shields.io/badge/platform-iOS-brightgreen.svg)

## 安装

### CocoaPods

你可以使用 [CocoaPods](http://cocoapods.org/) 安装 `ZKSegment`，在你的 `Podfile` 中添加：

```ogdl
platform :ios, '8.0'

target 'MyApp' do
    pod 'ZKSegment', '1.0.1'
end
```

## 快速使用

```objc
#import "ZKSegment.h"`
```

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