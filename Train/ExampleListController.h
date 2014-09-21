//
//  ExampleListController.h
//
//  Reference: http://www.techotopia.com/index.php/Using_Xcode_Storyboards_to_Build_Dynamic_TableViews_with_Prototype_Table_View_Cells
//
//  Created by Zhang Gongwei on 10/9/13.
//  Copyright (c) 2013 Zhang Gongwei. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "ListModel.h"

@interface ExampleListController : UITableViewController

@property (strong, nonatomic) NSArray<ListModel>* models;

@end
