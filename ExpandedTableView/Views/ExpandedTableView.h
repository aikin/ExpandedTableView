//
//  ExpandedTableView.h
//  ExpandedTableView
//
//  Created by xyooyy on 13-11-24.
//  Copyright (c) 2013年 lunajin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ExpandedTableViewDelegate;


@interface ExpandedTableView : UITableView


@property (weak, nonatomic) id<ExpandedTableViewDelegate>expandedTableViewDelegate;


- (void)setSectionTitle:(NSString *)sectionTitle itemsForSection:(NSArray *)items;


@end


@protocol ExpandedTableViewDelegate <NSObject>

- (void)didSelectItemsAtIndexPath:(NSIndexPath *)indexpath;


@end