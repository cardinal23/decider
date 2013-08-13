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

@interface FillBallotViewController ()

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)submitButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *questionTextLabel;

@property (strong, nonatomic) Ballot *ballot;

@property (strong, nonatomic) NSMutableArray *rankedViews;
@property (strong, nonatomic) NSMutableArray *unrankedViews;

@property (strong, nonatomic) UILongPressGestureRecognizer *longPressRecognizer;

@property (strong, nonatomic) ChoiceControl *activeChoice;
@property (nonatomic) CGPoint activeOffset;

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
    // Do any additional setup after loading the view from its nib.
    
    self.ballot = [Ballot insertInManagedObjectContext:[AppDelegate sharedInstance].managedObjectContext];
    self.ballot.vote = self.vote;
    [self.ballot initChoicesWithManagedObjectContext:[AppDelegate sharedInstance].managedObjectContext];
    
    self.longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDetected:)];
    self.longPressRecognizer.minimumPressDuration = 0.1f;
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
}

#pragma mark - Choices Layout

- (void)layoutChoicesAnimated:(BOOL)animated
{
    void (^changesBlock)(void) = ^ {
        [self.unrankedViews enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
            ChoiceControl *choiceControl = obj;
            if (!choiceControl.active) {
                choiceControl.frame = CGRectMake(50.0f,
                                                 kChoiceTopMargin + index * KChoiceHeight,
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
    
    return MIN((NSUInteger)(floorf(((point.y - kChoiceTopMargin) / KChoiceHeight))), maxIndex);
}

#pragma mark - UILongPressGestureRecognizer

- (void)longPressDetected:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:self.view];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        for (ChoiceControl *choiceControl in self.unrankedViews) {
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
        self.activeChoice.center = CGPointMake(location.x + self.activeOffset.x, location.y + self.activeOffset.y);

        NSUInteger oldIndex = [self.unrankedViews indexOfObject:self.activeChoice];

        NSUInteger newIndex = [self indexForPoint:location withMaxIndex:[self.unrankedViews count] - 1];

//        NSLog(@"%d %d", oldIndex, newIndex);
        
        if (oldIndex != newIndex) {
            ChoiceControl *replacedChoice = [self.unrankedViews objectAtIndex:newIndex];
            
            [self.unrankedViews replaceObjectAtIndex:oldIndex withObject:replacedChoice];
            [self.unrankedViews replaceObjectAtIndex:newIndex withObject:self.activeChoice];
        }
        
        [self layoutChoicesAnimated:YES];
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        self.activeChoice.active = NO;
        self.activeChoice = nil;
        [self layoutChoicesAnimated:YES];
    }
}

@end
