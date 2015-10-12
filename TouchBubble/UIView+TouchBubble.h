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
- (void) addTouchBubbleWithColor:(UIColor*)color;
- (void) addTouchBubbleForWhiteBackground;

@property (nonatomic, retain) CAShapeLayer *circle;
@property (nonatomic, retain) UIColor *touchBubbleColor;

@end
