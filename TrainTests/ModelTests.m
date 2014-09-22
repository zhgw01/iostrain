//
//  ModelTests.m
//  Train
//
//  Created by Zhang Gongwei on 9/20/14.
//  Copyright (c) 2014 Zhang Gongwei. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ControllerModel.h"
#import "ListModel.h"

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


-(void)testListModel
{
    NSString* json = [self getJson:@"TestOptional"];
    XCTAssertNotNil(json, @"Can't fetch test data TestOptional.json");
    
    NSError* err;
    ExampleFile* m = [[ExampleFile alloc] initWithString:json error:&err];
    XCTAssertNil(err, @"%@", [err localizedDescription]);
    
    XCTAssert([m.controllers count] == 2);
    
    ListModel* firstModel = [m.controllers objectAtIndex:0];
    XCTAssertNotNil(firstModel);
    XCTAssert([firstModel.controllers count] == 1, @"first ListModel has child controllers");
    
    ListModel* secondModel = [m.controllers objectAtIndex:1];
    XCTAssertNotNil(secondModel);
    XCTAssertNil(secondModel.controllers, @"Second ListModel don't have a child");
    
}

#pragma mark - helper function

-(NSString*) getJson: (NSString*)filename
{
    NSBundle* testBundle = [NSBundle bundleForClass:[self class]];
    NSString* path = [testBundle pathForResource:filename ofType:@"json"];
    NSString* jsonContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    return jsonContents;
}

@end
