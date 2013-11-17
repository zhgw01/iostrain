//
//  SMViewController.h
//  RotaryWheelProject
//
//  Created by cesarerocchi on 2/10/12.
//  Copyright (c) 2012 studiomagnolia.com. All rights reserved.
//
// http://www.raywenderlich.com/9864/how-to-create-a-rotating-wheel-control-with-uikit
//

#import <UIKit/UIKit.h>
#import "SMRotaryProtocol.h"

@interface SMViewController : UIViewController<SMRotaryProtocol>

@property (nonatomic, strong) UILabel *valueLabel;

@end
