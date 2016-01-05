//
//  YXPBarChartView.h
//  YXPChartViewDemo
//
//  Created by 段龙飞 on 16/1/5.
//  Copyright © 2016年 段龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPChartPlot.h"
#import "YXPChartPointValue.h"

@interface YXPBarChartView : UIView

@property (nonatomic, assign) UIEdgeInsets marginsSpace;
@property (nonatomic, assign) CGFloat barSpace;

@property (nonatomic, assign) NSInteger (^containNumberSacalesOfOnChartViewXAxis)();

@property (nonatomic, assign) NSInteger(^numberOfPlots)();

@property (nonatomic, assign) NSInteger(^numberOfPointOnPlot)(NSInteger indexPlot);

@property (nonatomic, strong) YXPChartPlot *(^plotOfChartView)(NSInteger indexPlot);

@property (nonatomic, strong) YXPChartPointValue *(^pointValueOfPlot)(NSInteger indexPlot,NSInteger indexPoint);

- (void)reloadBarView;

- (void)clearSubViews;
@end
