//
//  YXPLineChartView.m
//  YXPChartViewDemo
//
//  Created by 段龙飞 on 16/1/5.
//  Copyright © 2016年 段龙飞. All rights reserved.
//

#import "YXPLineChartView.h"

@implementation YXPLineChartView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self someDefaultValues];

}

- (instancetype)init{
    if ((self = [super init])) {
        [self someDefaultValues];

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        [self someDefaultValues];
    }
    
    return self;
}

- (void)someDefaultValues{
    self.marginsSpace = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)reloadLine{
    
    YXPChartPlot *plot = self.plot();
    CGSize size = self.bounds.size;
    if (plot) {
       
        [self drawGradualColor:plot ];
       
        YXPChartPointValue *firstPoint = plot.plotVales[0];

        CGFloat xScale = (size.width- self.marginsSpace.left- self.marginsSpace.right)/(plot.plotVales.count-1);
        
        CAShapeLayer *chartViewLayer = [CAShapeLayer layer];
        
        chartViewLayer.frame = self.bounds;
        
        chartViewLayer.strokeColor = firstPoint.strokerColor.CGColor;
        
        chartViewLayer.lineWidth = firstPoint.strokerWidth;
        
        chartViewLayer.backgroundColor = [UIColor clearColor].CGColor;
        
        chartViewLayer.fillColor = [UIColor clearColor].CGColor;
        
        CGFloat yScaleValue = (size.height - self.marginsSpace.top -self.marginsSpace.bottom)/([plot.maxValue floatValue] - [plot.minValue floatValue]);
        
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGFloat leftBeginPoint = self.bounds.size.height - (plot.beginControlVale - [plot.minValue floatValue])*yScaleValue - self.marginsSpace.bottom;
        
        
        CGFloat firstYValue = self.bounds.size.height - ([firstPoint.value floatValue] -[plot.minValue floatValue])*yScaleValue - [plot.minValue floatValue]- self.marginsSpace.bottom;
        
        CGPathMoveToPoint(path, NULL, 0, leftBeginPoint);
        
        CGPathAddLineToPoint(path, NULL, self.marginsSpace.left, firstYValue);
        
        for (NSInteger i = 1; i < plot.plotVales.count; i++) {
            YXPChartPointValue *point = plot.plotVales[i];
            
            CGFloat yValue =  self.bounds.size.height -([point.value floatValue] - [plot.minValue floatValue])*yScaleValue - [plot.minValue floatValue]- self.marginsSpace.bottom;

            CGPathAddLineToPoint(path, NULL, self.marginsSpace.left+ xScale*i, yValue);
        }
        
        CGFloat rigthEndPoint =  self.bounds.size.height -(plot.endControlVale - [plot.minValue floatValue])*yScaleValue- [plot.minValue floatValue]- self.marginsSpace.bottom;
        
        CGPathAddLineToPoint(path, NULL, self.bounds.size.width, rigthEndPoint);
        
        chartViewLayer.path = path;
        
        [self.layer addSublayer:chartViewLayer];
        
        NSArray *handlePoints = [self handleOrdinaryPointAndSepcialPoint:plot];
        
        NSArray *ordinaryPoints = handlePoints[0];
        NSArray *specialPoints = handlePoints[1];
        
        if (ordinaryPoints.count) {
            YXPChartPointValue *ordinaryPoint = ordinaryPoints[0];
            CAShapeLayer *ordinaryCircleLayer = [CAShapeLayer layer];
            ordinaryCircleLayer.strokeColor = ordinaryPoint.strokerColor.CGColor;
            ordinaryCircleLayer.lineWidth = ordinaryPoint.strokerWidth;
            ordinaryCircleLayer.fillColor = ordinaryPoint.fillColor.CGColor;
            ordinaryCircleLayer.frame = self.bounds;
            
            CGMutablePathRef oCirclePath = CGPathCreateMutable();
            
            for (YXPChartPointValue *kOrdinaryPoint in ordinaryPoints) {
                CGFloat y = self.bounds.size.height - (([kOrdinaryPoint.value floatValue] - [plot.minValue floatValue])*yScaleValue + self.marginsSpace.bottom);
                CGFloat x = [plot.plotVales indexOfObject:kOrdinaryPoint]*xScale + self.marginsSpace.left;
                
                 CGPathAddEllipseInRect(oCirclePath, NULL, CGRectMake(x-kOrdinaryPoint.radium, y-kOrdinaryPoint.radium, kOrdinaryPoint.radium*2, kOrdinaryPoint.radium*2));
            }
            ordinaryCircleLayer.path = oCirclePath;
            
            [self.layer addSublayer:ordinaryCircleLayer];
        }
        
        if (specialPoints.count) {
            for (YXPChartPointValue *point in specialPoints) {
                CGFloat y = self.bounds.size.height - (([point.value floatValue] - [plot.minValue floatValue])*yScaleValue + self.marginsSpace.bottom);
                CGFloat x = [plot.plotVales indexOfObject:point]*xScale + self.marginsSpace.left;
                

                CAShapeLayer *ordinaryCircleLayer = [CAShapeLayer layer];
                ordinaryCircleLayer.strokeColor = point.circleColor.CGColor;
                ordinaryCircleLayer.lineWidth = point.strokerWidth;
                ordinaryCircleLayer.fillColor = point.fillColor.CGColor;
                ordinaryCircleLayer.frame = CGRectMake(x-point.radium, y-point.radium, point.radium*2, point.radium*2);
                CGMutablePathRef sCirclePath = CGPathCreateMutable();
                 CGPathAddEllipseInRect(sCirclePath, NULL, CGRectMake(0, 0, point.radium*2, point.radium*2));
                ordinaryCircleLayer.path = sCirclePath;
                [self.layer addSublayer:ordinaryCircleLayer];
                

            }
        }
       
        
        
    }
}

- (void)drawGradualColor:(YXPChartPlot *)plot{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[(id)[UIColor colorWithRed:0 green:0.8 blue:1.0 alpha:0.5].CGColor,(id)[UIColor clearColor].CGColor];
    [self.layer addSublayer:gradientLayer];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    maskLayer.fillColor = [UIColor clearColor].CGColor;

    maskLayer.frame = self.bounds;
    maskLayer.masksToBounds = YES;
    
    
    CGSize size = self.bounds.size;

    CGFloat xScale = (size.width- self.marginsSpace.left- self.marginsSpace.right)/(plot.plotVales.count-1);

    CGFloat yScaleValue = (size.height - self.marginsSpace.top -self.marginsSpace.bottom)/([plot.maxValue floatValue] - [plot.minValue floatValue]);

    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat leftBeginPoint = self.bounds.size.height - (plot.beginControlVale - [plot.minValue floatValue])*yScaleValue - self.marginsSpace.bottom;
    
    YXPChartPointValue *firstPoint = plot.plotVales[0];
    
    CGFloat firstYValue = self.bounds.size.height - ([firstPoint.value floatValue] -[plot.minValue floatValue])*yScaleValue - [plot.minValue floatValue]- self.marginsSpace.bottom;
    
    CGPathMoveToPoint(path, NULL, 0, leftBeginPoint);
    
    CGPathAddLineToPoint(path, NULL, self.marginsSpace.left, firstYValue);
    
    for (NSInteger i = 1; i < plot.plotVales.count; i++) {
        YXPChartPointValue *point = plot.plotVales[i];
        
        CGFloat yValue =  self.bounds.size.height -([point.value floatValue] - [plot.minValue floatValue])*yScaleValue - [plot.minValue floatValue]- self.marginsSpace.bottom;
        
        CGPathAddLineToPoint(path, NULL, self.marginsSpace.left+ xScale*i, yValue);
    }
    
    CGFloat rigthEndPoint =  self.bounds.size.height -(plot.endControlVale - [plot.minValue floatValue])*yScaleValue- [plot.minValue floatValue]- self.marginsSpace.bottom;
    
    CGPathAddLineToPoint(path, NULL, self.bounds.size.width, rigthEndPoint);
    
    CGPathAddLineToPoint(path, NULL, self.bounds.size.width, self.bounds.size.height);
    
    CGPathAddLineToPoint(path, NULL, 0, self.bounds.size.height);
    
    CGPathCloseSubpath(path);
    gradientLayer.mask = maskLayer;

    maskLayer.path = path;
    if (plot.isNeedGradualColor) {
        maskLayer.fillColor = [UIColor whiteColor].CGColor;

    }
    
    
}

- (NSArray *)handleOrdinaryPointAndSepcialPoint:(YXPChartPlot *)plot{
    NSMutableArray *ordinaryArray = @[].mutableCopy;
    NSMutableArray *specialArray = @[].mutableCopy;
    
    for (YXPChartPointValue *value in plot.plotVales) {
        if(value.isSepcial){
            [specialArray addObject:value];
        }else{
            [ordinaryArray addObject:value];
        }
    }
    
    return @[ordinaryArray,specialArray];
}

@end
