#import "Vote.h"
#import "Question.h"
#import "Answer.h"
#import "Ballot.h"

@interface Vote ()

// Private interface goes here.

@end


@implementation Vote

+ (Vote *)voteWithQuestion:(Question *)question andManagedContext:(NSManagedObjectContext *)context
{
    Vote *vote = [Vote insertInManagedObjectContext:context];
    vote.question = question;
    vote.timestamp = [NSDate date];
    
    return vote;
}

- (NSString *)keyFromAnswerA:(Answer *)answerA andAnswerB:(Answer *)answerB
{
    return [NSString stringWithFormat:@"%@ -> %@", answerA.text, answerB.text];
}

- (NSDictionary *)makePreferenceDiGraph
{
    NSMutableDictionary *preferences = [NSMutableDictionary dictionary];
    
    NSSet *answers = self.question.answers;
    
    for (Answer *answerA in answers) {
        for (Answer *answerB in answers) {
            if (answerA == answerB) {
                continue;
            }
            
            for (Ballot *ballot in self.ballots) {
//                NSLog(@"%@ - %@ %@", ballot, answerA.text, answerB.text);
                if ([ballot isAnswerA:answerA rankedHigherThanAnswerB:answerB]) {
                    preferences[[self keyFromAnswerA:answerA andAnswerB:answerB]] = @([preferences[[self keyFromAnswerA:answerA andAnswerB:answerB]] integerValue] + 1);
                    
                }
            }
        }
    }
    
    NSLog(@"%@", preferences);

    return preferences;
}

- (NSDictionary *)makeStrongestPathsGraphsWithPreferenceGraph:(NSDictionary *)preferences
{
    NSMutableDictionary *strongestPaths = [NSMutableDictionary dictionary];
    
    NSSet *answers = self.question.answers;
    
    for (Answer *answerA in answers) {
        for (Answer *answerB in answers) {
            if (answerA == answerB) {
                continue;
            }
            
//            NSLog(@"%@ - %@ %@ %@", answerA.text, answerB.text, preferences[[self keyFromAnswerA:answerA andAnswerB:answerB]], preferences[[self keyFromAnswerA:answerB andAnswerB:answerA]]);
            if ([preferences[[self keyFromAnswerA:answerA andAnswerB:answerB]] integerValue] > [preferences[[self keyFromAnswerA:answerB andAnswerB:answerA]] integerValue]) {
                strongestPaths[[self keyFromAnswerA:answerA andAnswerB:answerB]] = preferences[[self keyFromAnswerA:answerA andAnswerB:answerB]];
            } else {
                strongestPaths[[self keyFromAnswerA:answerA andAnswerB:answerB]] = @(0);
            }
        }
    }
    
    for (Answer *answerA in answers) {
        for (Answer *answerB in answers) {
            if (answerA == answerB) {
                continue;
            }
            
            for (Answer *answerC in answers) {
                if ((answerA == answerC) || (answerB == answerC)) {
                    continue;
                }
                
                strongestPaths[[self keyFromAnswerA:answerB andAnswerB:answerC]] = @(MAX([strongestPaths[[self keyFromAnswerA:answerB andAnswerB:answerC]] integerValue],
                                                                                       MIN([strongestPaths[[self keyFromAnswerA:answerB andAnswerB:answerA]] integerValue],
                                                                                           [strongestPaths[[self keyFromAnswerA:answerA andAnswerB:answerC]] integerValue])));
            }
        }
    }
    
    NSLog(@"%@", strongestPaths);
    
    return strongestPaths;
}

- (NSDictionary *)makeResultsDictionaryWithStrongestPathGraph:(NSDictionary *)strongestPaths
{
    NSMutableDictionary *results = [NSMutableDictionary dictionary];
    
    NSSet *answers = self.question.answers;
    
    for (Answer *answerA in answers) {
        NSInteger winCount = 0;
        for (Answer *answerB in answers) {
            if (answerA == answerB) {
                continue;
            }
            
            if ([strongestPaths[[self keyFromAnswerA:answerA andAnswerB:answerB]] integerValue] > [strongestPaths[[self keyFromAnswerA:answerB andAnswerB:answerA]] integerValue]) {
                winCount = winCount + 1;
            }
        }
        
        results[answerA.text] = @(winCount);
    }
    
    NSLog(@"%@", results);
    
    return results;
}

@end
