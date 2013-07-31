// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Ballot.h instead.

#import <CoreData/CoreData.h>


extern const struct BallotAttributes {
} BallotAttributes;

extern const struct BallotRelationships {
	__unsafe_unretained NSString *choices;
	__unsafe_unretained NSString *vote;
} BallotRelationships;

extern const struct BallotFetchedProperties {
} BallotFetchedProperties;

@class Choice;
@class Vote;


@interface BallotID : NSManagedObjectID {}
@end

@interface _Ballot : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BallotID*)objectID;





@property (nonatomic, strong) NSSet *choices;

- (NSMutableSet*)choicesSet;




@property (nonatomic, strong) Vote *vote;

//- (BOOL)validateVote:(id*)value_ error:(NSError**)error_;





@end

@interface _Ballot (CoreDataGeneratedAccessors)

- (void)addChoices:(NSSet*)value_;
- (void)removeChoices:(NSSet*)value_;
- (void)addChoicesObject:(Choice*)value_;
- (void)removeChoicesObject:(Choice*)value_;

@end

@interface _Ballot (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveChoices;
- (void)setPrimitiveChoices:(NSMutableSet*)value;



- (Vote*)primitiveVote;
- (void)setPrimitiveVote:(Vote*)value;


@end
