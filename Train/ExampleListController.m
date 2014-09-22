//
//  ExampleListController.m
//  Train
//
//  Created by Zhang Gongwei on 10/9/13.
//  Copyright (c) 2013 Zhang Gongwei. All rights reserved.
//

#import "ExampleListController.h"
#import "Log.h"


@implementation ExampleListController


- (id) init
{
    if (self = [super init]) {
        _topLevel = YES;
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        DDLogVerbose(@"Unarchive ExampleListViewController");
        _topLevel = YES;
    }
    return self;
}

#pragma mark - View Event
-(void)viewDidLoad
{
    if (self.models) {
        DDLogInfo(@"Model has been set");
    } else if(self.topLevel){
        DDLogInfo(@"We will load model from controllers.json");
        NSString *path = [[NSBundle mainBundle] pathForResource:@"controllers" ofType:@"json"];
        NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        NSError* err;
        ExampleFile* example = [[ExampleFile alloc] initWithString:json error:&err];
        if (err) {
            DDLogError(@"Unable to convert to ExampleFile: %@", [err localizedDescription]);
        }else {
            self.models = example.controllers;
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.models count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ListModel* model = [self.models objectAtIndex:indexPath.row];
    
    // Configure the cell...
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];
    imageView.image = [UIImage imageNamed:model.image];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:102];
    titleLabel.text = model.name;
    
    UILabel *rateLabel = (UILabel *) [cell viewWithTag:103];
    rateLabel.text = model.description;
    
    UILabel *priceLabel = (UILabel *) [cell viewWithTag:104];
    priceLabel.text = [NSString stringWithFormat:@"%ld", (long)model.rate];
    
    return cell;
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ListModel* model = [self.models objectAtIndex:indexPath.row];
    id controller = nil;
    
    if ([model.controller isEqualToString:@"ExampleListController"]) {
        controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ExampleListController"];
        [controller setModels:model.controllers];
        [controller setTopLevel:NO];
        
    }
    else {
        
        id controllerClass = NSClassFromString(model.controller);
        controller = [[controllerClass alloc] initWithNibName:nil bundle:nil];
    }

    
    [self.navigationController pushViewController:controller animated:YES];
}


@end
