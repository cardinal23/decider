// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Question.h instead.

#import <CoreData/CoreData.h>


extern const struct QuestionAttributes {
	__unsafe_unretained NSString *text;
} QuestionAttributes;

extern const struct QuestionRelationships {
	__unsafe_unretained NSString *answers;
	__unsafe_unretained NSString *votes;
} QuestionRelationships;

extern const struct QuestionFetchedProperties {
} QuestionFetchedProperties;

@class Answer;
@class Vote;



@interface QuestionID : NSManagedObjectID {}
@end

@interface _Question : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (QuestionID*)objectID;





@property (nonatomic, strong) NSString* text;



//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *answers;

- (NSMutableSet*)answersSet;




@property (nonatomic, strong) NSSet *votes;

- (NSMutableSet*)votesSet;





@end

@interface _Question (CoreDataGeneratedAccessors)

- (void)addAnswers:(NSSet*)value_;
- (void)removeAnswers:(NSSet*)value_;
- (void)addAnswersObject:(Answer*)value_;
- (void)removeAnswersObject:(Answer*)value_;

- (void)addVotes:(NSSet*)value_;
- (void)removeVotes:(NSSet*)value_;
- (void)addVotesObject:(Vote*)value_;
- (void)removeVotesObject:(Vote*)value_;

@end

@interface _Question (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;





- (NSMutableSet*)primitiveAnswers;
- (void)setPrimitiveAnswers:(NSMutableSet*)value;



- (NSMutableSet*)primitiveVotes;
- (void)setPrimitiveVotes:(NSMutableSet*)value;


@end
