#import "Vote.h"


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

@end
