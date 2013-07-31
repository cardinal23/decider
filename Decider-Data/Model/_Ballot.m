// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Ballot.m instead.

#import "_Ballot.h"

const struct BallotAttributes BallotAttributes = {
};

const struct BallotRelationships BallotRelationships = {
	.choices = @"choices",
	.vote = @"vote",
};

const struct BallotFetchedProperties BallotFetchedProperties = {
};

@implementation BallotID
@end

@implementation _Ballot

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Ballot" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Ballot";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Ballot" inManagedObjectContext:moc_];
}

- (BallotID*)objectID {
	return (BallotID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic choices;

	
- (NSMutableSet*)choicesSet {
	[self willAccessValueForKey:@"choices"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"choices"];
  
	[self didAccessValueForKey:@"choices"];
	return result;
}
	

@dynamic vote;

	






@end
