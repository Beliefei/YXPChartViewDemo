//
//  YXPBarChartView.m
//  YXPChartViewDemo
//
//  Created by 段龙飞 on 16/1/5.
//  Copyright © 2016年 段龙飞. All rights reserved.
//

#import "YXPBarChartView.h"
#import "YXPChartViewAnimationUtil.h"

@interface YXPBarChartView (){
    
    
    
    NSInteger _numberScaleOfXAxis;
    CGFloat _bigScaleWidth;
    CGFloat _smallScaleWith;
    CGFloat _yScaleVaule;
    CGFloat _yHeight;
    NSMutableArray *_barViewsArray;
    YXPChartPlot *_plot;
}



@end

@implementation YXPBarChartView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self someDefaultValues];

}

- (instancetype)init{
    if (self = [super init]) {
        [self someDefaultValues];
 
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame]) {
        [self someDefaultValues];
    }
    
    return self;
}

- (void)someDefaultValues{
    self.marginsSpace = UIEdgeInsetsMake(0, 0, 0, 0);
    self.barSpace = 10;
    _barViewsArray = @[].mutableCopy;
}

- (void)reloadBarView{
    
    [self clearSubViews];
    
    [self caculeteSomeVales];
    
    [self initSubViews];
    
    [self beginAnimation];
    
}

- (void)clearSubViews{
    for (UIView *subView in _barViewsArray) {
        [subView.layer removeAllAnimations];
        subView.layer.sublayers = nil;
        [subView removeFromSuperview];
        
    }
}

- (void)caculeteSomeVales{
    if (self.numberOfPlots) {
        
        _numberScaleOfXAxis = self.numberOfPlots();
        
        _bigScaleWidth = (self.bounds.size.width - (_numberScaleOfXAxis-1)*self.barSpace - self.marginsSpace.left- self.marginsSpace.right)/_numberScaleOfXAxis;
        if (self.numberOfPointOnPlot) {
            _smallScaleWith = _bigScaleWidth/self.numberOfPointOnPlot(0);
        }else{
            _smallScaleWith = _bigScaleWidth;
            
            
        }
        
        _plot = self.plotOfChartView(0);
        
        
        _yHeight = self.bounds.size.height -self.marginsSpace.top-self.marginsSpace.bottom;
        
        _yScaleVaule = (_yHeight - 30)/_plot.maxValue.floatValue;

        
    }
    
}

- (void)initSubViews{
    
    
    
    
    for (NSInteger i = 0; i < _numberScaleOfXAxis; i++) {
        
        
        YXPChartPointValue *pointValue = _plot.plotVales[i];
        
        UIView *backView = [UIView new];
        [self addSubview:backView];
        backView.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:0.6 alpha:0.6];
        backView.frame = CGRectMake(self.marginsSpace.left+(_bigScaleWidth+self.barSpace)*i, self.marginsSpace.top, _bigScaleWidth, _yHeight);
        
        UIView *fillView = [UIView new];
        [self addSubview:fillView];
        fillView.backgroundColor = [UIColor redColor];
        CGFloat y = _yHeight - pointValue.value.floatValue*_yScaleVaule;
        fillView.frame = CGRectMake(self.marginsSpace.left+(_bigScaleWidth+self.barSpace)*i, self.marginsSpace.bottom + y, _bigScaleWidth, pointValue.value.floatValue*_yScaleVaule);
        
        [_barViewsArray addObject:fillView];
        
        
        
    }
    

    
}

- (void)beginAnimation{
    for (NSInteger i = 0; i < _barViewsArray.count; i ++) {
        UIView *barView = _barViewsArray[i];
        [YXPChartViewAnimationUtil barChartView:barView beginTime:i*3+1];
    }
}

@end
