//
//  YXPChartView.h
//  YXPChartViewDemo
//
//  Created by 段龙飞 on 16/1/4.
//  Copyright © 2016年 段龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPChartPlot.h"

#import "YXPChartPointValue.h"


typedef NS_ENUM(NSInteger,YXPChartViewStyle) {
    YXPChartViewLineStyle,
    YXPChartViewBarStyle,
    YXPChartViewDefaultStyle = YXPChartViewLineStyle
    
};

@interface YXPChartView : UIView

#pragma mark - ChartView的大小以及风格样式

@property (nonatomic, assign) YXPChartViewStyle chartStyle;

@property (nonatomic, strong) UIColor * contenViewBackgroundColor;

@property (nonatomic, strong) UIColor * colorOfXAxis;

@property (nonatomic, strong) UIColor * colorOfYAxis;

@property (nonatomic, assign) UIEdgeInsets margins;

@property (nonatomic, assign) UIEdgeInsets marginsSpace;

@property (nonatomic, assign) CGFloat barSpace;

#pragma mark - 相关数据的属性Block

@property (nonatomic, assign) NSInteger (^containNumberSacalesOfOnChartViewXAxis)();

@property (nonatomic, assign) NSInteger(^numberOfPlots)();

@property (nonatomic, assign) NSInteger(^numberOfPointOnPlot)(NSInteger indexPlot);

@property (nonatomic, strong) YXPChartPlot *(^plotOfChartView)(NSInteger indexPlot);

@property (nonatomic, strong) YXPChartPointValue *(^pointValueOfPlot)(NSInteger indexPlot,NSInteger indexPoint);

@property (nonatomic, assign) void(^clickChartPoint)(NSInteger indexPlot,NSInteger indexPoint);

#pragma mark - 刷新

- (void)reloadChartView;


@end
