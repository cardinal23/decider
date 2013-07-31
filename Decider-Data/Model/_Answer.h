// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Answer.h instead.

#import <CoreData/CoreData.h>


extern const struct AnswerAttributes {
	__unsafe_unretained NSString *text;
} AnswerAttributes;

extern const struct AnswerRelationships {
	__unsafe_unretained NSString *choices;
	__unsafe_unretained NSString *question;
} AnswerRelationships;

extern const struct AnswerFetchedProperties {
} AnswerFetchedProperties;

@class Choice;
@class Question;



@interface AnswerID : NSManagedObjectID {}
@end

@interface _Answer : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AnswerID*)objectID;





@property (nonatomic, strong) NSString* text;



//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *choices;

- (NSMutableSet*)choicesSet;




@property (nonatomic, strong) Question *question;

//- (BOOL)validateQuestion:(id*)value_ error:(NSError**)error_;





@end

@interface _Answer (CoreDataGeneratedAccessors)

- (void)addChoices:(NSSet*)value_;
- (void)removeChoices:(NSSet*)value_;
- (void)addChoicesObject:(Choice*)value_;
- (void)removeChoicesObject:(Choice*)value_;

@end

@interface _Answer (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;





- (NSMutableSet*)primitiveChoices;
- (void)setPrimitiveChoices:(NSMutableSet*)value;



- (Question*)primitiveQuestion;
- (void)setPrimitiveQuestion:(Question*)value;


@end
