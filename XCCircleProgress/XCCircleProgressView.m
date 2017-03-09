//
//  XCCircleProgressView.m
//  XCCirleProgressViewExample
//
//  Created by 樊小聪 on 2017/3/9.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：自定义圆形进度圈 🐾
 */


#import "XCCircleProgressView.h"

#define SELF_WIDTH      self.bounds.size.width
#define SELF_HEIGHT     self.bounds.size.height

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


/* 🐖 ***************************** 🐖 XCCircleProgressConfigure 🐖 *****************************  🐖 */

@implementation XCCircleProgressConfigure
+ (instancetype)defaultConfigure
{
    XCCircleProgressConfigure *configure = [[XCCircleProgressConfigure alloc] init];
    
    /*⏰ ----- 此处设置一些默认参数 ----- ⏰*/
    configure.numberStyle = XCCircleProgressNumberStyleNumber;
    configure.lineStyle   = XCCircleProgressLineStyleSoild;
    configure.startAngle  = -90;
    configure.endAngle    = 270;
    configure.lineWidth   = 5;
    configure.duration    = 2;
    configure.bgColor     = [UIColor blackColor];
    configure.strokeColor = [UIColor orangeColor];
    configure.closewise   = YES;
    
    configure.graduationNumber = 60;
    configure.graduationWidth  = 6;
    
    return configure;
}
@end


/* 🐖 ***************************** 🐖 XCCircleProgressView 🐖 *****************************  🐖 */


@interface XCCircleProgressView ()

/** 👀 参数配置选项 👀 */
@property (strong, nonatomic) XCCircleProgressConfigure *configure;

/// 填充图层
@property (assign, nonatomic) CAShapeLayer *strokeLayer;
/// 背景图层
@property (assign, nonatomic) CAShapeLayer *backgroundLayer;

@end


@implementation XCCircleProgressView
{
    // 虚线样式
    CGFloat _lineDashPhase;
    NSArray *_lineDashPattern;
}

#pragma mark - 🔒 👀 Privite Method 👀

/**
    设置 UI
 */
- (void)setupUI
{
    /*⏰ ----- 添加 numberLabel ----- ⏰*/
    UICountingLabel *numberLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(0, 0, 100.0, 50.0)];
    _numberLabel = numberLabel;
    [_numberLabel setTextAlignment:NSTextAlignmentCenter];
    [_numberLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [_numberLabel setTextColor:[UIColor grayColor]];
    [_numberLabel setBackgroundColor:[UIColor clearColor]];
    [_numberLabel setCenter:CGPointMake(SELF_WIDTH * 0.5, SELF_HEIGHT * 0.5)];
    _numberLabel.method = UILabelCountingMethodEaseInOut;
    [self addSubview:_numberLabel];
    
    /// 设置数字显示的样式
    switch (self.configure.numberStyle)
    {
        case XCCircleProgressNumberStyleNone:
        {
            self.numberLabel.hidden = YES;
            self.numberLabel.format = @"";
            break;
        }
        case XCCircleProgressNumberStyleNumber:
        {
            self.numberLabel.format = @"%d";
            break;
        }
        case XCCircleProgressNumberStylePercent:
        {
            self.numberLabel.format = @"%d%%";
            break;
        }
        case XCCircleProgressNumberStyleDecimal:
        {
            self.numberLabel.format = @"%.1f";
            break;
        }
    }
    
    
    /*⏰ ----- 设置图层 ----- ⏰*/
    CGPoint circleCenter = CGPointMake(SELF_WIDTH * 0.5, SELF_HEIGHT * 0.5);
    CGFloat circleRadius = (MIN(SELF_WIDTH, SELF_HEIGHT) - self.configure.lineWidth) * 0.5;
    
    /// 添加路径
    UIBezierPath *bizerPath = [UIBezierPath bezierPathWithArcCenter:circleCenter
                                                             radius:circleRadius
                                                         startAngle:DEGREES_TO_RADIANS(self.configure.startAngle)
                                                           endAngle:DEGREES_TO_RADIANS(self.configure.endAngle)
                                                          clockwise:self.configure.isClosewise];
    
    /// 添加背景图层
    CAShapeLayer *backgroundLayer    = [CAShapeLayer layer];
    self.backgroundLayer             = backgroundLayer;
    self.backgroundLayer.path        = bizerPath.CGPath;
    self.backgroundLayer.lineWidth   = self.configure.lineWidth;
    self.backgroundLayer.fillColor   = [UIColor clearColor].CGColor;
    self.backgroundLayer.strokeColor = self.configure.bgColor.CGColor;
    self.backgroundLayer.strokeEnd   = 1;
    
    /// 添加填充图层
    CAShapeLayer *strokeLayer    = [CAShapeLayer layer];
    self.strokeLayer             = strokeLayer;
    self.strokeLayer.path        = bizerPath.CGPath;
    self.strokeLayer.lineWidth   = self.configure.lineWidth;
    self.strokeLayer.fillColor   = [UIColor clearColor].CGColor;
    self.strokeLayer.strokeColor = self.configure.strokeColor.CGColor;
    
    /// 设置虚线 实线
    switch (self.configure.lineStyle)
    {
        case XCCircleProgressLineStyleSoild:    // 实线
        {
            self.strokeLayer.lineCap     = kCALineCapRound;
            self.backgroundLayer.lineCap = kCALineCapRound;
            break;
        }
        case XCCircleProgressLineStyleDashed:   // 虚线
        {
            // 周长：
            double perimeter = (SELF_WIDTH - self.configure.lineWidth) * M_PI;
            
            CGFloat graduationNumber = self.configure.graduationNumber;
            CGFloat graduationWidth  = self.configure.graduationWidth;
            
            // 每个刻度间的空格间距
            double spaceMargin = perimeter / graduationNumber - graduationWidth;
            
            double lineDashPhase    = -graduationWidth * 0.5;
            NSArray *lineDashPattern = @[@(graduationWidth), @(spaceMargin)];
            
            _lineDashPhase   = lineDashPhase;
            _lineDashPattern = lineDashPattern;
            
            self.strokeLayer.lineCap             = kCALineCapButt;
            self.strokeLayer.lineDashPhase       = lineDashPhase;
            self.strokeLayer.lineDashPattern     = lineDashPattern;
            self.backgroundLayer.lineCap         = kCALineCapButt;
            self.backgroundLayer.lineDashPhase   = lineDashPhase;
            self.backgroundLayer.lineDashPattern = lineDashPattern;
            break;
        }
    }
    
    /// 添加图层
    [self.layer addSublayer:self.backgroundLayer];
    [self.layer addSublayer:self.strokeLayer];
}

#pragma mark - 👀 Setter Method 👀 💤

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.strokeLayer.strokeEnd = progress;
    
    // 开始更新进度
    [self startStroke];
}

#pragma mark - 🔒 👀 Privite Method 👀

/**
    开始执行动画
 */
- (void)startStroke
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anim.duration = self.configure.duration;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = @0;
    anim.toValue   = @(self.progress);
    [self.strokeLayer addAnimation:anim forKey:NULL];
    [self.numberLabel countFromZeroTo:self.progress * 100 withDuration:self.configure.duration];
}

#pragma mark - 🔓 👀 Public Method 👀

/**
 返回一个圆形进度圈的视图
 
 @param frame       尺寸
 @param configure   参数配置(如果传空, 则为默认参数)
 */
- (instancetype)initWithFrame:(CGRect)frame
                    configure:(XCCircleProgressConfigure *)configure
{
    if (self = [super initWithFrame:frame])
    {
        self.configure = configure ?: [XCCircleProgressConfigure defaultConfigure];
        // 设置 UI
        [self setupUI];
    }
    
    return self;
}


/**
 返回一个圆形进度圈的视图
 
 @param frame       尺寸
 @param configure   参数配置(如果传空, 则为默认参数)
 */
+ (instancetype)circleProgressViewWithFrame:(CGRect)frame
                                  configure:(XCCircleProgressConfigure *)configure
{
    return [[self alloc] initWithFrame:frame configure:configure];
}

@end



























