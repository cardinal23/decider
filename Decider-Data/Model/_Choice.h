// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Choice.h instead.

#import <CoreData/CoreData.h>


extern const struct ChoiceAttributes {
	__unsafe_unretained NSString *rank;
} ChoiceAttributes;

extern const struct ChoiceRelationships {
	__unsafe_unretained NSString *answer;
	__unsafe_unretained NSString *ballot;
} ChoiceRelationships;

extern const struct ChoiceFetchedProperties {
} ChoiceFetchedProperties;

@class Answer;
@class Ballot;



@interface ChoiceID : NSManagedObjectID {}
@end

@interface _Choice : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ChoiceID*)objectID;





@property (nonatomic, strong) NSNumber* rank;



@property int16_t rankValue;
- (int16_t)rankValue;
- (void)setRankValue:(int16_t)value_;

//- (BOOL)validateRank:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Answer *answer;

//- (BOOL)validateAnswer:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Ballot *ballot;

//- (BOOL)validateBallot:(id*)value_ error:(NSError**)error_;





@end

@interface _Choice (CoreDataGeneratedAccessors)

@end

@interface _Choice (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveRank;
- (void)setPrimitiveRank:(NSNumber*)value;

- (int16_t)primitiveRankValue;
- (void)setPrimitiveRankValue:(int16_t)value_;





- (Answer*)primitiveAnswer;
- (void)setPrimitiveAnswer:(Answer*)value;



- (Ballot*)primitiveBallot;
- (void)setPrimitiveBallot:(Ballot*)value;


@end
