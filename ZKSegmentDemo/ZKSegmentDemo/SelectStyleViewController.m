//
//  SelectStyleViewController.m
//  ZKSegmentDemo
//
//  Created by 王文壮 on 15/12/6.
//  Copyright © 2015年 WangWenzhuang. All rights reserved.
//

#import "SelectStyleViewController.h"

@interface SelectStyleViewController ()
@property (nonatomic, strong)NSDictionary *styles;
@end

@implementation SelectStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择样式";
    self.tableView.separatorColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1];
    self.tableView.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];

    self.styles = @{
      @"ZKSegmentLineStyle" : [NSNumber numberWithInt:0],
      @"ZKSegmentRectangleStyle" : [NSNumber numberWithInt:1]
    };
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.styles.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (self.selectSegmentStyle == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.textLabel.text = self.styles.allKeys[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.delegate) {
        [self.delegate SelectStyleViewController:self didSelectSegmentStyle:(int)indexPath.row];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
