//
//  ElectionViewController.m
//  Decider-Data
//
//  Created by Mike Dockerty on 8/12/13.
//  Copyright (c) 2013 Mike Dockerty. All rights reserved.
//

#import "ElectionViewController.h"
#import "FillBallotViewController.h"

#import "Vote.h"
#import "Question.h"

@interface ElectionViewController ()
- (IBAction)backButtonTapped:(id)sender;
- (IBAction)fillBallotTapped:(id)sender;
- (IBAction)calculateResultsTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *questionTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *ballotCountLabel;

@end

@implementation ElectionViewController

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

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.questionTextLabel.text = self.vote.question.text;
    self.ballotCountLabel.text = [NSString stringWithFormat:@"%d %@", [self.vote.ballots count], NSLocalizedString(@" ballots have been submitted", @"Ballot count label text")];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)fillBallotTapped:(id)sender {
    FillBallotViewController *fillBallotViewController = [[FillBallotViewController alloc] initWithVote:self.vote];
    [self.navigationController pushViewController:fillBallotViewController animated:YES];
}

- (IBAction)calculateResultsTapped:(id)sender {
}
@end
