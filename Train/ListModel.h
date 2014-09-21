//
//  ListModel.h
//  Train
//
//  Created by Zhang Gongwei on 10/21/13.
//  Copyright (c) 2013 Zhang Gongwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol ListModel
@end

@interface ListModel : JSONModel


@property (copy) NSString* name;
@property (copy) NSString* description;
@property (copy) NSString* controller;
@property (copy) NSString* image;
@property (nonatomic, assign) NSInteger rate;
@property (nonatomic, strong, readonly) NSArray* examples;

@end
