//
//  ViewController.swift
//  Demo
//
//  Created by 王文壮 on 2018/3/22.
//  Copyright © 2018年 王文壮. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview({
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
            return segment
        }())
        
        self.view.addSubview({
            let segment = ZKSegment.segmentRectangle(
                frame: CGRect(x: 0, y: 115, width: self.view.frame.size.width, height: 45),
                itemColor: UIColor(red: 102.0 / 255.0, green: 102.0 / 255.0, blue: 102.0 / 255.0, alpha: 1),
                itemSelectedColor: .white,
                itemStyleSelectedColor: UIColor(red: 202.0 / 255.0, green: 51.0 / 255.0, blue: 54.0 / 255.0, alpha: 1),
                itemFont: nil,
                itemMargin: 10,
                items: ["菜单一", "菜单二", "菜单三", "菜单四", "菜单五", "菜单六", "菜单七", "菜单八"],
                change: { (index, item) in
                    print("segmentRectangle change index:\(index)")
                })
            segment.backgroundColor = UIColor(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 238.0 / 255.0, alpha: 1)
            return segment
        }())
        
        self.view.addSubview({
            let segment = ZKSegment.segmentText(
                frame: CGRect(x: 0, y: 180, width: self.view.frame.size.width, height: 45),
                itemColor: UIColor(red: 102.0 / 255.0, green: 102.0 / 255.0, blue: 102.0 / 255.0, alpha: 1),
                itemSelectedColor: UIColor(red: 202.0 / 255.0, green: 51.0 / 255.0, blue: 54.0 / 255.0, alpha: 1),
                itemFont: nil,
                itemMargin: 20,
                items: ["菜单一", "菜单二", "菜单三", "菜单四", "菜单五", "菜单六", "菜单七", "菜单八"],
                change: { (index, item) in
                    print("segmentText change index:\(index)")
                })
            segment.backgroundColor = UIColor(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 238.0 / 255.0, alpha: 1)
            return segment
            }())
        
        self.view.addSubview({
            let segment = ZKSegment.segmentDot(
                frame: CGRect(x: 0, y: 245, width: self.view.frame.size.width, height: 45),
                itemColor: UIColor(red: 102.0 / 255.0, green: 102.0 / 255.0, blue: 102.0 / 255.0, alpha: 1),
                itemSelectedColor: UIColor(red: 202.0 / 255.0, green: 51.0 / 255.0, blue: 54.0 / 255.0, alpha: 1),
                itemFont: UIFont.systemFont(ofSize: 14),
                itemMargin: 20,
                items: ["菜单一", "菜单二", "菜单三", "菜单四", "菜单五", "菜单六", "菜单七", "菜单八"],
                change: { (index, item) in
                    print("segmentLine change index:\(index)")
            })
            segment.backgroundColor = UIColor(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 238.0 / 255.0, alpha: 1)
            return segment
            }())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

