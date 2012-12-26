//
//  TSTTableViewCellDelegate.h
//  ClearStyle 5
//
//  Created by wangyongqi on 12/25/12.
//  Copyright (c) 2012 wyq. All rights reserved.
//

@class TSTToDoItem;

#import <Foundation/Foundation.h>

@protocol TSTTableViewCellDelegate <NSObject>

-(void)deleteToDoItem:(TSTToDoItem *) toDoItem;

@end
