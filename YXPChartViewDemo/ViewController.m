//
//  ViewController.m
//  YXPChartViewDemo
//
//  Created by 段龙飞 on 16/1/4.
//  Copyright © 2016年 段龙飞. All rights reserved.
//

#import "ViewController.h"

#import "YXPChartView.h"
#import "YXPChartPlot.h"
#import "YXPChartPointValue.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet YXPChartView * chartView;
@property (nonatomic, strong) IBOutlet YXPChartView * chartViewBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.chartView = [YXPChartView new];
    self.chartViewBar.chartStyle = YXPChartViewBarStyle;
    YXPChartPlot *plot = [self createNewPlot];
    plot.isNeedGradualColor = YES;
    YXPChartPlot *plot1 = [self createNewPlot];
    NSArray *plots = @[plot,plot1];
    
    self.chartView.containNumberSacalesOfOnChartViewXAxis = ^ NSInteger(){
        return 6;
    };
    self.chartView.marginsSpace = UIEdgeInsetsMake(20, 20, 20, 20);
    self.chartView.numberOfPlots = ^ NSInteger (){
        return 2;
    };
    
    self.chartView.numberOfPointOnPlot = ^ NSInteger (NSInteger indexPlot){
        YXPChartPlot *kPlot = plots[indexPlot];
        return kPlot.plotVales.count;
    };
    
    self.chartView.plotOfChartView = ^ YXPChartPlot * (NSInteger indexPlot){
        return plots[indexPlot];
    };
    
    self.chartView.pointValueOfPlot = ^ YXPChartPointValue * (NSInteger indexPlot,NSInteger indexPoint){
        YXPChartPlot *kPlot = plots[indexPlot];
        
        return kPlot.plotVales[indexPoint];
    };
    
    ///
    
    self.chartViewBar.containNumberSacalesOfOnChartViewXAxis = ^ NSInteger(){
        return 6;
    };
    self.chartViewBar.marginsSpace = UIEdgeInsetsMake(20, 20, 20, 20);
    self.chartViewBar.numberOfPlots = ^ NSInteger (){
        return 6;
    };
    
    self.chartViewBar.numberOfPointOnPlot = ^ NSInteger (NSInteger indexPlot){
        
        return 6;
    };
    
    self.chartViewBar.plotOfChartView = ^ YXPChartPlot * (NSInteger indexPlot){
        return plot1;
    };
    
    self.chartViewBar.pointValueOfPlot = ^ YXPChartPointValue * (NSInteger indexPlot,NSInteger indexPoint){
        
        return plot1.plotVales[indexPoint];
    };

    
}

- (YXPChartPlot *)createNewPlot{
    YXPChartPlot *plot = [YXPChartPlot new];
    plot.plotVales = [self createPoints];
    plot.beginControlVale = 40;
    plot.maxValue = [self caculateMaxMin:plot][0];
    
    plot.minValue = [self caculateMaxMin:plot][1];
    
    return plot;
}

- (NSArray *)caculateMaxMin:(YXPChartPlot *)plot{
    CGFloat max = 0;
    CGFloat min = 0;
    for (YXPChartPointValue *value in plot.plotVales) {
        if ([value.value floatValue]>max) {
            max = [value.value floatValue];
        }
        
        if ([value.value floatValue] < min) {
            min = [value.value floatValue];
        }
    }
    return @[@(max),@(min)];
}

- (NSArray *)createPoints{
    
    NSMutableArray *array = @[].mutableCopy;
    for (NSInteger i = 0; i <6; i++) {
        YXPChartPointValue *pointValue = [YXPChartPointValue new];
        
        pointValue.value = [NSNumber numberWithFloat:arc4random()%100];
        NSLog(@"-----%f",pointValue.value.floatValue);
        pointValue.isSepcial = (i==3);
        pointValue.strokerColor = i==3?[UIColor purpleColor]:[UIColor orangeColor];
        pointValue.fillColor = [UIColor whiteColor];
        pointValue.radium = i==3?6:4;
        [array addObject:pointValue];
    }
   
    return array;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self updateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateView{
    
    [self.chartView reloadChartView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.chartViewBar reloadChartView];
        
    });
    
}

@end
