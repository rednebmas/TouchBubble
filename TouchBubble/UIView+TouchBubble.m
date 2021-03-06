//
//  UIView+TouchBubble.m
//  TouchBubble
//
//  Created by Sam Bender on 10/12/15.
//  Copyright © 2015 Sam Bender. All rights reserved.
//

#import "UIView+TouchBubble.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_ALPHA_COMPONENT 0.15

@implementation UIView (TouchBubble)

- (void) addTouchBubble
{
    [self setTouchBubbleColor:[[UIColor whiteColor] colorWithAlphaComponent:DEFAULT_ALPHA_COMPONENT]];
    [self setup];
}

- (void) addTouchBubbleForWhiteBackground
{
    [self setTouchBubbleColor:[[UIColor lightGrayColor] colorWithAlphaComponent:DEFAULT_ALPHA_COMPONENT]];
    [self setup];
}

- (void) setup
{
    self.layer.masksToBounds = YES;
}

/***/
/*** Properties for Objective-C categories      ***/
/*** http://stackoverflow.com/a/14899909/337934 ***/
/***/
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
    objc_setAssociatedObject(self, @selector(touchBubbleColor), touchBubbleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (self.touchBubbleColor == nil)
        return;
    
    if (touches.count != 1)
        return;
    
    if (self.circle != nil)
        [self.circle removeFromSuperlayer];
    
    UITouch *touch = [touches anyObject];
    
    self.circle = [CAShapeLayer layer];
    self.circle.zPosition = -100;
    
    // begin with a circle with a 150 points radius
    CGPoint center = CGPointMake(0, 0);
    CGFloat radius = 150;
    UIBezierPath *startShape = [UIBezierPath bezierPathWithArcCenter:center radius:2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    UIBezierPath *endShape = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    // set initial shape
    self.circle.path = startShape.CGPath;
    self.circle.fillColor = self.touchBubbleColor.CGColor;
    self.circle.position = [touch locationInView:self];
    
    // animate the `path`
    CABasicAnimation *animation   = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.toValue             = (__bridge id)(endShape.CGPath);
    animation.duration            = .25;
    animation.repeatCount         =  1;
    animation.removedOnCompletion = false; // don't remove after finishing
    animation.fillMode = kCAFillModeForwards; // keep to value after finishing
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.delegate = self;
    
    // Add to parent layer
    [self.layer addSublayer:self.circle];
    
    // Add the animation to the circle
    [self.circle addAnimation:animation forKey:@"drawCircleAnimation"];
    [self.circle setName:@"increasingSize"];
}

- (void) animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    if ([self.circle.name isEqualToString:@"increasingSize"])
    {
        [self addOpacityAnimationWithDelay:.3];
    }
}

-(void)touchesEnded:(NSSet*)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (touches.count == 1 && [self.circle.name isEqualToString:@"increasingSize"])
    {
        [self addOpacityAnimationWithDelay:0.0];
    }
}

- (void) addOpacityAnimationWithDelay:(CGFloat)delay
{
    [self.circle setName:@"reducingOpacity"];
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.fromValue         = [NSNumber numberWithFloat:1.0];
    opacity.toValue           = [NSNumber numberWithFloat:0.0];
    opacity.duration            = .25;
    opacity.beginTime           =  CACurrentMediaTime() + delay;
    opacity.repeatCount         =  1;  // Animate only once..
    opacity.removedOnCompletion = false; // don't remove after finishing
    opacity.fillMode = kCAFillModeForwards; // keep to value after finishing
    opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.circle addAnimation:opacity forKey:@"drawCircleAnimationOpacity"];
}

@end
