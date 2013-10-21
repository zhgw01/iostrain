//
//  ListModel.m
//  Train
//
//  Created by Zhang Gongwei on 10/21/13.
//  Copyright (c) 2013 Zhang Gongwei. All rights reserved.
//

#import "ListModel.h"

@interface ListModel ()

@property (strong, nonatomic) NSMutableArray* internalModels;

@end

@implementation ListModel


- (id) init
{
    self = [super init];
    if (self) {
        self.internalModels = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *) examples
{
    return [self.internalModels copy];
}

- (void) addExample:(ListModel *)example
{
    [self.internalModels addObject:example];
}

@end
