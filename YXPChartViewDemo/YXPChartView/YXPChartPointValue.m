//
//  YXPChartPointValue.m
//  YXPChartViewDemo
//
//  Created by 段龙飞 on 16/1/5.
//  Copyright © 2016年 段龙飞. All rights reserved.
//

#import "YXPChartPointValue.h"

@implementation YXPChartPointValue

- (instancetype)init{
    if (self = [super init]) {
        /**
         @property (nonatomic, strong) UIColor * strokerColor;
         
         @property (nonatomic, strong) UIColor * circleColor;
         
         @property (nonatomic, assign) CGFloat  strokerWidth;
         
         @property (nonatomic, assign) CGFloat radium;
         
         @property (nonatomic, strong) UIColor *fillColor;
         
         @property (nonatomic, copy) NSString *msgString;
         
         @property (nonatomic, strong) NSNumber * value;
         
         @property (nonatomic, assign) BOOL isSepcial;
         */
        
        self.strokerWidth = 3;
        
        self.strokerColor = [UIColor orangeColor];
        self.circleColor = [UIColor greenColor];
        self.radium = 5;
        self.fillColor = [UIColor greenColor];
        self.value = [NSNumber numberWithFloat:0.0];
        self.msgString = @"";
        self.isSepcial = NO;
        
        
    }
    
    return self;
}

@end
