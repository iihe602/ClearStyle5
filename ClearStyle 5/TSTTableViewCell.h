//
//  TSTTableViewCell.h
//  ClearStyle 5
//
//  Created by wangyongqi on 12/25/12.
//  Copyright (c) 2012 wyq. All rights reserved.
//

@class TSTToDoItem;

#import <UIKit/UIKit.h>
#import "TSTTableViewCellDelegate.h"

@interface TSTTableViewCell : UITableViewCell<UIGestureRecognizerDelegate>

@property (nonatomic, strong) id<TSTTableViewCellDelegate> delegate;
@property (nonatomic, strong) TSTToDoItem *toDoItem;

@end
