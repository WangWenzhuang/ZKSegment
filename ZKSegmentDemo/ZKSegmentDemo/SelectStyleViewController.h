//
//  SelectStyleViewController.h
//  ZKSegmentDemo
//
//  Created by 王文壮 on 15/12/6.
//  Copyright © 2015年 WangWenzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKSegment.h"

@class SelectStyleViewController;

@protocol SelectStyleViewControllerDelegate

- (void)SelectStyleViewController:(SelectStyleViewController *)selectStyleViewController didSelectSegmentStyle:(ZKSegmentStyle)segmentStyle;

@end

@interface SelectStyleViewController : UITableViewController

@property(weak, nonatomic) id<SelectStyleViewControllerDelegate> delegate;
@property (nonatomic, assign) ZKSegmentStyle selectSegmentStyle;

@end
