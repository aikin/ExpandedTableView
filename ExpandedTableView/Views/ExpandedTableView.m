//
//  ExpandedTableView.m
//  ExpandedTableView
//
//  Created by xyooyy on 13-11-24.
//  Copyright (c) 2013年 lunajin. All rights reserved.
//

#import "ExpandedTableView.h"

@interface ExpandedTableView () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *allSectionsAndItems;
@property (strong, nonatomic) NSMutableArray *isExpanding;

@end


@implementation ExpandedTableView

@synthesize allSectionsAndItems = _allSectionsAndItems, isExpanding = _isExpanding;


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.allSectionsAndItems = [[NSMutableArray alloc] init];
        self.isExpanding = [[NSMutableArray alloc] init];
        
    }
    
    return self;
    
}


- (id)initWithFrame:(CGRect)frame
{
    
    return [self initWithFrame:frame style:UITableViewStylePlain];
    
}


#pragma mark - Public Method
- (void)setSectionTitle:(NSString *)sectionTitle itemsForSection:(NSArray *)items
{
    
    NSMutableArray *sectionAndItems = [[NSMutableArray alloc] init];
    [sectionAndItems addObject:sectionTitle];
    for (NSString *item in items) {
        [sectionAndItems addObject: item];
    }
    
    [self.allSectionsAndItems addObject:sectionAndItems];
    [self.isExpanding addObject:[NSNumber numberWithBool:NO]];
    [self reloadData];
    
}



#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [self.allSectionsAndItems count];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (![[self.isExpanding objectAtIndex:section] boolValue])
        return 1;
    else
        return [[self.allSectionsAndItems objectAtIndex:section] count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *sectionsCellIdentifier = @"sectionCellIdentifier";
    static NSString *itemsCellIdentifier = @"itemsCellIdentifier";
    NSString *cellIdentifier = indexPath.row == 0 ? sectionsCellIdentifier : itemsCellIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil && indexPath.row == 0)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionsCellIdentifier];
    else
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemsCellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self changeArrowDirection:cell cellForRowAtIndexpath:indexPath];
    NSMutableArray *indexSection = [self.allSectionsAndItems objectAtIndex:indexPath.section];
    cell.textLabel.text = [indexSection objectAtIndex:indexPath.row];
    return cell;
    
}


#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self convertExpandingStatus:indexPath];
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    [self.expandedTableViewDelegate didSelectItemsAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - Private Method
- (void)changeArrowDirection:(UITableViewCell *)cell cellForRowAtIndexpath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        NSArray *imagesName = [NSArray arrayWithObjects:@"DownArrow.png", @"UPArrow.png", nil];
        NSUInteger index = [[self.isExpanding objectAtIndex:indexPath.section] integerValue];
        cell.imageView.image = [UIImage imageNamed:[imagesName objectAtIndex:index]];
        
    }
//    if ([[self.isExpanding objectAtIndex:indexPath.section] boolValue] && indexPath.row == 0)
//        cell.imageView.image = [UIImage imageNamed:@"UPArrow.png"];
//    else if (indexPath.row == 0)
//        cell.imageView.image = [UIImage imageNamed:@"DownArrow.png"];
    
}


- (void)convertExpandingStatus:(NSIndexPath *)indexPath
{
    
    BOOL isExpanded = [[self.isExpanding objectAtIndex:indexPath.section] boolValue] == NO ? YES : NO;
    [self.isExpanding setObject:[NSNumber numberWithBool:isExpanded] atIndexedSubscript:indexPath.section];
//    if([[self.isExpanding objectAtIndex:indexPath.section] boolValue])
//        [self.isExpanding setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:indexPath.section];
//    else
//        [self.isExpanding setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:indexPath.section];
    
}


@end
