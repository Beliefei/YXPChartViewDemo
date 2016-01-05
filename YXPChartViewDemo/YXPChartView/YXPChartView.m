//
//  YXPChartView.m
//  YXPChartViewDemo
//
//  Created by 段龙飞 on 16/1/4.
//  Copyright © 2016年 段龙飞. All rights reserved.
//

#import "YXPChartView.h"
#import "YXPLineChartView.h"
#import "YXPBarChartView.h"
#import "YXPChartViewAnimationUtil.h"

@interface YXPChartView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSMutableArray *chartViewArray;

@property (nonatomic, strong) NSMutableArray *specialShowMsgLayerArray;

@end

@implementation YXPChartView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self makeSomeDefaultSetting];

}

- (instancetype)init{
    if ((self = [super init])) {
        [self makeSomeDefaultSetting];

    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        [self makeSomeDefaultSetting];

    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        [self makeSomeDefaultSetting];
    }
    
    return self;
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    [self beginReloadSubViews];
}



- (void)makeSomeDefaultSetting{
    
    self.marigns = UIEdgeInsetsMake(0, 0, 0, 0);
    self.marginsSpace = UIEdgeInsetsMake(0, 0, 0, 0);
    self.chartStyle = YXPChartViewDefaultStyle;
    self.contenViewBackgroundColor = [UIColor whiteColor];
    self.colorOfXAxis = [UIColor lightGrayColor];
    self.colorOfYAxis = [UIColor lightGrayColor];
    self.chartViewArray = @[].mutableCopy;
    self.specialShowMsgLayerArray = @[].mutableCopy;
    self.numberOfPlots = ^ NSInteger (){
        return 1;
    };
}

- (void)setMarigns:(UIEdgeInsets)marigns{
   
    _margins = marigns;
    [self callMyNeedReDisplay];
}

- (void)setMarginsSpace:(UIEdgeInsets)marginsSpace{
    _marginsSpace = marginsSpace;
    [self callMyNeedReDisplay];
}

- (void)setContenViewBackgroundColor:(UIColor *)contenViewBackgroundColor{
    if (_contenViewBackgroundColor!= contenViewBackgroundColor) {
        _contenViewBackgroundColor = contenViewBackgroundColor;
        [self callMyNeedReDisplay];
    }
}

- (void)setContainNumberSacalesOfOnChartViewXAxis:(NSInteger (^)())containNumberSacalesOfOnChartViewXAxis{
    if (containNumberSacalesOfOnChartViewXAxis()>10) {
        _containNumberSacalesOfOnChartViewXAxis = ^ NSInteger (){
            return 10;
        };
    }else{
        _containNumberSacalesOfOnChartViewXAxis = containNumberSacalesOfOnChartViewXAxis;
    }
    [self callMyNeedReDisplay];
}


- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
//    for (UIView *subView in self.subviews) {
//        [subView removeFromSuperview];
//    }
    
    
}

- (void)callMyNeedReDisplay{
//     [self setNeedsDisplay];
}

#pragma mark - 外部方法

- (void)beginReloadSubViews{
    
    
}
- (void)reloadChartView{
    
    for (UIView *subView in self.subviews) {
        [subView.layer removeAllAnimations];
        subView.layer.sublayers = nil;
        [subView removeFromSuperview];
        
    }
    
    self.chartViewArray = @[].mutableCopy;
    self.specialShowMsgLayerArray = @[].mutableCopy;
    
    [self createXYView];
    
    [self drawValueView];
    
    [self drawSpecialPoint];
    
    [self beginAllAnimation];
    
    
    
    

}

- (void)createXYView{
    CGSize size = [self caculateContenChartViewSize];
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(self.margins.left, self.margins.top, size.width , size.height)];
    if (self.chartStyle == YXPChartViewDefaultStyle) {
        //折线图
       
        NSInteger numberScale = self.containNumberSacalesOfOnChartViewXAxis()-1;
        CGFloat xScale = (size.width- self.marginsSpace.left- self.marginsSpace.right)/numberScale;
        
        CAShapeLayer *xyLaber = [CAShapeLayer layer];
        xyLaber.frame = self.contentView.bounds;
        xyLaber.backgroundColor = [UIColor clearColor].CGColor;
        xyLaber.fillColor = [UIColor clearColor].CGColor;
        xyLaber.lineWidth = 0.5;
        xyLaber.strokeColor = self.colorOfXAxis.CGColor;
        
        
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 0, self.contentView.bounds.size.height);
        CGPathAddLineToPoint(path, NULL, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
        
        for (NSInteger i = 0; i< numberScale+1; i++) {
            CGPathMoveToPoint(path, NULL, self.marginsSpace.left + i*xScale, 0);
            CGPathAddLineToPoint(path, NULL, self.marginsSpace.left + i*xScale, size.height);
        }
        
        xyLaber.path = path;
        [self.contentView.layer addSublayer:xyLaber]
        ;
    }else{
        //柱状图
        
    }
    
    [self addSubview:self.contentView];

    
}

- (CGSize)caculateContenChartViewSize{
    CGFloat width = self.bounds.size.width - self.margins.left - self.margins.right;
    CGFloat height = self.bounds.size.height -  self.margins.top - self.margins.bottom;
    
    
    
    return CGSizeMake(width, height);
}

- (void)drawValueView{
    if (self.chartStyle == YXPChartViewDefaultStyle) {
        __weak typeof(self) weakSelf = self;
        for (NSInteger i = 0 ; i < self.numberOfPlots();i++) {
            YXPLineChartView *lineChartView = [YXPLineChartView new];
            lineChartView.frame = self.contentView.bounds;
            lineChartView.plot = ^ YXPChartPlot *(){
                if (self.plotOfChartView) {
                    return  self.plotOfChartView(i);
                }
                return nil;
            };
            [lineChartView setPointValueOfPlot:^YXPChartPointValue *(NSInteger m) {
                return weakSelf.pointValueOfPlot(i,m);
            }];
            lineChartView.marginsSpace = self.marginsSpace;
            
            [self.contentView addSubview:lineChartView];
            [self.chartViewArray addObject:lineChartView];
            [lineChartView reloadLine];
        }
    }else{
//        __weak typeof(self) weakSelf = self;
        for (NSInteger i = 0 ; i < self.numberOfPlots();i++) {
            YXPBarChartView *lineChartView = [YXPBarChartView new];
            lineChartView.frame = self.contentView.bounds;
            lineChartView.numberOfPlots = self.numberOfPlots;
            lineChartView.numberOfPointOnPlot = self.numberOfPointOnPlot;
            lineChartView.plotOfChartView = self.plotOfChartView;
            lineChartView.marginsSpace = self.marginsSpace;
            
            [self.contentView addSubview:lineChartView];
            [self.chartViewArray addObject:lineChartView];
            [lineChartView reloadBarView];
        }

    }

}


- (void)beginAllAnimation{

    if (self.chartStyle == YXPChartViewDefaultStyle) {
        for (NSInteger i = 0; i <2; i ++) {
             [YXPChartViewAnimationUtil lineChartView:self.chartViewArray[i] beginTime:i*4 ];
        }
        

    }else{
        
    }
    
    
}


- (void)drawSpecialPoint{

}

@end
