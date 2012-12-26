//
//  TSTLabel.m
//  ClearStyle 5
//
//  Created by wangyongqi on 12/25/12.
//  Copyright (c) 2012 wyq. All rights reserved.
//

#import "TSTLabel.h"
#import <QuartzCore/QuartzCore.h>

@implementation TSTLabel
{
    CALayer *_strikethroughLayer;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _strikethroughLayer = [CALayer layer];
        _strikethroughLayer.backgroundColor = [[UIColor whiteColor] CGColor];
        _strikethroughLayer.hidden = YES;
        [self.layer addSublayer:_strikethroughLayer];
        
    }
    return self;
}

float STRIKETHROUGHT_THICKNESS = 2.0F;

- (void)resizeStrikethrough
{
    CGSize textSize = [self.text sizeWithFont:self.font];
    _strikethroughLayer.frame = CGRectMake(0, self.frame.size.height / 2, textSize.width, STRIKETHROUGHT_THICKNESS);
//    _strikethroughLayer.hidden = !_strikethrough;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self resizeStrikethrough];

}

-(void)setText:(NSString *)text
{
    [super setText:text];
    [self resizeStrikethrough];
}

-(void)setStrikethrough:(bool)strickthrough
{
    _strikethrough = strickthrough;
    _strikethroughLayer.hidden = !strickthrough;
}

@end
