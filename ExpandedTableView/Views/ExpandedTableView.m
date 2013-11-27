//
//  ExpandedTableView.m
//  ExpandedTableView
//
//  Created by xyooyy on 13-11-24.
//  Copyright (c) 2013年 lunajin. All rights reserved.
//

#import "ExpandedTableView.h"

@interface ExpandedTableView () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *allSectionAndItems;
@property (strong, nonatomic) NSMutableArray *isExpanding;

@end


@implementation ExpandedTableView

@synthesize allSectionAndItems = _allSectionAndItems, isExpanding = _isExpanding;

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.allSectionAndItems = [[NSMutableArray alloc] init];
        self.isExpanding = [[NSMutableArray alloc] init];
    }
    
    return self;
    
}


#pragma mark - Public Method
- (void)setSectionTitle:(NSString *)sectionTitle itemsForSection:(NSArray *)items
{
    
    NSMutableArray *sectionAndItems = [[NSMutableArray alloc] init];
    [sectionAndItems addObject:sectionTitle];
    for (NSString *item in items) {
        [sectionAndItems addObject: item];
    }
    
    [self.allSectionAndItems addObject:sectionAndItems];
    [self.isExpanding addObject:[NSNumber numberWithBool:NO]];
    [self reloadData];
    
}



#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [self.allSectionAndItems count];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (![[self.isExpanding objectAtIndex:section] boolValue])
        return 1;
    else
        return [[self.allSectionAndItems objectAtIndex:section] count];
        
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *sectionsCellIdentifier = @"sectonCellIdentifier";
    static NSString *itemsCellIdentifier = @"itemsCellIdentifier";
    NSString *cellIdentifier = indexPath.row == 0 ? sectionsCellIdentifier :itemsCellIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        if (indexPath.row == 0)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionsCellIdentifier];
        else
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemsCellIdentifier];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self changeArrowDirection:cell cellForRowAtIndexpath:indexPath];
    NSMutableArray *indexSection = [self.allSectionAndItems objectAtIndex:indexPath.section];
    cell.textLabel.text = [indexSection objectAtIndex:indexPath.row];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([[self.isExpanding objectAtIndex:indexPath.section] boolValue])
        [self.isExpanding setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:indexPath.section];
    else
        [self.isExpanding setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:indexPath.section];
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    [self.expandedTableViewDelegate didSelectItemsAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - Private Method
- (void)changeArrowDirection:(UITableViewCell *)cell cellForRowAtIndexpath:(NSIndexPath *)indexPath
{
    
    if ([[self.isExpanding objectAtIndex:indexPath.section] boolValue] && indexPath.row == 0)
        cell.imageView.image = [UIImage imageNamed:@"UPAccessory.png"];
    else if (indexPath.row == 0)
        cell.imageView.image = [UIImage imageNamed:@"DownAccessory.png"];
    
}


@end
