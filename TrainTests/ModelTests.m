//
//  ModelTests.m
//  Train
//
//  Created by Zhang Gongwei on 9/20/14.
//  Copyright (c) 2014 Zhang Gongwei. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ControllerModel.h"

@interface ModelTests : XCTestCase

@end

@implementation ModelTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testControllerModel
{
    NSBundle* testBundle = [NSBundle bundleForClass:[self class]];
    NSString* path = [testBundle pathForResource:@"TestController" ofType:@"json"];
    NSString* jsonContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    XCTAssertNotNil(jsonContents, @"Can't fetch test data TestController.json");
    
    NSError* err;
    ControllerModel* m = [[ControllerModel alloc] initWithString:jsonContents error:&err];
    
    XCTAssertNil(err, @"%@", [err localizedDescription]);
    
    XCTAssert([m.controller isEqualToString:@"ExampleListController"]);
    
}

@end
