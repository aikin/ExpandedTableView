//
//  ExpandedViewController.m
//  ExpandedTableView
//
//  Created by xyooyy on 13-11-24.
//  Copyright (c) 2013年 lunajin. All rights reserved.
//

#import "ExpandedViewController.h"

@interface ExpandedViewController (){
    
    ExpandedTableView *expandedTableView;
}

@end

@implementation ExpandedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    expandedTableView = [[ExpandedTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	expandedTableView.expandedTableViewDelegate = self;
    NSArray *items = [NSArray arrayWithObjects:@"2", @"3", @"4", @"5", nil];
    NSArray *secondItems = [NSArray arrayWithObjects:@"2", @"3", @"4", nil];
    [expandedTableView setSectionTitle:@"First" itemsForSection:items];
    [expandedTableView setSectionTitle:@"Second" itemsForSection:secondItems];
    [self.view addSubview:expandedTableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ExpandedTableViewDelegate Methods
- (void)didSelectItemsAtIndexPath:(NSIndexPath *)indexpath
{
    
    
    
}

@end
