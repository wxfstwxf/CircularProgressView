//
//  ViewController.m
//  CircularProgressView
//
//  Created by Felix Wu on 4/16/15.
//  Copyright (c) 2015 Felix Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _strokeColor = [UIColor redColor];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *circularView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, PROGREESS_WIDTH, PROGREESS_WIDTH)];
    [self.view addSubview:circularView];
    
    _trackLayer = [CAShapeLayer layer];//创建一个track shape layer
    _trackLayer.frame = circularView.bounds;
    [circularView.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = [[UIColor clearColor] CGColor];
    _trackLayer.strokeColor = [_strokeColor CGColor];//指定path的渲染颜色
    _trackLayer.opacity = 0.25; //做背景，不要太明显了，透明度小一点
    _trackLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _trackLayer.lineWidth = PROGRESS_LINE_WIDTH;//线的宽度
    
    _trackLayer.miterLimit = 99;
    _trackLayer.lineJoin = kCALineJoinRound;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(PROGREESS_WIDTH/2, PROGREESS_WIDTH/2) radius:(PROGREESS_WIDTH-PROGRESS_LINE_WIDTH)/2 startAngle:degreesToRadians(-225) endAngle:degreesToRadians(45) clockwise:YES];//上面说明过了用来构建圆形
    _trackLayer.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = circularView.bounds;
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor  = [[UIColor whiteColor] CGColor];
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = PROGRESS_LINE_WIDTH;
    _progressLayer.path = [path CGPath];
//    _progressLayer.strokeStart = 0.0;
    _progressLayer.strokeEnd = 0.0;
    
    CALayer *gradientLayer = [CALayer layer];
    CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(0, 0, circularView.bounds.size.width/2, circularView.bounds.size.height);
    [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor],(id)[[UIColor yellowColor] CGColor], nil]];
    [gradientLayer1 setLocations:@[@0.5,@0.9,@1 ]];
    //矢量方向
    [gradientLayer1 setStartPoint:CGPointMake(0.5, 1)];
    [gradientLayer1 setEndPoint:CGPointMake(0.5, 0)];
    
    [gradientLayer addSublayer:gradientLayer1];
    
    CAGradientLayer *gradientLayer2 =  [CAGradientLayer layer];
    [gradientLayer2 setLocations:@[@0.1,@0.5,@1]];
    gradientLayer2.frame = CGRectMake(circularView.bounds.size.width/2, 0, circularView.bounds.size.width/2, circularView.bounds.size.height);
    [gradientLayer2 setColors:[NSArray arrayWithObjects:(id)[[UIColor yellowColor] CGColor],(id)[[UIColor blueColor] CGColor], nil]];
    [gradientLayer2 setStartPoint:CGPointMake(0.5, 0)];
    [gradientLayer2 setEndPoint:CGPointMake(0.5, 1)];
    [gradientLayer addSublayer:gradientLayer2];
    
    [gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层
    [circularView.layer addSublayer:gradientLayer];
    
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(refresh)];
    [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)refresh {
    if (_progressLayer.strokeEnd < 1) {
        _progressLayer.strokeEnd = _progressLayer.strokeEnd + 0.005;
    }else {
        [_timer invalidate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
