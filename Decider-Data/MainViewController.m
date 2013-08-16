//
//  MainViewController.m
//  Decider-Data
//
//  Created by Mike Dockerty on 7/24/13.
//  Copyright (c) 2013 Mike Dockerty. All rights reserved.
//

#import "MainViewController.h"
#import "NewVoteViewController.h"
#import "ElectionViewController.h"
#import "AppDelegate.h"

#import "Vote.h"
#import "Question.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

- (IBAction)newVoteTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *previousVotes;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSFetchRequest * allEntities = [[NSFetchRequest alloc] init];
    [allEntities setEntity:[NSEntityDescription entityForName:@"Vote"
                                       inManagedObjectContext:[AppDelegate sharedInstance].managedObjectContext]];
    
    NSError * error = nil;
    self.previousVotes = [[AppDelegate sharedInstance].managedObjectContext executeFetchRequest:allEntities error:&error];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.timeStyle = NSDateFormatterShortStyle;
    self.dateFormatter.dateStyle = NSDateFormatterMediumStyle;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSFetchRequest * allEntities = [[NSFetchRequest alloc] init];
    [allEntities setEntity:[NSEntityDescription entityForName:@"Vote"
                                       inManagedObjectContext:[AppDelegate sharedInstance].managedObjectContext]];
    
    NSError * error = nil;
    self.previousVotes = [[AppDelegate sharedInstance].managedObjectContext executeFetchRequest:allEntities error:&error];
    
    [self.tableView reloadData];
}

#pragma mark - New Vote

- (IBAction)newVoteTapped:(id)sender {
    NewVoteViewController *newVoteViewController = [[NewVoteViewController alloc] initWithNibName:nil bundle:nil];
    newVoteViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:newVoteViewController animated:YES completion:nil];
    [self.navigationController pushViewController:newVoteViewController animated:YES];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.previousVotes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kPreviousVoteCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"kPreviousVoteCell"];
    }
    
    Vote *vote = self.previousVotes[indexPath.row];
    cell.textLabel.text = vote.question.text;
    
    NSString *dateString = [self.dateFormatter stringFromDate:vote.timestamp];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %d ballots", dateString, [vote.ballots.allObjects count]];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Vote *vote = self.previousVotes[indexPath.row];
    
    ElectionViewController *electionViewController = [[ElectionViewController alloc] initWithNibName:nil bundle:nil];
    electionViewController.vote = vote;
    [self.navigationController pushViewController:electionViewController animated:YES];
}

@end
