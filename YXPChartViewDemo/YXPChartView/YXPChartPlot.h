//
//  YXPChartPlot.h
//  YXPChartViewDemo
//
//  Created by 段龙飞 on 16/1/5.
//  Copyright © 2016年 段龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YXPChartPlot : NSObject

@property (nonatomic, strong) NSArray * plotVales;

@property (nonatomic, strong) NSNumber *maxValue;

@property (nonatomic, strong) NSNumber *minValue;

@property (nonatomic, assign) CGFloat beginControlVale;

@property (nonatomic, assign) CGFloat endControlVale;

@property (nonatomic, assign) BOOL isNeedGradualColor;


- (void)buildMaxValue:(NSNumber *)max minValue:(NSNumber *)min;

@end
