//
//  MainViewController.h
//  Decider-Data
//
//  Created by Mike Dockerty on 7/24/13.
//  Copyright (c) 2013 Mike Dockerty. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
