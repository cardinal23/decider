// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Vote.m instead.

#import "_Vote.h"

const struct VoteAttributes VoteAttributes = {
	.timestamp = @"timestamp",
};

const struct VoteRelationships VoteRelationships = {
	.ballots = @"ballots",
	.question = @"question",
};

const struct VoteFetchedProperties VoteFetchedProperties = {
};

@implementation VoteID
@end

@implementation _Vote

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Vote" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Vote";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Vote" inManagedObjectContext:moc_];
}

- (VoteID*)objectID {
	return (VoteID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic timestamp;






@dynamic ballots;

	
- (NSMutableSet*)ballotsSet {
	[self willAccessValueForKey:@"ballots"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"ballots"];
  
	[self didAccessValueForKey:@"ballots"];
	return result;
}
	

@dynamic question;

	






@end
