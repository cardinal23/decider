//
//  NewVoteViewController.m
//  Decider-Data
//
//  Created by Mike Dockerty on 8/12/13.
//  Copyright (c) 2013 Mike Dockerty. All rights reserved.
//

#import "AppDelegate.h"

#import "NewVoteViewController.h"
#import "ElectionViewController.h"

#import "Vote.h"
#import "Question.h"

@interface NewVoteViewController () <UITableViewDataSource, UITableViewDelegate>

- (IBAction)backTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *votes;

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
    
    NSFetchRequest * allEntities = [[NSFetchRequest alloc] init];
    [allEntities setEntity:[NSEntityDescription entityForName:@"Vote"
                                       inManagedObjectContext:[AppDelegate sharedInstance].managedObjectContext]];
    
    NSError * error = nil;
    self.votes = [[AppDelegate sharedInstance].managedObjectContext executeFetchRequest:allEntities error:&error];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource Methods
     
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.votes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VoteCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VoteCellID"];
    }
    
    cell.textLabel.text = ((Vote *)self.votes[indexPath.row]).question.text;
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ElectionViewController *electionViewController = [[ElectionViewController alloc] initWithNibName:nil bundle:nil];
    electionViewController.vote = self.votes[indexPath.row];
    electionViewController.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:electionViewController animated:YES];
}

#pragma Back

- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
