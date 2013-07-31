#import "Vote.h"
#import "Question.h"

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

- (NSDictionary *)makePreferenceDiGraph
{
    NSMutableDictionary *preferences = [NSMutableDictionary dictionary];
    
    NSSet *answers = self.question.answers;
    for (Answer *answer in answers) {
        
    }
    return preferences;
}

@end
