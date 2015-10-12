//
//  ViewController.m
//  TouchBubble
//
//  Created by Sam Bender on 8/29/15.
//  Copyright (c) 2015 Sam Bender. All rights reserved.
//

#import "ViewController.h"
#import "UIView+TouchBubble.h"

@interface ViewController ()
{
    CAShapeLayer *circle;
}

@end

@implementation ViewController

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.coloredView1 addTouchBubble];
    [self.coloredView2 addTouchBubble];
    [self.coloredView3 addTouchBubble];
    [self.coloredView4 addTouchBubble];
    [self.coloredView5 addTouchBubbleForWhiteBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
