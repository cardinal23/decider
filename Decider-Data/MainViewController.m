//
//  MainViewController.m
//  Decider-Data
//
//  Created by Mike Dockerty on 7/24/13.
//  Copyright (c) 2013 Mike Dockerty. All rights reserved.
//

#import "MainViewController.h"
#import "NewVoteViewController.h"

@interface MainViewController ()
- (IBAction)newVoteTapped:(id)sender;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - New Vote

- (IBAction)newVoteTapped:(id)sender {
    NewVoteViewController *newVoteViewController = [[NewVoteViewController alloc] initWithNibName:nil bundle:nil];
    newVoteViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:newVoteViewController animated:YES completion:nil];
    [self.navigationController pushViewController:newVoteViewController animated:YES];
}
@end
