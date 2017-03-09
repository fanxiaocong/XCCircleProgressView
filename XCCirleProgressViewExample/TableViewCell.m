//
//  TableViewCell.m
//  圆形进度圈
//
//  Created by 樊小聪 on 16/6/6.
//  Copyright © 2016年 樊小聪. All rights reserved.
//

#import "TableViewCell.h"


@interface TableViewCell ()

@end

@implementation TableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIColor *bgColor = [UIColor colorWithRed:35/255.0 green:39/255.0 blue:48/255.0 alpha:1];
    UIColor *strokeColor = [UIColor colorWithRed:61/255.0 green:129/255.0 blue:180/255.0 alpha:1];
    
    XCCircleProgressConfigure *firstConfigure = [XCCircleProgressConfigure defaultConfigure];
    firstConfigure.bgColor = bgColor;
    firstConfigure.strokeColor = strokeColor;
    firstConfigure.lineStyle = XCCircleProgressLineStyleDashed;
    
    XCCircleProgressView *first = [XCCircleProgressView circleProgressViewWithFrame:CGRectMake(100, 100, 80, 80) configure:firstConfigure];
    
    first.numberLabel.textColor = [UIColor blueColor];
    
    self.backgroundColor = [UIColor colorWithRed:48/255.0 green:55/255.0 blue:65/255.0 alpha:1];
    
    [self.contentView addSubview:first];
    
    XCCircleProgressConfigure *configure = [XCCircleProgressConfigure defaultConfigure];
    configure.numberStyle = XCCircleProgressNumberStylePercent;
    configure.startAngle  = 0;
    configure.endAngle    = 360;
    
    XCCircleProgressView *two = [[XCCircleProgressView alloc] initWithFrame:CGRectMake(100, 400, 200, 200) configure:configure];
    
    two.numberLabel.textColor = [UIColor redColor];
    
    [self.contentView addSubview:two];
    
    
    self.first = first;
    self.two   = two;
}



@end
