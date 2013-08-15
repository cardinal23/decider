//
//  ResultsViewController.h
//  Decider-Data
//
//  Created by Mike Dockerty on 8/15/13.
//  Copyright (c) 2013 Mike Dockerty. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Vote;

@interface ResultsViewController : UIViewController

- (id)initWithVote:(Vote *)vote;

@property (strong, nonatomic) Vote *vote;

@end
