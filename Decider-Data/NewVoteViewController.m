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
#import "CreateVoteViewController.h"

#import "Vote.h"
#import "Question.h"

@interface NewVoteViewController () <UITableViewDataSource, UITableViewDelegate>

- (IBAction)backTapped:(id)sender;
- (IBAction)createNewVoteTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *questions;

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
    [allEntities setEntity:[NSEntityDescription entityForName:@"Question"
                                       inManagedObjectContext:[AppDelegate sharedInstance].managedObjectContext]];
    
    NSError * error = nil;
    self.questions = [[AppDelegate sharedInstance].managedObjectContext executeFetchRequest:allEntities error:&error];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource Methods
     
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VoteCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VoteCellID"];
    }
    
    cell.textLabel.text = ((Question *)self.questions[indexPath.row]).text;
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Vote *vote = [Vote insertInManagedObjectContext:[AppDelegate sharedInstance].managedObjectContext];
    vote.question = self.questions[indexPath.row];
    vote.timestamp = [NSDate date];
    
    ElectionViewController *electionViewController = [[ElectionViewController alloc] initWithNibName:nil bundle:nil];
    electionViewController.vote = vote;
    electionViewController.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:electionViewController animated:YES];
}

#pragma Back

- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)createNewVoteTapped:(id)sender {
    CreateVoteViewController *createVoteViewController = [[CreateVoteViewController alloc] initWithNibName:nil bundle:nil];
    createVoteViewController.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:createVoteViewController animated:YES];
}

@end
