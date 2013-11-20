//
//  ExampleListController.m
//  Train
//
//  Created by Zhang Gongwei on 10/9/13.
//  Copyright (c) 2013 Zhang Gongwei. All rights reserved.
//

#import "ExampleListController.h"
#import "Log.h"


@interface ExampleListController ()

@property (strong, readonly, nonatomic) NSArray* examples;

@end

@implementation ExampleListController



- (void) createModel:(ListModel *) model fromDict:(NSDictionary *)data
{
    ListModel* childModel = [[ListModel alloc] init];
    
    childModel.name = [data objectForKey:@"name"];
    childModel.description = [data objectForKey:@"description"];
    childModel.controller = [data objectForKey:@"controller"];
    childModel.image = [data objectForKey:@"image"];
    childModel.rate = [[data objectForKey:@"rate"] integerValue];
    
    NSArray* children = [data objectForKey:@"examples"];
    for (NSDictionary* modelData in children) {
        [self createModel:childModel fromDict:modelData];
    }

    
    [model addExample:childModel];
}


/*
- (void) createModel
{
    self.model = [[ListModel alloc] init];
    
    NSString *modelFile = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"plist"];
    NSArray *modelArray = [[NSArray alloc] initWithContentsOfFile:modelFile];
    
    for (NSDictionary* modelData in modelArray) {
        [self createModel:self.model fromDict:modelData];
    }
    
}
 */

- (ListModel *) model
{
    if (!_model) {
        _model = [[ListModel alloc] init];
        
        NSString *modelFile = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"plist"];
        NSArray *modelArray = [[NSArray alloc] initWithContentsOfFile:modelFile];
        
        for (NSDictionary* modelData in modelArray) {
            [self createModel:_model fromDict:modelData];
        }

    }
    
    return _model;
}



- (NSArray *) examples
{
    return self.model.examples;
}


- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
       // [self createModel];
        DDLogVerbose(@"Unarchive ExampleListViewController");
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.examples count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ListModel* model = [self.examples objectAtIndex:indexPath.row];
    
    // Configure the cell...
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];
    imageView.image = [UIImage imageNamed:model.image];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:102];
    titleLabel.text = model.name;
    
    UILabel *rateLabel = (UILabel *) [cell viewWithTag:103];
    rateLabel.text = model.description;
    
    UILabel *priceLabel = (UILabel *) [cell viewWithTag:104];
    priceLabel.text = [NSString stringWithFormat:@"%ld", (long)self.model.rate];
    
    return cell;
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ListModel* model = [self.examples objectAtIndex:indexPath.row];
    id controller = nil;
    
    if ([model.controller isEqualToString:@"ExampleListController"]) {
        controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ExampleListController"];
    }
    else {
        
        id controllerClass = NSClassFromString(model.controller);
        controller = [[controllerClass alloc] initWithNibName:nil bundle:nil];
    }

    if ([controller respondsToSelector:@selector(setModel:)]) {
        [controller setModel:model];
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}


@end
