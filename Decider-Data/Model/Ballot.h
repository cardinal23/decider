#import "_Ballot.h"

@class Answer;

@interface Ballot : _Ballot {}

- (BOOL)isAnswerA:(Answer *)answerA rankedHigherThanAnswerB:(Answer *)answerB;
- (void)initChoicesWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
