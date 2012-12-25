//
//  TSTTableViewCell.m
//  ClearStyle 5
//
//  Created by wangyongqi on 12/25/12.
//  Copyright (c) 2012 wyq. All rights reserved.
//

#import "TSTTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TSTTableViewCell
{
    CAGradientLayer *_gradientLayer;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.colors = @[
            (id)[[UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
            (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
            (id)[[UIColor clearColor] CGColor],
            (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor]
        ];
        _gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];
        [self.layer insertSublayer:_gradientLayer atIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _gradientLayer.frame = self.bounds;
}

@end
