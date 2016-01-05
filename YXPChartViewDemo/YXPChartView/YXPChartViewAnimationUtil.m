//
//  YXPChartViewAnimationUtil.m
//  YXPChartViewDemo
//
//  Created by 段龙飞 on 16/1/5.
//  Copyright © 2016年 段龙飞. All rights reserved.
//

#import "YXPChartViewAnimationUtil.h"

@implementation YXPChartViewAnimationUtil

+ (void)lineChartView:(UIView *)view beginTime:(NSTimeInterval)beginTime animationDelegate:(id)delagte{
    CGPathRef beginPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 0, CGRectGetHeight(view.bounds))].CGPath;
    
    CGPathRef endPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds))].CGPath;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.path = beginPath;
    
    view.layer.mask = layer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = 3;
    animation.beginTime = CACurrentMediaTime() + beginTime;
    animation.fromValue = (id)layer.path;
    animation.toValue = (__bridge id)endPath;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
//    animation.delegate = delagte;
    [layer addAnimation:animation forKey:@"shapeLayerPath"];
}




@end
