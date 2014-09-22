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


@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString<Optional>* description;
@property (strong, nonatomic) NSString* controller;
@property (strong, nonatomic) NSString<Optional>* image;
@property (assign, nonatomic) NSInteger rate;
@property (strong, nonatomic) NSArray<ListModel, Optional>* controllers;

@end

@interface ExampleFile : JSONModel

@property (strong, nonatomic) NSArray<ListModel>* controllers;

@end
