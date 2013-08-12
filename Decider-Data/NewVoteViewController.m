//
//  NewVoteViewController.m
//  Decider-Data
//
//  Created by Mike Dockerty on 8/12/13.
//  Copyright (c) 2013 Mike Dockerty. All rights reserved.
//

#import "NewVoteViewController.h"

@interface NewVoteViewController () <UITableViewDataSource>

@end

@implementation NewVoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
     
#pragma mark - UITableViewDataSource Methods
     
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

}


@end
