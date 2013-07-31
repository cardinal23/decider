// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Question.m instead.

#import "_Question.h"

const struct QuestionAttributes QuestionAttributes = {
	.text = @"text",
};

const struct QuestionRelationships QuestionRelationships = {
	.answers = @"answers",
	.votes = @"votes",
};

const struct QuestionFetchedProperties QuestionFetchedProperties = {
};

@implementation QuestionID
@end

@implementation _Question

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Question" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Question";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Question" inManagedObjectContext:moc_];
}

- (QuestionID*)objectID {
	return (QuestionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic text;






@dynamic answers;

	
- (NSMutableSet*)answersSet {
	[self willAccessValueForKey:@"answers"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"answers"];
  
	[self didAccessValueForKey:@"answers"];
	return result;
}
	

@dynamic votes;

	
- (NSMutableSet*)votesSet {
	[self willAccessValueForKey:@"votes"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"votes"];
  
	[self didAccessValueForKey:@"votes"];
	return result;
}
	






@end
