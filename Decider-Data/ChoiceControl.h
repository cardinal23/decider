//
//  ChoiceControl.h
//  Decider-Data
//
//  Created by Mike Dockerty on 8/12/13.
//  Copyright (c) 2013 Mike Dockerty. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Choice;

@interface ChoiceControl : UIControl

- (id)initWithChoice:(Choice *)choice;

@property (strong, nonatomic) Choice *choice;
@property (nonatomic) BOOL active;

@end
