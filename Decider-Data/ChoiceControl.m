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
        
        NSLog(@"%@", self.choice.answer.text);
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, self.frame.size.width - 20.0f, 44.0f)];
        self.textLabel.text = self.choice.answer.text;
        
        [self addSubview:self.textLabel];
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

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", self.choice.answer.text];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
