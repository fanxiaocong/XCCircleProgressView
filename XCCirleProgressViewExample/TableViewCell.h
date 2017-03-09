//
//  TableViewCell.h
//  圆形进度圈
//
//  Created by 樊小聪 on 16/6/6.
//  Copyright © 2016年 樊小聪. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XCCircleProgressView.h"

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) XCCircleProgressView *first;

@property (weak, nonatomic) XCCircleProgressView *two;

@end
