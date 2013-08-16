//
//  FillBallotViewController.m
//  Decider-Data
//
//  Created by Mike Dockerty on 8/12/13.
//  Copyright (c) 2013 Mike Dockerty. All rights reserved.
//

#import "AppDelegate.h"
#import "FillBallotViewController.h"
#import "ChoiceControl.h"

#import "Vote.h"
#import "Question.h"
#import "Ballot.h"
#import "Choice.h"
#import "Answer.h"

const CGFloat kChoiceTopMargin = 200.0f;
const CGFloat kChoiceWidth = 400.0f;
const CGFloat KChoiceHeight = 66.0f;
const CGFloat kChoiceUnrankedMargin = 50.0f;
const CGFloat kChoiceRankedMargin = 572.0f;

@interface FillBallotViewController () <UIGestureRecognizerDelegate>

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)submitButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *questionTextLabel;

@property (strong, nonatomic) Ballot *ballot;

@property (strong, nonatomic) NSMutableArray *rankedViews;
@property (strong, nonatomic) NSMutableArray *unrankedViews;

@property (strong, nonatomic) UILongPressGestureRecognizer *longPressRecognizer;

@property (strong, nonatomic) ChoiceControl *activeChoice;
@property (nonatomic) CGPoint activeOffset;
@property (strong, nonatomic) NSMutableArray *activeList;

@end

@implementation FillBallotViewController

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
    
    self.ballot = [Ballot insertInManagedObjectContext:[AppDelegate sharedInstance].managedObjectContext];
    self.ballot.vote = self.vote;
    [self.ballot initChoicesWithManagedObjectContext:[AppDelegate sharedInstance].managedObjectContext];
    
    self.longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDetected:)];
    self.longPressRecognizer.minimumPressDuration = 0.0f;
    self.longPressRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.longPressRecognizer];
    
    self.unrankedViews = [NSMutableArray array];
    self.rankedViews = [NSMutableArray array];
    
    for (Choice *choice in self.ballot.choices) {
        ChoiceControl *choiceControl = [[ChoiceControl alloc] initWithChoice:choice];
        
        [self.view addSubview:choiceControl];
        if ([choice.rank integerValue] == -1) {
            [self.unrankedViews addObject:choiceControl];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.questionTextLabel.text = self.vote.question.text;
    
    [self layoutChoicesAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonTapped:(id)sender {
    [self.vote addBallotsObject:self.ballot];
    [[AppDelegate sharedInstance] saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setRankForRankedList
{
    [self.rankedViews enumerateObjectsUsingBlock:^(ChoiceControl *choiceControl, NSUInteger index, BOOL *stop) {
        choiceControl.choice.rank = @([self.rankedViews count] - index);
        choiceControl.listOrder = index + 1;
    }];
}

#pragma mark - Choices Layout

- (void)layoutChoicesAnimated:(BOOL)animated
{
    void (^changesBlock)(void) = ^ {
        [self.unrankedViews enumerateObjectsUsingBlock:^(ChoiceControl *choiceControl, NSUInteger index, BOOL *stop) {
            if (!choiceControl.active) {
                choiceControl.frame = CGRectMake(kChoiceUnrankedMargin,
                                                 kChoiceTopMargin + index * (KChoiceHeight - 1.0f),
                                                 kChoiceWidth,
                                                 KChoiceHeight);
            }
        }];
        
        [self.rankedViews enumerateObjectsUsingBlock:^(ChoiceControl *choiceControl, NSUInteger index, BOOL *stop) {
            if (!choiceControl.active) {
                choiceControl.frame = CGRectMake(kChoiceRankedMargin,
                                                 kChoiceTopMargin + index * (KChoiceHeight - 1.0f),
                                                 kChoiceWidth,
                                                 KChoiceHeight);
            }
        }];
    };
    
    if (animated) {
        [UIView animateWithDuration:0.25f animations:changesBlock];
    } else {
        changesBlock();
    }
}

- (NSUInteger)indexForPoint:(CGPoint)point withMaxIndex:(NSUInteger)maxIndex
{
    if (point.y < kChoiceTopMargin) {
        return 0;
    }
    
    return MIN(maxIndex, (NSUInteger)(floorf(((point.y - kChoiceTopMargin) / KChoiceHeight))));
}

#pragma mark - UILongPressGestureRecognizer

- (void)longPressDetected:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:self.view];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.activeList = location.x < self.view.center.x ? self.unrankedViews : self.rankedViews;

        for (ChoiceControl *choiceControl in self.activeList) {
            if (CGRectContainsPoint(choiceControl.frame, location)) {
                choiceControl.active = YES;
                self.activeChoice = choiceControl;
                [self.view bringSubviewToFront:self.activeChoice];
                
                CGPoint locationInChoice = [gestureRecognizer locationInView:self.activeChoice];
                self.activeOffset = CGPointMake(CGRectGetWidth(self.activeChoice.frame) / 2 - locationInChoice.x, CGRectGetHeight(self.activeChoice.frame) / 2 - locationInChoice.y);
            }
        }
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (self.activeChoice) {
            self.activeChoice.center = CGPointMake(location.x + self.activeOffset.x, location.y + self.activeOffset.y);
            
            NSMutableArray *newActiveList = self.activeChoice.center.x < self.view.center.x ? self.unrankedViews : self.rankedViews;
            
            if (newActiveList != self.activeList) {
                [self.activeList removeObject:self.activeChoice];
                self.activeList = newActiveList;
                
                if (self.activeList == self.rankedViews) {
                    self.activeChoice.ranked = YES;
                } else {
                    self.activeChoice.ranked = NO;
                }
            }
            
            if ([self.activeList containsObject:self.activeChoice]) {
                NSUInteger oldIndex = [self.activeList indexOfObject:self.activeChoice];
                NSUInteger newIndex = [self indexForPoint:location withMaxIndex:[self.activeList count] - 1];

                if (oldIndex != newIndex) {
                    ChoiceControl *replacedChoice = [self.activeList objectAtIndex:newIndex];
                    [self.activeList replaceObjectAtIndex:oldIndex withObject:replacedChoice];
                    [self.activeList replaceObjectAtIndex:newIndex withObject:self.activeChoice];
                }
            } else {
                if ([self.activeList count] == 0) {
                    [self.activeList addObject:self.activeChoice];
                } else {
                    [self.activeList insertObject:self.activeChoice atIndex:[self indexForPoint:location withMaxIndex:[self.activeList count]]];
                }
            }
            
            [self setRankForRankedList];
            [self layoutChoicesAnimated:YES];
        }
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        self.activeChoice.active = NO;
        self.activeChoice = nil;
        self.activeList = nil;
        [self layoutChoicesAnimated:YES];
    }
}

#pragma mark - UIGestureRecognizerDelegate Methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch locationInView:self.view].y <= 50) {
        return NO;
    }
    
    return YES;
}

@end
