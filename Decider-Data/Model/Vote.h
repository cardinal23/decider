#import "_Vote.h"

@interface Vote : _Vote {}

+ (Vote *)voteWithQuestion:(Question *)question andManagedContext:(NSManagedObjectContext *)context;
- (NSDictionary *)makePreferenceDiGraph;
- (NSDictionary *)makeStrongestPathsGraphsWithPreferenceGraph:(NSDictionary *)preferences;
- (NSDictionary *)makeResultsDictionaryWithStrongestPathGraph:(NSDictionary *)strongestPaths;

@end
