//
//  UIView+TouchBubble.h
//  TouchBubble
//
//  Created by Sam Bender on 10/12/15.
//  Copyright © 2015 Sam Bender. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TouchBubble) <UIGestureRecognizerDelegate>

- (void) addTouchBubble;
- (void) addTouchBubbleForWhiteBackground;

@property (nonatomic, retain, readonly) CAShapeLayer *circle;
// the color of the circle to draw
@property (nonatomic, retain) UIColor *touchBubbleColor;

@end
