//
//  CreateVoteViewController.m
//  Decider-Data
//
//  Created by Mike Dockerty on 8/14/13.
//  Copyright (c) 2013 Mike Dockerty. All rights reserved.
//

#import "CreateVoteViewController.h"
#import "AppDelegate.h"

#import "Question.h"
#import "Answer.h"

@interface CreateVoteViewController () <UITableViewDataSource>

- (IBAction)addChoiceTapped:(id)sender;
- (IBAction)cancelButtonTapped:(id)sender;
- (IBAction)saveTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *questionTextField;
@property (weak, nonatomic) IBOutlet UITextField *choiceTextField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *answers;

@end

@implementation CreateVoteViewController

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
    
    self.answers = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addChoiceTapped:(id)sender {
    [self.answers addObject:self.choiceTextField.text];
    self.choiceTextField.text = @"";
    
    [self.tableView reloadData];
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveTapped:(id)sender {
    NSManagedObjectContext *context = [AppDelegate sharedInstance].managedObjectContext;
    
    Question *question = [Question insertInManagedObjectContext:context];
    question.text = self.questionTextField.text;
    
    for (NSString *answerText in self.answers) {
        Answer *answer = [Answer insertInManagedObjectContext:context];
        answer.text = answerText;
        
        [question addAnswersObject:answer];
    }
    
    [[AppDelegate sharedInstance] saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.answers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    
    cell.textLabel.text = self.answers[indexPath.row];
    
    return cell;
}

@end
