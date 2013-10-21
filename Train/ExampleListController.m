//
//  ExampleListController.m
//  Train
//
//  Created by Zhang Gongwei on 10/9/13.
//  Copyright (c) 2013 Zhang Gongwei. All rights reserved.
//

#import "ExampleListController.h"


@interface ExampleListController ()

@property (strong, readonly, nonatomic) NSArray* examples;

@end

@implementation ExampleListController

- (void) createModel
{
    self.model = [[ListModel alloc] init];
    
    //better to read from a file or register based
    ListModel* animationModel = [[ListModel alloc] init];
    animationModel.name = @"Core Animation";
    animationModel.description = @"example of core animation";
    animationModel.rate = 5;
    animationModel.controller = @"ExampleListController";
    animationModel.image = @"bull";
    
    [self.model addExample:animationModel];
    
    
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
        [self createModel];
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
    priceLabel.text = [NSString stringWithFormat:@"%d", self.model.rate];
    
    return cell;
}

#pragma mark - Table view delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ListModel* model = [self.examples objectAtIndex:indexPath.row];
    id controllerClass = NSClassFromString(model.controller);
    id controller = [[controllerClass alloc] init];
    [controller setModel:model];
    
    [self.navigationController pushViewController:controller animated:YES];
}


@end
