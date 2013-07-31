// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Answer.m instead.

#import "_Answer.h"

const struct AnswerAttributes AnswerAttributes = {
	.text = @"text",
};

const struct AnswerRelationships AnswerRelationships = {
	.choices = @"choices",
	.question = @"question",
};

const struct AnswerFetchedProperties AnswerFetchedProperties = {
};

@implementation AnswerID
@end

@implementation _Answer

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Answer" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Answer";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Answer" inManagedObjectContext:moc_];
}

- (AnswerID*)objectID {
	return (AnswerID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic text;






@dynamic choices;

	
- (NSMutableSet*)choicesSet {
	[self willAccessValueForKey:@"choices"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"choices"];
  
	[self didAccessValueForKey:@"choices"];
	return result;
}
	

@dynamic question;

	






@end
