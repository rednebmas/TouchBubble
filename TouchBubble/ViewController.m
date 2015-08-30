//
//  ViewController.m
//  TouchBubble
//
//  Created by Sam Bender on 8/29/15.
//  Copyright (c) 2015 Sam Bender. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addGestureRecognizer];
    
    /*
    CGPoint center = CGPointMake(0,0);
    CGFloat radius = 75;
    UIBezierPath *circle = [UIBezierPath bezierPathWithArcCenter:center
                                                          radius:radius
                                                      startAngle:0
                                                        endAngle:2.0*M_PI
                                                       clockwise:YES];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.bounds = CGRectMake(0, 0, 2.0*radius, 2.0*radius);
    circleLayer.path   = circle.CGPath;
    circleLayer.strokeColor = [UIColor orangeColor].CGColor;
    circleLayer.lineWidth   = 3.0; // your line width
    // Center the shape in self.view
    circleLayer.position = CGPointMake(CGRectGetMidX(self.view.frame)-radius,
                                  CGRectGetMidY(self.view.frame)-radius);
    
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration = 10.0; // your duration
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = @0;
    drawAnimation.toValue   = @1;
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [self.view.layer addSublayer:circleLayer];
    [circleLayer addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    */
    
    /*
    // Set up the shape of the circle
    int radius = 100;
    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*1, 2.0*1) cornerRadius:radius];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius) cornerRadius:radius];
    circle.path = startPath.CGPath;
    // Center the shape in self.view
    circle.position = CGPointMake(CGRectGetMidX(self.view.frame)-radius,
                                  CGRectGetMidY(self.view.frame)-radius);
    
    // Configure the apperence of the circle
    circle.fillColor = [UIColor grayColor].CGColor;
    
    // Add to parent layer
    [self.view.layer addSublayer:circle];
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    drawAnimation.duration            = 10.0; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.toValue   = (__bridge id)(endPath.CGPath);
    drawAnimation.fillMode = kCAFillModeBoth; // keep to value after finishing
    drawAnimation.removedOnCompletion = false; // don't remove after finishing
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // Add the animation to the circle
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addGestureRecognizer
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animateCircle)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void) animateCircle
{
    CAShapeLayer *circle = [CAShapeLayer layer];
    
    // begin with a circle with a 50 points radius
    CGPoint center = CGPointMake(0, 0);
    CGFloat radius = 75;
    UIBezierPath *startShape = [UIBezierPath bezierPathWithArcCenter:center radius:2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    UIBezierPath *endShape = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    // set initial shape
    circle.path = startShape.CGPath;
    circle.fillColor = [UIColor redColor].CGColor;
    circle.position = CGPointMake(CGRectGetMidX(self.view.frame),
                                  CGRectGetMidY(self.view.frame));
    
    // 2
    // animate the `path`
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.toValue           = (__bridge id)(endShape.CGPath);
    animation.duration            = 10.0; // "animate over 10 seconds or so.."
    animation.repeatCount         = 1.0;  // Animate only once..
     
    // 3
    animation.fillMode = kCAFillModeBoth; // keep to value after finishing
    animation.removedOnCompletion = false; // don't remove after finishing
    // 4
    
    // Experiment with timing to get the appearence to look the way you want
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // Add to parent layer
    [self.view.layer addSublayer:circle];
    
    // Add the animation to the circle
    [circle addAnimation:animation forKey:@"drawCircleAnimation"];
}

@end
