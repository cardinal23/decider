#import "_Vote.h"

@interface Vote : _Vote {}

+ (Vote *)voteWithQuestion:(Question *)question andManagedContext:(NSManagedObjectContext *)context;

@end
