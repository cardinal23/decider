//
//  ResultsViewController.m
//  Decider-Data
//
//  Created by Mike Dockerty on 8/15/13.
//  Copyright (c) 2013 Mike Dockerty. All rights reserved.
//

#import "ResultsViewController.h"

#import "Vote.h"

@interface ResultsViewController () <UITableViewDataSource>

- (IBAction)cancelTapped:(id)sender;

@property (strong, nonatomic) NSArray *results;

@end

@implementation ResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithVote:(Vote *)vote
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.vote = vote;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.results = [self.vote getResultsList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    
    cell.textLabel.text = self.results[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (IBAction)cancelTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
