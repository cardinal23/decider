//
//  ElectionViewController.h
//  Decider-Data
//
//  Created by Mike Dockerty on 8/12/13.
//  Copyright (c) 2013 Mike Dockerty. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Vote;

@interface ElectionViewController : UIViewController

@property (strong, nonatomic) Vote *vote;

@end
