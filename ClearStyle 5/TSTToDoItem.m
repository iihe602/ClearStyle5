//
//  TSTToDoItem.m
//  ClearStyle 5
//
//  Created by wangyongqi on 12/25/12.
//  Copyright (c) 2012 wyq. All rights reserved.
//

#import "TSTToDoItem.h"

@implementation TSTToDoItem

-(TSTToDoItem *)initWithText:(NSString *)text
{
    self = [super init];
    if (self) {
        self.text = text;
    }
    
    return self;
    
}

+(TSTToDoItem *)toDoItemWithText:(NSString *)text
{
    return [[TSTToDoItem alloc] initWithText:text];
}

@end
