//
//  XCCircleProgressView.h
//  XCCirleProgressViewExample
//
//  Created by 樊小聪 on 2017/3/9.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：自定义圆形进度圈 🐾
 */


#import <UIKit/UIKit.h>

#import "UICountingLabel.h"


typedef NS_ENUM(NSInteger, XCCircleProgressNumberStyle)
{
    /** 👀 中间没有数字 👀 */
    XCCircleProgressNumberStyleNone = 0,
    
    /** 👀 中间是整数(0, 1, 2...) 👀 */
    XCCircleProgressNumberStyleNumber,
    
    /** 👀 中间是百分比(1%, 2%...) 👀 */
    XCCircleProgressNumberStylePercent,
    
    /** 👀 中间是小数(一个小数点, 1.1, 1.3...) 👀 */
    XCCircleProgressNumberStyleDecimal,
};

typedef NS_ENUM(NSInteger, XCCircleProgressLineStyle)
{
    /** 👀 实线 👀 */
    XCCircleProgressLineStyleSoild = 0,
    
    /** 👀 虚线 👀 */
    XCCircleProgressLineStyleDashed
};

/* 🐖 ***************************** 🐖 XCCircleProgressConfigure 🐖 *****************************  🐖 */

@interface XCCircleProgressConfigure : NSObject

/** 👀 进度圈中间文字显示的样式: 默认 XCCircleProgressNumberStyleNumber 👀 */
@property (assign, nonatomic) XCCircleProgressNumberStyle numberStyle;

/** 👀 进度圈圈环线的显示样式 👀 默认 XCCircleProgressLineStyleSoild  */
@property (assign, nonatomic) XCCircleProgressLineStyle lineStyle;

/** 👀 开始角度 默认 -90  👀 */
@property (assign, nonatomic) CGFloat startAngle;
/** 👀 结束角度 默认 279 👀 */
@property (assign, nonatomic) CGFloat endAngle;
/** 👀 进度圈的线的宽度 默认 5 👀 */
@property (assign, nonatomic) CGFloat lineWidth;
/** 👀 进度增长的时间: 默认 2 秒 👀 */
@property (assign, nonatomic) NSTimeInterval duration;
/** 👀 进度圈的背景颜色: 默认 黑色 👀 */
@property (strong, nonatomic) UIColor *bgColor;
/** 👀 进度圈的填充颜色: 默认 橙色 👀 */
@property (strong, nonatomic) UIColor *strokeColor;
/** 👀 是否是顺时针方向: 默认 YES 👀 */
@property (assign, nonatomic, getter=isClosewise) BOOL closewise;

/// 只有当 进度圈圈环线的显示样式为: XCCircleProgressLineStyleDashed 的时候有效
/** 👀 刻度总数: 默认 60 👀 */
@property (assign, nonatomic) NSUInteger graduationNumber;
/** 👀 每个刻度宽度: 默认 6 👀 */
@property (assign, nonatomic) NSUInteger graduationWidth;

/** 👀 默认配置参数(可以在此处设置一些基本参数) 👀 */
+ (instancetype)defaultConfigure;

@end

/* 🐖 ***************************** 🐖 XCCircleProgressView 🐖 *****************************  🐖 */

@interface XCCircleProgressView : UIView

/** 👀 中间显示数字的 LB 👀 */
@property (weak, nonatomic, readonly) UICountingLabel *numberLabel;

/** 👀 进度 0~1 👀 */
@property (assign, nonatomic) CGFloat progress;


/**
  返回一个圆形进度圈的视图

 @param frame       尺寸
 @param configure   参数配置(如果传空, 则为默认参数)
 */
- (instancetype)initWithFrame:(CGRect)frame
                    configure:(XCCircleProgressConfigure *)configure;


/**
 返回一个圆形进度圈的视图
 
 @param frame       尺寸
 @param configure   参数配置(如果传空, 则为默认参数)
 */
+ (instancetype)circleProgressViewWithFrame:(CGRect)frame
                                  configure:(XCCircleProgressConfigure *)configure;

@end








































