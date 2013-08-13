#import "Ballot.h"
#import "Vote.h"
#import "Question.h"
#import "Choice.h"
#import "Answer.h"

@interface Ballot ()

// Private interface goes here.

@end


@implementation Ballot

- (void)initChoicesWithManagedObjectContext:(NSManagedObjectContext *)context
{
    NSSet *answers = self.vote.question.answers;
    
    for (Answer *answer in answers) {
        Choice *choice = [Choice insertInManagedObjectContext:context];
        
        choice.answer = answer;
        choice.rank = @(-1);
        [self addChoicesObject:choice];
    }
}

- (BOOL) isAnswerA:(Answer *)answerA rankedHigherThanAnswerB:(Answer *)answerB
{
    Choice *choiceA = nil;
    Choice *choiceB = nil;
    
    if (answerA == answerB) {
        return NO;
    }
    
    for (Choice *choice in self.choices) {
        if (choice.answer == answerA) {
            choiceA = choice;
        }
        
        if (choice.answer == answerB) {
            choiceB = choice;
        }
    }
    
//    NSLog(@"%@:%@, %@:%@", choiceA.answer.text, choiceA.rank, choiceB.answer.text, choiceB.rank);
    
    return [choiceA.rank integerValue] > [choiceB.rank integerValue];
}

- (NSString *)description
{
    NSMutableString *choicesString = [[NSMutableString alloc] init];
    
    for (Choice *choice in self.choices) {
        [choicesString appendString:[ NSString stringWithFormat:@"%@:%d|", choice.answer.text, [choice.rank integerValue]]];
    }
    
    return choicesString;
}

@end
