//
//  ZKSegment.swift
//  Demo
//
//  Created by 王文壮 on 2018/3/22.
//  Copyright © 2018年 王文壮. All rights reserved.
//

import UIKit

//MARK: 样式，默认：line
enum ZKSegmentStyle {
    case line
    case rectangle
    case text
    case dot
}

typealias Style = ZKSegmentStyle

public typealias ZKItemChange = ((_ index: Int, _ text: String) -> Void)

public extension ZKSegment {
    //MARK: 创建 .line 样式实例
    public static func segmentLine(frame: CGRect,
                                   itemColor: UIColor,
                                   itemSelectedColor: UIColor,
                                   itemFont: UIFont?,
                                   itemMargin: CGFloat?,
                                   items: [String] = [],
                                   change: ZKItemChange?) -> ZKSegment{
        return ZKSegment(
            frame: frame,
            style: .line,
            itemColor: itemColor,
            itemSelectedColor: itemSelectedColor,
            itemStyleSelectedColor: itemSelectedColor,
            itemFont: itemFont,
            itemMargin: itemMargin,
            items: items,
            change: change)
    }
    //MARK: 创建 .rectangle 样式实例
    public static func segmentRectangle(frame: CGRect,
                                        itemColor: UIColor,
                                        itemSelectedColor: UIColor,
                                        itemStyleSelectedColor: UIColor,
                                        itemFont: UIFont?,
                                        itemMargin: CGFloat?,
                                        items: [String] = [],
                                        change: ZKItemChange?) -> ZKSegment{
        return ZKSegment(
            frame: frame,
            style: .rectangle,
            itemColor: itemColor,
            itemSelectedColor: itemSelectedColor,
            itemStyleSelectedColor: itemStyleSelectedColor,
            itemFont: itemFont,
            itemMargin: itemMargin,
            items: items,
            change: change)
    }
    //MARK: 创建 .text 样式实例
    public static func segmentText(frame: CGRect,
                                   itemColor: UIColor,
                                   itemSelectedColor: UIColor,
                                   itemFont: UIFont?,
                                   itemMargin: CGFloat?,
                                   items: [String] = [],
                                   change: ZKItemChange?) -> ZKSegment{
        return ZKSegment(
            frame: frame,
            style: .text,
            itemColor: itemColor,
            itemSelectedColor: itemSelectedColor,
            itemStyleSelectedColor: .clear,
            itemFont: itemFont,
            itemMargin: itemMargin,
            items: items,
            change: change)
    }
    //MARK: 创建 .dot 样式实例
    public static func segmentDot(frame: CGRect,
                                   itemColor: UIColor,
                                   itemSelectedColor: UIColor,
                                   itemFont: UIFont?,
                                   itemMargin: CGFloat?,
                                   items: [String] = [],
                                   change: ZKItemChange?) -> ZKSegment{
        return ZKSegment(
            frame: frame,
            style: .dot,
            itemColor: itemColor,
            itemSelectedColor: itemSelectedColor,
            itemStyleSelectedColor: itemSelectedColor,
            itemFont: itemFont,
            itemMargin: itemMargin,
            items: items,
            change: change)
    }
}

public class ZKSegment: UIScrollView {
    //MARK: 获取当前选中项索引
    public var selectedIndex: Int? {
        get {
            if self.buttonSelected != nil {
                if let index = self.items.index(where: { $0 == self.buttonSelected?.titleLabel?.text }) {
                    return index
                }
            }
            return nil
        }
    }
    //MARK: 获取当前选中项
    public var selectedItem: String? {
        get {
            if self.buttonSelected != nil {
                return self.buttonSelected?.titleLabel?.text
            }
            return nil
        }
    }
    
    //MARK: 项更改事件
    private var itemChange: ZKItemChange?
    //MARK: 每一项颜色
    private var itemColor: UIColor!
    //MARK: 选中项颜色
    private var itemSelectedColor: UIColor!
    //MARK: 选中项样式颜色
    private var itemStyleSelectedColor: UIColor!
    //MARK: 每一项字体
    private var itemFont: UIFont!
    //MARK: 每一项间距
    private var itemMargin: CGFloat = 20
    //MAKR: 样式
    private var style: Style = .line
    
    private var buttons: [UIButton] = []
    private var buttonSelected: UIButton?
    
    private var itemStyle: UIView!
    private var itemStyleY: CGFloat = 0
    private var itemStyleHeight: CGFloat = 0
    
    //MARK: .rectangle 样式圆角属性
    private let itemRectangleStyleCornerRadius: CGFloat = 6
    //MARK: .rectangle 样式每项内间距
    private let itemRectangleStylePadding: CGFloat = 8
    
    private var contentX: CGFloat = 0
    
    private var items: [String] = []
    
    private init(frame: CGRect,
                 style: Style,
                 itemColor: UIColor,
                 itemSelectedColor: UIColor,
                 itemStyleSelectedColor: UIColor,
                 itemFont: UIFont?,
                 itemMargin: CGFloat?,
                 items: [String],
                 change: ZKItemChange?) {
        
        super.init(frame: frame)
        self.style = style
        self.itemColor = itemColor
        self.itemSelectedColor = itemSelectedColor
        self.itemStyleSelectedColor = itemStyleSelectedColor
        self.itemFont = itemFont ?? UIFont.systemFont(ofSize: 14)
        self.itemMargin = itemMargin ?? self.itemMargin
        self.itemChange = change
        
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        
        self.itemStyle = UIView()
        self.itemStyle.backgroundColor = self.itemStyleSelectedColor
        
        switch style {
        case .line:
            self.itemStyleY = self.height - 2
            self.itemStyleHeight = 2
        case .rectangle:
            self.itemStyleY = self.itemRectangleStylePadding
            self.itemStyleHeight = self.height - self.itemStyleY * 2
            self.itemStyle.layer.cornerRadius = self.itemRectangleStyleCornerRadius
            self.itemStyle.layer.masksToBounds = true
        case .text:
            self.itemStyleY = 0
            self.itemStyleHeight = 0
        case .dot:
            self.itemStyleY = self.height - 10
            self.itemStyleHeight = 4
            self.itemStyle.layer.cornerRadius = 2
            self.itemStyle.layer.masksToBounds = true
        }
        self.reload(items)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension ZKSegment {
    //MARK: 重新加载
    public func reload(_ items: [String]) {
        self.items = items
        self.buttons.removeAll()
        self.subviews.forEach({ $0.removeFromSuperview() })
        self.itemStyle.isHidden = false
        self.contentX = self.itemMargin
        self.addSubview(self.itemStyle)
        buttonSelected = nil
        self.items.forEach({ self.createItem($0) })
        self.contentSize = CGSize(width: self.contentX, height: -4)
        self.fiexItems()
    }
    //MARK: 根据索引选中
    public func select(_ index: Int) {
        if index >= 0 {
            self.itemClick(button: self.buttons[index])
        }
    }
    //MARK: 添加一项
    public func add(_ item: String, isSelected: Bool = false) {
        if self.itemStyle.isHidden {
            self.itemStyle.isHidden = false
        }
        self.items.append(item)
        self.createItem(item)
        self.resetitemsFrame()
        self.fiexItems()
    }
    //MARK: 移除一项
    public func remove(_ index: Int) {
        if index < 0 || index > self.items.count - 1 {
            print("ZKSegment ->>>>>> error: remove 方法索引不对")
            return
        }
        self.items.remove(at: index)
        let button = self.buttons[index]
        self.buttons.remove(at: index)
        button.removeFromSuperview()
        if button == self.buttonSelected && self.buttons.count > 0 {
            var itemIndex = index
            if self.buttons.count >= index && index > 0 {
                itemIndex = index - 1
            }
            self.itemClick(button: self.buttons[itemIndex])
        }
        if self.buttons.count == 0 {
            self.buttonSelected = nil
            self.itemStyle.isHidden = true
        }
        self.resetitemsFrame()
        self.fiexItems()
    }
}

extension ZKSegment {
    private func itemStyleFrame(_ x: CGFloat, _ width: CGFloat) -> CGRect {
        var styleX = x
        var styleWidth = width
        if self.style == .dot {
            styleWidth = 12
            styleX = x + (width - styleWidth) / 2
        }
        return CGRect(
            x: styleX,
            y: self.itemStyleY,
            width: styleWidth,
            height: self.itemStyleHeight
        )
    }
    
    private func createItem(_ item: String) {
        let itemWidth = self.itemWidth(item)
        let button = UIButton(frame: CGRect(x: self.contentX, y: 0, width: itemWidth, height: self.height))
        button.titleLabel?.font = self.itemFont
        button.setTitle(item, for: .normal)
        button.setTitleColor(self.itemColor, for: .normal)
        button.addTarget(self, action: #selector(ZKSegment.itemClick(button:)), for: .touchUpInside)
        self.contentX += (itemWidth + self.itemMargin)
        self.buttons.append(button)
        self.addSubview(button)
        if self.buttonSelected == nil {
            button.setTitleColor(self.itemSelectedColor, for: .normal)
            self.itemStyle.frame = self.itemStyleFrame(button.x, button.width)
            self.itemClick(button: button)
        }
    }
    
    @objc private func itemClick(button: UIButton) {
        if self.buttonSelected != button {
            if self.buttonSelected != nil {
                self.buttonSelected?.setTitleColor(self.itemColor, for: .normal)
            }
            button.setTitleColor(self.itemSelectedColor, for: .normal)
            self.buttonSelected = button
            if let change = self.itemChange {
                change(self.selectedIndex ?? -1, self.selectedItem ?? "")
            }
            self.animateChage(button)
        }
    }
    
    private func animateChage(_ button: UIButton) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: UIViewAnimationOptions.curveEaseOut,
            animations: {
                self.itemStyle.frame = self.itemStyleFrame(button.x, button.width)
        }, completion: { finished in
            UIView.animate(withDuration: 0.3, animations: {
                //MARK: 移动到中间
                if self.contentSize.width > self.width &&                                               // 内容宽度大于控件宽度
                    button.x > self.width / 2 - button.width / 2 &&                                     // 按钮的坐标大于屏幕中间位置
                    self.contentSize.width > button.x + self.width / 2 + button.width / 2 {             //内容的宽度大于按钮移动到中间坐标加上屏幕一半宽度加上按钮一半宽度
                    self.contentOffset = CGPoint(
                        x: button.x - self.width / 2 + button.width / 2,
                        y: 0)
                } else if button.x < self.width / 2 - button.width / 2 {                                // 移动到开始
                    self.contentOffset = CGPoint(x: 0, y: 0)
                } else if self.contentSize.width - button.x < self.width / 2 + button.width / 2 ||      // 内容宽度减去按钮的坐标小于屏幕的一半，移动到最后
                    button.x + button.width + self.itemMargin == self.contentSize.width {
                    if self.contentSize.width > self.width {
                        self.contentOffset = CGPoint(x: self.contentSize.width - self.width, y: 0)      // 移动到末尾
                    }
                }
            })
        })
    }
    //MARK: 根据样式获取项宽度
    private func itemWidth(_ item: String) -> CGFloat {
        let itemWidth = item.size(self.itemFont).width
        switch self.style {
        case .line,
             .text,
             .dot:
            return itemWidth
        case .rectangle:
            return itemWidth + self.itemMargin * 2
        }
    }
    //MARK: 如果内容宽度小于控件宽度，居中显示
    private func fiexItems() {
        if (self.width - self.contentX > self.itemMargin) {
            var bigItemSumWidth: CGFloat = 0
            var bigItemCount: CGFloat = 0
            self.contentX = self.itemMargin
            // 计算平均每项宽度
            var itemWidth = (self.width - (CGFloat(self.buttons.count) + 1) * self.itemMargin) / CGFloat(self.buttons.count)
            // 检查是否有超过平均宽度的项
            self.buttons.forEach({ button in
                if button.width > itemWidth {
                    bigItemCount += 1
                    bigItemSumWidth += button.width
                }
            })
            // 减去超过平均宽度项的宽度总和，重新计算剩余项的宽度
            itemWidth = (self.width - (CGFloat(self.buttons.count) + 1) * self.itemMargin - bigItemSumWidth) / (CGFloat(self.buttons.count) - bigItemCount)
            // 重新布局
            self.buttons.forEach({ button in
                // 如果小于平均宽度，设置为平均宽度
                if button.width < itemWidth {
                    button.frame = CGRect(x: self.contentX, y: 0, width: itemWidth, height: self.height)
                    self.contentX += (itemWidth + self.itemMargin)
                } else {
                    button.frame = CGRect(x: self.contentX, y: 0, width: button.width, height: self.height);
                    self.contentX += (button.width + self.itemMargin)
                }
                if button == self.buttonSelected {
                    self.itemStyle.frame = self.itemStyleFrame(button.x, button.width)
                }
            })
            self.contentSize = CGSize(width: self.contentX, height: -4)
        }
    }
    //MARK: 重置所有项 frame，如果调用了 fiexItems 可能按钮被拉伸了宽度，
    //      所以如果变更了项，需要重置一下所有项的 width
    private func resetitemsFrame() {
        self.contentX = self.itemMargin
        
        for index in 0...self.items.count - 1 {
            let itemWidth = self.itemWidth(self.items[index])
            let button = self.buttons[index]
            button.frame = CGRect(x: self.contentX, y: 0, width: itemWidth, height: self.height)
            if button == self.buttonSelected {
                self.itemStyle.frame = self.itemStyleFrame(self.contentX, itemWidth)
            }
            if self.buttonSelected == nil {
                button.setTitleColor(self.itemSelectedColor, for: .normal)
                self.itemClick(button: button)
            }
            self.contentX += (itemWidth + self.itemMargin)
        }
        self.contentSize = CGSize(width: self.contentX, height: -4)
    }
}

extension String {
    func size(_ font: UIFont) -> CGSize {
        let attribute = [ NSAttributedStringKey.font: font ]
        let conten = NSString(string: self)
        return conten.boundingRect(
            with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: attribute,
            context: nil
            ).size
    }
}

extension UIView {
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
    }
}
