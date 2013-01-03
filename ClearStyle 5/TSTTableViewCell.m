//
//  TSTTableViewCell.m
//  ClearStyle 5
//
//  Created by wangyongqi on 12/25/12.
//  Copyright (c) 2012 wyq. All rights reserved.
//

#import "TSTTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "TSTToDoItem.h"
#import "TSTLabel.h"

@implementation TSTTableViewCell
{
    CAGradientLayer *_gradientLayer;
    
    CGPoint _original;
    bool _deleteOnRelease;
    
    TSTLabel *_label;
    CALayer *_completedLayer;
    bool _completeOnRelease;
    
    UILabel *_crossLabel;
    UILabel *_tickLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //text label
        _label = [[TSTLabel alloc] init];
        _label.textColor = [UIColor whiteColor];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:_label];
        
        //tick label
        _tickLabel = [[UILabel alloc] init];
        _tickLabel.textColor = [UIColor greenColor];
        _tickLabel.font = [UIFont boldSystemFontOfSize:32.0f];
        _tickLabel.backgroundColor = [UIColor clearColor];
        _tickLabel.text = @"✓";
        _tickLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_tickLabel];
        
        //cross label
        _crossLabel = [[UILabel alloc] init];
        _crossLabel.textColor = [UIColor whiteColor];
        _crossLabel.font = [UIFont boldSystemFontOfSize:32.0f];
        _crossLabel.backgroundColor = [UIColor clearColor];
        _crossLabel.text = @"✗";
        _crossLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_crossLabel];
        
        //增加渐变层
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
        
        //completed layer
        _completedLayer = [CALayer layer];
        _completedLayer.frame = self.bounds;
        _completedLayer.backgroundColor = [[UIColor colorWithRed:0.0f green:0.6f blue:0.0f alpha:1.0f] CGColor];
        [self.layer insertSublayer:_completedLayer atIndex:0];
        
        //配置手势
        UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        gestureRecognizer.delegate = self;
        
        [self addGestureRecognizer:gestureRecognizer];
    }
    return self;
}

const float LABEL_LEFTMARGIN = 15.0f;
const float CUELABEL_MARGIN = 15.0f;
const float CUELABEL_WIDTH = 50.0f;

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _gradientLayer.frame = self.bounds;
    
    _label.frame = CGRectMake(LABEL_LEFTMARGIN, 0.0f, self.bounds.size.width - LABEL_LEFTMARGIN, self.bounds.size.height);
    
    _completedLayer.frame = self.bounds;
    _completedLayer.hidden = !self.toDoItem.completed;
    
    _tickLabel.frame = CGRectMake(self.frame.origin.x - CUELABEL_WIDTH - CUELABEL_MARGIN, 0.0f, CUELABEL_WIDTH, self.bounds.size.height);
    _crossLabel.frame = CGRectMake(self.frame.origin.x + self.bounds.size.width + CUELABEL_MARGIN, 0.0f, CUELABEL_WIDTH, self.bounds.size.height);
    
}

-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translationInView = [gestureRecognizer translationInView:[super superview]];
    return fabsf(translationInView.x) > fabsf(translationInView.y);
}

-(void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _original = self.frame.origin;
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translationInView = [gestureRecognizer translationInView:self];
        self.frame = CGRectMake(_original.x + translationInView.x, _original.y, self.frame.size.width, self.frame.size.height);
        
        _deleteOnRelease = _original.x + translationInView.x < - self.bounds.size.width / 2;
        
        _completeOnRelease = _original.x + translationInView.x > self.bounds.size.width / 2;
        
        float alpha = fabsf(_original.x +translationInView.x) / fabsf(self.bounds.size.width / 2);

        _crossLabel.textColor = alpha > 1.0f ? [UIColor redColor] : [UIColor colorWithWhite:1.0f alpha:alpha];
        _tickLabel.textColor = alpha > 1.0f ? [UIColor greenColor] : [UIColor colorWithWhite:1.0f alpha:alpha];

    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (!_deleteOnRelease) {
            [UIView animateWithDuration:0.2f animations:^{
                self.frame = CGRectMake(0, _original.y, self.bounds.size.width, self.bounds.size.height);
            }];
        }
        
        if (_deleteOnRelease) {
            [self.delegate deleteToDoItem:self.toDoItem];
        }
        
        if (_completeOnRelease) {
            self.toDoItem.completed = YES;
            _completedLayer.hidden = NO;
            _label.strikethrough = YES;
            
        }
    }
}

-(void)setToDoItem:(TSTToDoItem *)toDoItem
{
    _toDoItem = toDoItem;
    _label.text = toDoItem.text;
    _completedLayer.hidden = !toDoItem.completed;
}

@end
