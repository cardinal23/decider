// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Vote.h instead.

#import <CoreData/CoreData.h>


extern const struct VoteAttributes {
	__unsafe_unretained NSString *timestamp;
} VoteAttributes;

extern const struct VoteRelationships {
	__unsafe_unretained NSString *ballots;
	__unsafe_unretained NSString *question;
} VoteRelationships;

extern const struct VoteFetchedProperties {
} VoteFetchedProperties;

@class Ballot;
@class Question;



@interface VoteID : NSManagedObjectID {}
@end

@interface _Vote : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (VoteID*)objectID;





@property (nonatomic, strong) NSDate* timestamp;



//- (BOOL)validateTimestamp:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *ballots;

- (NSMutableSet*)ballotsSet;




@property (nonatomic, strong) Question *question;

//- (BOOL)validateQuestion:(id*)value_ error:(NSError**)error_;





@end

@interface _Vote (CoreDataGeneratedAccessors)

- (void)addBallots:(NSSet*)value_;
- (void)removeBallots:(NSSet*)value_;
- (void)addBallotsObject:(Ballot*)value_;
- (void)removeBallotsObject:(Ballot*)value_;

@end

@interface _Vote (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveTimestamp;
- (void)setPrimitiveTimestamp:(NSDate*)value;





- (NSMutableSet*)primitiveBallots;
- (void)setPrimitiveBallots:(NSMutableSet*)value;



- (Question*)primitiveQuestion;
- (void)setPrimitiveQuestion:(Question*)value;


@end
