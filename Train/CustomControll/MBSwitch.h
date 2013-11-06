//
//  MBSwitch.h
//  Train
//
//  Created by Zhang Gongwei on 11/4/13.
//  Copyright (c) 2013 Zhang Gongwei. All rights reserved.
//
//  Refer to https://github.com/mattlawer/MBSwitch
//Custom-UISwitch
//

#import <UIKit/UIKit.h>

@interface MBSwitch : UIControl

    
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *onTintColor;
@property (nonatomic, strong) UIColor *offTintColor;
@property (nonatomic, strong) UIColor *thumbTintColor;
    
@property (nonatomic, getter = isOn) BOOL on;
    
- (id)initWithFrame:(CGRect)frame;
- (void) setOn:(BOOL)on animated:(BOOL)animated;
    
@end
