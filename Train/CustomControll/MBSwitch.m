//
//  MBSwitch.m
//  Train
//
//  Created by Zhang Gongwei on 11/4/13.
//  Copyright (c) 2013 Zhang Gongwei. All rights reserved.
//

#import "MBSwitch.h"
#import <QuartzCore/QuartzCore.h>

@interface MBSwitch ()  <UIGestureRecognizerDelegate> {

    CAShapeLayer *_thumbLayer;
    CAShapeLayer *_fillLayer;
    CAShapeLayer *_backLayer;
    BOOL _dragging;
    BOOL _on;
}
    
@property (nonatomic, assign) BOOL pressed;
- (void) setBackgroundOn:(BOOL)on animated:(BOOL)animated;
- (void) showFillLayer:(BOOL)show animated:(BOOL) animated;
- (CGRect) thumbFrameForState:(BOOL) isOn;
@end

@implementation MBSwitch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    [self configure];
}
    
- (void) configure {
    
    if (self.frame.size.height > self.frame.size.width * 0.65) {
        self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                self.frame.size.width,
                                ceilf(self.frame.size.width * 0.65));
    }
    
    self.backgroundColor = [UIColor clearColor];
    self.tintColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
    self.onTintColor = [UIColor colorWithRed:0.27f green:0.85f blue:0.37f alpha:1.0f];
    _on = NO;
    _pressed = NO;
    _dragging = NO;
    
    _backLayer = [CAShapeLayer layer];
    _backLayer.backgroundColor = [[UIColor clearColor] CGColor];
    _backLayer.frame = self.bounds;
    _backLayer.cornerRadius = self.bounds.size.height / 2.0;
    _backLayer.path = [UIBezierPath bezierPathWithRoundedRect:_backLayer.bounds
                                                 cornerRadius:_backLayer.cornerRadius].CGPath;
    _backLayer.fillColor = self.tintColor.CGColor;
    [_backLayer setValue:[NSNumber numberWithBool:NO] forKey:@"isOn"];
    [self.layer addSublayer:_backLayer];
    
    
    _fillLayer = [CAShapeLayer layer];
    _fillLayer.backgroundColor = [[UIColor clearColor] CGColor];
    _fillLayer.frame = CGRectInset(self.bounds, 1.5, 1.5);
    _fillLayer.path = [UIBezierPath bezierPathWithRoundedRect:_fillLayer.bounds
                                                 cornerRadius:floorf(_fillLayer.bounds.size.height / 2.0)].CGPath;
    _fillLayer.fillColor = [[UIColor whiteColor] CGColor];
    [_fillLayer setValue:[NSNumber numberWithBool:YES] forKey:@"isVisible"];
    [self.layer addSublayer:_fillLayer];
    
    _thumbLayer = [CAShapeLayer layer];
    _thumbLayer.backgroundColor = [[UIColor clearColor] CGColor];
    _thumbLayer.frame = CGRectMake(1.0, 1.0, self.bounds.size.height - 2.0, self.bounds.size.height - 2.0);
    _thumbLayer.cornerRadius = self.bounds.size.height / 2.0;
    _thumbLayer.path = [UIBezierPath bezierPathWithRoundedRect:_thumbLayer.bounds
                                                  cornerRadius:_thumbLayer.cornerRadius].CGPath;
    _thumbLayer.fillColor = [[UIColor whiteColor] CGColor];
    _thumbLayer.shadowColor = [[UIColor blackColor] CGColor];
    _thumbLayer.shadowOffset = CGSizeMake(0.0, 3.0);
    _thumbLayer.shadowRadius = 3.0;
    _thumbLayer.shadowOpacity = 0.3;
    [self.layer addSublayer:_thumbLayer];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(toggleDragged:)];
    panGesture.delegate = self;
    [self addGestureRecognizer:panGesture];
}

#pragma mark -
#pragma mark Animation
    
- (BOOL) isOn {
    return _on;
}
    
- (void) setOn:(BOOL)on {
    [self setOn:on animated:NO];
}
    
- (void)setOn:(BOOL)on animated:(BOOL)animated {
    
    if (_on != on) {
        _on = on;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
    if (animated) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.3];
        [CATransaction setDisableActions:NO];
        _thumbLayer.frame = [self thumbFrameForState:_on];
        [CATransaction commit];
    } else {
        [CATransaction setDisableActions:YES];
        _thumbLayer.frame = [self thumbFrameForState:_on];
    }
    
    [self setBackgroundOn:_on animated:animated];
    [self showFillLayer:_on animated:animated];
}
    
- (void) setBackgroundOn:(BOOL)on animated:(BOOL)animated {
    BOOL isOn = [[_backLayer valueForKey:@"isOn"] boolValue];
    if (on != isOn) {
        [_backLayer setValue:[NSNumber numberWithBool:on] forKey:@"isOn"];
        if (animated) {
            CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
            colorAnimation.duration = 0.22;
            colorAnimation.fromValue = on ? (id)_tintColor.CGColor : (id)_onTintColor.CGColor;
            colorAnimation.toValue = on ? (id)_onTintColor.CGColor : (id)_tintColor.CGColor;
            colorAnimation.removedOnCompletion = NO;
            colorAnimation.fillMode = kCAFillModeForwards;
            [_backLayer addAnimation:colorAnimation forKey:@"animateColor"];
            [CATransaction commit];
        } else {
            [_backLayer removeAllAnimations];
            _backLayer.fillColor = on ? _onTintColor.CGColor : _tintColor.CGColor;
        }
    }
}
    
- (void) showFillLayer:(BOOL)show animated:(BOOL)animated {
    BOOL isVisible = [[_fillLayer valueForKey:@"isVisible"] boolValue];
    if (isVisible != show) {
        [_fillLayer setValue:[NSNumber numberWithBool:show] forKey:@"isVisible"];
        CGFloat scale = show ? 1.0 : 0.0;
        if (animated) {
            CGFloat from = show ? 0.0 : 1.0;
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"tranform.scale"];
            scaleAnimation.duration = 0.22;
            scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(from, from, 1.0)];
            scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            scaleAnimation.removedOnCompletion = NO;
            scaleAnimation.fillMode = kCAFillModeForwards;
            scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [_fillLayer addAnimation:scaleAnimation forKey:@"animateScale"];
        } else {
            [_fillLayer removeAllAnimations];
            _fillLayer.transform = CATransform3DMakeScale(scale, scale, 1.0);
        }
    }
}
    
- (void) setPressed:(BOOL)pressed {
    if (_pressed != pressed) {
        _pressed = pressed;
        
        if (!_on) {
            [self showFillLayer:!_pressed animated:YES];
        }
    }
}

#pragma mark -
#pragma mark Appearance

- (void) setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    if (![[_backLayer valueForKey:@"isOn"] boolValue]) {
        _backLayer.fillColor = _tintColor.CGColor;
    }
}

- (void) setOnTintColor:(UIColor *)onTintColor {
    _onTintColor = onTintColor;
    if (![[_backLayer valueForKey:@"isOn"] boolValue]) {
        _backLayer.fillColor = _tintColor.CGColor;
    }
}

- (void) setOffTintColor:(UIColor *)offTintColor {
    _fillLayer.fillColor = offTintColor.CGColor;
}

- (UIColor *) offTintColor {
    return [UIColor colorWithCGColor:_fillLayer.fillColor];
}

- (void) setThumbTintColor:(UIColor *)thumbTintColor {
    _thumbLayer.fillColor = thumbTintColor.CGColor;
}

- (UIColor *) thumbTintColor {
    return [UIColor colorWithCGColor:_thumbLayer.fillColor];
}

#pragma mark -
#pragma mark Interaction

- (void) tapped: (UITapGestureRecognizer *) gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self setOn:!self.on animated:YES];
    }
}

- (BOOL) isOnPosition {
    
    return CGRectGetMidX(_thumbLayer.frame) > CGRectGetMidX(self.bounds);
}

- (void) toggleDragged:(UIPanGestureRecognizer *)gesture {
    
    CGFloat minToggleX = 1.0;
    CGFloat maxToggleX = self.bounds.size.width - self.bounds.size.height + 1.0;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        self.pressed = YES;
        _dragging = YES;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [gesture translationInView:self];
        
        [CATransaction setDisableActions:YES];
        
        self.pressed = YES;
        
        CGFloat newX = _thumbLayer.frame.origin.x + translation.x;
        if (newX < minToggleX) {
            newX = minToggleX;
        }
        if (newX > maxToggleX) {
            newX = maxToggleX;
        }
        _thumbLayer.frame = CGRectMake(newX,
                                       _thumbLayer.frame.origin.y,
                                       _thumbLayer.frame.size.width,
                                       _thumbLayer.frame.size.height);
        
        if ([self isOnPosition] &&
            ![[_backLayer valueForKey:@"isOn"] boolValue] ) {
            [self setBackgroundOn:YES animated:YES];
        }
        else if (![self isOnPosition] &&
                   [[_backLayer valueForKey:@"isOn"] boolValue] ) {
            [self setBackgroundOn:NO animated:YES];
            
        }
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        
        [self setOn:[self isOnPosition] animated:YES];
        _dragging = NO;
        self.pressed = NO;
    }
    
    CGPoint locationOfTouch = [gesture locationInView:self];
    if (CGRectContainsPoint(self.bounds, locationOfTouch))
        [self sendActionsForControlEvents:UIControlEventTouchDragInside];
    else
        [self sendActionsForControlEvents:UIControlEventTouchDragOutside];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.pressed = YES;
    [self sendActionsForControlEvents:UIControlEventTouchDown];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (!_dragging)
        self.pressed = NO;
    
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    if (!_dragging)
        self.pressed = NO;
    
    [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
}
    
#pragma mark - 
#pragma mark Thumb Frame
- (CGRect) thumbFrameForState:(BOOL)isOn {
    return CGRectMake(isOn ? self.bounds.size.width-self.bounds.size.height+1.0 : 1.0,
                      1.0,
                      self.bounds.size.height-2.0,
                      self.bounds.size.height-2.0);
}

@end
