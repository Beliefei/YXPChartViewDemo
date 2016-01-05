//
//  YXPLineChartView.h
//  YXPChartViewDemo
//
//  Created by 段龙飞 on 16/1/5.
//  Copyright © 2016年 段龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPChartPlot.h"
#import "YXPChartPointValue.h"

@interface YXPLineChartView : UIView

@property (nonatomic, assign) UIEdgeInsets marginsSpace;
@property (nonatomic, strong) YXPChartPlot *(^plot)();
@property (nonatomic, strong) YXPChartPointValue *(^pointValueOfPlot)(NSInteger indexPoint);
@property (nonatomic, assign) void(^clickChartPoint)(NSInteger indexPoint);

- (void)reloadLine;
@end
