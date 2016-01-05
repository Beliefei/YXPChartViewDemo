//
//  YXPChartPointValue.h
//  YXPChartViewDemo
//
//  Created by 段龙飞 on 16/1/5.
//  Copyright © 2016年 段龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YXPChartPointValue : NSObject


@property (nonatomic, strong) UIColor * strokerColor;

@property (nonatomic, strong) UIColor * circleColor;

@property (nonatomic, assign) CGFloat  strokerWidth;

@property (nonatomic, assign) CGFloat radium;

@property (nonatomic, strong) UIColor *fillColor;

@property (nonatomic, copy) NSString *msgString;

@property (nonatomic, strong) NSNumber * value;

@property (nonatomic, assign) BOOL isSepcial;

@end
