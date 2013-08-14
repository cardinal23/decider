//
//  ChoiceControl.m
//  Decider-Data
//
//  Created by Mike Dockerty on 8/12/13.
//  Copyright (c) 2013 Mike Dockerty. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ChoiceControl.h"
#import "Choice.h"
#import "Answer.h"

const CGFloat kTextLabelMargin = 35.0f;
const CGFloat kRankLabelMargin = 10.0f;
const CGFloat kLabelHeight = 22.0f;

@interface ChoiceControl ()

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UILabel *rankLabel;

@end

@implementation ChoiceControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithChoice:(Choice *)choice
{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 44.0f)];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1.0f;
        
        self.choice = choice;
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.textLabel.text = self.choice.answer.text;

        self.rankLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.rankLabel.textColor = [UIColor darkGrayColor];

        [self addSubview:self.textLabel];
        [self addSubview:self.rankLabel];
    }
    
    return self;
}

- (void)setActive:(BOOL)active
{
    _active = active;
    
    if (self.active) {
        self.backgroundColor = [UIColor colorWithRed:176.0f / 255.0f green:226.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f];
    } else {
        self.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    }
}

- (void)setRanked:(BOOL)ranked
{
    _ranked = ranked;
    
    if (self.ranked) {
        self.rankLabel.hidden = NO;
    } else {
        self.rankLabel.hidden = YES;
    }
}

- (void)setListOrder:(NSUInteger)listOrder
{
    _listOrder = listOrder;
    
    self.rankLabel.text = [NSString stringWithFormat:@"%d.", self.listOrder];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", self.choice.answer.text];
}

- (void)layoutSubviews
{
    self.textLabel.frame = CGRectMake(kTextLabelMargin,
                                      CGRectGetHeight(self.frame) / 2 - kLabelHeight / 2,
                                      CGRectGetWidth(self.frame) - kTextLabelMargin,
                                      kLabelHeight);
    
    self.rankLabel.frame = CGRectMake(kRankLabelMargin,
                                      CGRectGetHeight(self.frame) / 2 - kLabelHeight / 2,
                                      kTextLabelMargin,
                                      kLabelHeight);
}

@end
