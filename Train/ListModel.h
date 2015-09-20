//
//  ListModel.h
//  Train
//
//  Created by Zhang Gongwei on 10/21/13.
//  Copyright (c) 2013 Zhang Gongwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject


@property (copy) NSString* name;
@property (copy) NSString* desc;
@property (copy) NSString* controller;
@property (copy) NSString* image;
@property (nonatomic, assign) NSInteger rate;
@property (nonatomic, strong, readonly) NSArray* examples;

- (void) addExample: (ListModel *) example;

@end
