//
//  TSTToDoItem.h
//  ClearStyle 5
//
//  Created by wangyongqi on 12/25/12.
//  Copyright (c) 2012 wyq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSTToDoItem : NSObject

@property (nonatomic, copy) NSString *text;

-(TSTToDoItem *)initWithText:(NSString *)text;

+(TSTToDoItem *)toDoItemWithText:(NSString *)text;

@end
