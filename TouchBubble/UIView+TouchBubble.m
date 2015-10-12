//
//  UIView+TouchBubble.m
//  TouchBubble
//
//  Created by Sam Bender on 10/12/15.
//  Copyright © 2015 Sam Bender. All rights reserved.
//

#import "UIView+TouchBubble.h"
#import <objc/runtime.h>

@implementation UIView (TouchBubble)

- (void) addTouchBubble
{
    [self setTouchBubbleColor:[UIColor whiteColor]];
    [self addTouchGestureRecognizer];
}

- (void) addTouchBubbleForWhiteBackground
{
    [self setTouchBubbleColor:[UIColor lightGrayColor]];
    [self addTouchGestureRecognizer];
}

- (void) addTouchGestureRecognizer
{
    UILongPressGestureRecognizer *tapRecognizer = [[UILongPressGestureRecognizer alloc] init];
    tapRecognizer.minimumPressDuration = 0.0;
    tapRecognizer.delegate = self;
    tapRecognizer.delaysTouchesBegan = false;
    [self addGestureRecognizer:tapRecognizer];
}

- (CAShapeLayer*) circle {
    return objc_getAssociatedObject(self, @selector(circle));
}

- (void) setCircle:(CAShapeLayer *)circle {
    objc_setAssociatedObject(self, @selector(circle), circle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor*) touchBubbleColor {
    return objc_getAssociatedObject(self, @selector(touchBubbleColor));
}

- (void) setTouchBubbleColor:(UIColor *)touchBubbleColor {
    touchBubbleColor = [touchBubbleColor colorWithAlphaComponent:.25];
    objc_setAssociatedObject(self, @selector(touchBubbleColor), touchBubbleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL) gestureRecognizerShouldBegin:(UITapGestureRecognizer*)gestureRecognizer
{
    if (self.circle != nil)
    {
        [self.circle removeFromSuperlayer];
    }
    self.circle = [CAShapeLayer layer];
    self.layer.masksToBounds = YES;
    
    // begin with a circle with a 50 points radius
    CGPoint center = CGPointMake(0, 0);
    CGFloat radius = 150;
    UIBezierPath *startShape = [UIBezierPath bezierPathWithArcCenter:center radius:2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    UIBezierPath *endShape = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    // set initial shape
    self.circle.path = startShape.CGPath;
    self.circle.fillColor = self.touchBubbleColor.CGColor;
    self.circle.position = [gestureRecognizer locationInView:self];
    
    // animate the `path`
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.toValue           = (__bridge id)(endShape.CGPath);
    animation.duration            = .5; // "animate over 10 seconds or so.."
    animation.repeatCount         =  1;  // Animate only once..
    animation.removedOnCompletion = false; // don't remove after finishing
    animation.fillMode = kCAFillModeBoth; // keep to value after finishing
    // Experiment with timing to get the appearence to look the way you want
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.delegate = self;
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.fromValue         = [NSNumber numberWithFloat:1.0];
    opacity.toValue           = [NSNumber numberWithFloat:0.0];
    opacity.duration            = .6; // "animate over 10 seconds or so.."
    opacity.repeatCount         =  1;  // Animate only once..
    opacity.removedOnCompletion = false; // don't remove after finishing
    opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    // Add to parent layer
    [self.layer addSublayer:self.circle];
    
    // Add the animation to the circle
    [self.circle addAnimation:animation forKey:@"drawCircleAnimation"];
    [self.circle addAnimation:opacity forKey:@"drawCircleAnimationOpacity"];
    
    return YES;
}

- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        [self.circle removeFromSuperlayer];
    }
}

@end
