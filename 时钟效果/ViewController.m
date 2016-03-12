//
//  ViewController.m
//  时钟效果
//
//  Created by 王禹丞 on 16/3/11.
//  Copyright © 2016年 wyc. All rights reserved.
//

#import "ViewController.h"

#define kClockW _clockView.bounds.size.width

#define angle2radion(angle) ((angle) / 180.0 * M_PI)

// 1秒6度(秒针)

#define perSecondA 6

// 1分钟6度(分针)

#define perMintueA 6

// 1小时30度（时针）

#define perHourA 30

// 每分钟时针转(30 / 60 °)

#define perMinHourA 0.5

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *clockView;

@property (nonatomic,weak) CALayer * secondLayer;

@property (nonatomic,weak) CALayer * mintueLayer;

@property (nonatomic,weak) CALayer * hourLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // 添加时针
    
    [self setUpHourLayer];
    
    // 添加分针
    
    [self setUpMinuteLayer];
    
    // 添加秒针
    
    [self setUpSecondLayer];
    
    //添加定时器
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    [self timeChange];
    
}

- (void)timeChange{
    
    // 获取当前系统时间
    
    NSCalendar * calender = [NSCalendar currentCalendar];
    
    NSDateComponents * cmp = [calender components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour  fromDate:[NSDate date]];
    
    CGFloat second = cmp.second;
    
    CGFloat secondA = (second * perSecondA) ;
    
    NSInteger minute = cmp.minute;
    
    CGFloat mintuteA = minute * perMintueA ;
    
    NSInteger hour = cmp.hour;
    
    CGFloat hourA = hour * perHourA  + minute * perMinHourA;
    
    _secondLayer.transform = CATransform3DMakeRotation(angle2radion(secondA), 0, 0, 1);

    _mintueLayer.transform = CATransform3DMakeRotation(angle2radion(mintuteA), 0, 0, 1);
    
    _hourLayer.transform = CATransform3DMakeRotation(angle2radion(hourA), 0, 0, 1);
}

#pragma mark - 添加秒针

- (void)setUpSecondLayer{

    CALayer * secondL = [CALayer layer];
    
    secondL.backgroundColor = [UIColor redColor].CGColor ;

    // 设置锚点
    
    secondL.anchorPoint = CGPointMake(0.5, 1);
    
    secondL.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    
    secondL.bounds = CGRectMake(0, 0, 1, kClockW * 0.5 - 20);
    

    [_clockView.layer addSublayer:secondL];

    _secondLayer = secondL;
}

#pragma mark - 添加分针

- (void)setUpMinuteLayer{
    
    CALayer * layer = [CALayer layer];
    
    layer.backgroundColor = [UIColor blackColor].CGColor ;
    
    // 设置锚点
    
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    layer.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    
    layer.bounds = CGRectMake(0, 0, 4, kClockW * 0.5 - 20);
    
    layer.cornerRadius = 4;
    
    [_clockView.layer addSublayer:layer];
    
    _mintueLayer = layer;
}

#pragma mark - 添加时针

- (void)setUpHourLayer{
    
    CALayer * layer = [CALayer layer];
    
    layer.backgroundColor = [UIColor blackColor].CGColor ;
    
    // 设置锚点
    
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    layer.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    
    layer.bounds = CGRectMake(0, 0, 4, kClockW * 0.5 - 40);
    
    layer.cornerRadius = 4;
    
    [_clockView.layer addSublayer:layer];
    
    _hourLayer = layer;
}
@end
