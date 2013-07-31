// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Choice.m instead.

#import "_Choice.h"

const struct ChoiceAttributes ChoiceAttributes = {
	.rank = @"rank",
};

const struct ChoiceRelationships ChoiceRelationships = {
	.answer = @"answer",
	.ballot = @"ballot",
};

const struct ChoiceFetchedProperties ChoiceFetchedProperties = {
};

@implementation ChoiceID
@end

@implementation _Choice

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Choice" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Choice";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Choice" inManagedObjectContext:moc_];
}

- (ChoiceID*)objectID {
	return (ChoiceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"rankValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rank"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic rank;



- (int16_t)rankValue {
	NSNumber *result = [self rank];
	return [result shortValue];
}

- (void)setRankValue:(int16_t)value_ {
	[self setRank:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveRankValue {
	NSNumber *result = [self primitiveRank];
	return [result shortValue];
}

- (void)setPrimitiveRankValue:(int16_t)value_ {
	[self setPrimitiveRank:[NSNumber numberWithShort:value_]];
}





@dynamic answer;

	

@dynamic ballot;

	






@end
