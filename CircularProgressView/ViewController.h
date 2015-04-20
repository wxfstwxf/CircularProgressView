//
//  ViewController.h
//  CircularProgressView
//
//  Created by Felix Wu on 4/16/15.
//  Copyright (c) 2015 Felix Wu. All rights reserved.
//

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define PROGREESS_WIDTH 150 //圆直径
#define PROGRESS_LINE_WIDTH 8 //弧线的宽度

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(strong,nonatomic) CAShapeLayer *trackLayer;
@property(strong,nonatomic) UIColor *strokeColor;

@property(strong,nonatomic) CAShapeLayer *progressLayer;

@property(strong,nonatomic) CADisplayLink *timer;

@end

