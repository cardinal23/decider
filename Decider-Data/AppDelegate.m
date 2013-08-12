//
//  AppDelegate.m
//  Decider-Data
//
//  Created by Mike Dockerty on 7/24/13.
//  Copyright (c) 2013 Mike Dockerty. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"

#import "Question.h"
#import "Answer.h"
#import "Vote.h"
#import "Ballot.h"
#import "Choice.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self loadFakeData];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.mainViewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = self.mainViewController;
    self.mainViewController.managedObjectContext = self.managedObjectContext;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

- (void)deleteAllEntitiesWithName:(NSString *)entityName
{
    NSFetchRequest * allEntities = [[NSFetchRequest alloc] init];
    [allEntities setEntity:[NSEntityDescription entityForName:entityName
                                        inManagedObjectContext:self.managedObjectContext]];
    
    [allEntities setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * entities = [self.managedObjectContext executeFetchRequest:allEntities error:&error];
    
    for (NSManagedObject * entity in entities) {
        [self.managedObjectContext deleteObject:entity];
    }
}

- (void)clearDatabase
{
    [self deleteAllEntitiesWithName:@"Question"];
    [self deleteAllEntitiesWithName:@"Answer"];
    [self deleteAllEntitiesWithName:@"Vote"];
    [self deleteAllEntitiesWithName:@"Ballot"];
    [self deleteAllEntitiesWithName:@"Choice"];

    NSError *saveError = nil;
    [self.managedObjectContext save:&saveError];
    
    if (saveError) {
        NSLog(@"%@", saveError);
    }
}

- (Answer *)findAnswerWithText:(NSString *)text
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"text == %@", text];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Answer"
                                        inManagedObjectContext:self.managedObjectContext]];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest
                                                                error:&error];
    
    if ([results count] == 0) {
        NSLog(@"No answer found for text '%@'", text);
        return nil;
    }
        
    return results[0];
}

// For easily entering fake data.
// Expecting answers with text "A", "B", "C", "D", "E"
// Used for implementing the sample from http://en.wikipedia.org/wiki/Schulze_method

- (Ballot *)ballotFromChoicesString:(NSString *)choicesString
{
    Ballot *ballot = [Ballot insertInManagedObjectContext:self.managedObjectContext];
    
    for (NSInteger i = 0; i < [choicesString length]; i++) {
        NSString *answerText = [NSString stringWithFormat:@"%c", [choicesString characterAtIndex:i]];
        Answer *answer = [self findAnswerWithText:answerText];
        
        if (!answer) {
            NSLog(@"Not found: %@", answerText);
            continue;
        }
        
        Choice *choice = [Choice insertInManagedObjectContext:self.managedObjectContext];
        choice.answer = answer;
        choice.rank = @([choicesString length] - i);
        [ballot addChoicesObject:choice];
    }
    
    return ballot;
}

- (void)addNumberOfBallots:(NSInteger)numberOfBallots
         withChoicesString:(NSString *)choicesString
                    toVote:(Vote *)vote
{
    for (NSUInteger i = 0; i < numberOfBallots; i++) {
        Ballot *ballot = [self ballotFromChoicesString:choicesString];
        [vote addBallotsObject:ballot];
    }
}

- (void)loadFakeData
{
    [self clearDatabase];
    
    Question *question = [Question insertInManagedObjectContext:self.managedObjectContext];
    question.text = @"Question Text";
    
    Answer *answerA = [Answer insertInManagedObjectContext:self.managedObjectContext];
    answerA.text = @"A";
    [question addAnswersObject:answerA];
    
    Answer *answerB = [Answer insertInManagedObjectContext:self.managedObjectContext];
    answerB.text = @"B";
    [question addAnswersObject:answerB];

    Answer *answerC = [Answer insertInManagedObjectContext:self.managedObjectContext];
    answerC.text = @"C";
    [question addAnswersObject:answerC];

    Answer *answerD = [Answer insertInManagedObjectContext:self.managedObjectContext];
    answerD.text = @"D";
    [question addAnswersObject:answerD];

    Answer *answerE = [Answer insertInManagedObjectContext:self.managedObjectContext];
    answerE.text = @"E";
    [question addAnswersObject:answerE];

    Vote *vote = [Vote voteWithQuestion:question
                      andManagedContext:self.managedObjectContext];
    
    [self addNumberOfBallots:5
           withChoicesString:@"ACBED"
                      toVote:vote];

    [self addNumberOfBallots:5
           withChoicesString:@"ADECB"
                      toVote:vote];

    [self addNumberOfBallots:8
           withChoicesString:@"BEDAC"
                      toVote:vote];

    [self addNumberOfBallots:3
           withChoicesString:@"CABED"
                      toVote:vote];

    [self addNumberOfBallots:7
           withChoicesString:@"CAEBD"
                      toVote:vote];

    
    [self addNumberOfBallots:2
           withChoicesString:@"CBADE"
                      toVote:vote];

    [self addNumberOfBallots:7
           withChoicesString:@"DCEBA"
                      toVote:vote];

    [self addNumberOfBallots:8
           withChoicesString:@"EBADC"
                      toVote:vote];

    [self saveContext];
    
    [vote makeResultsDictionaryWithStrongestPathGraph:[vote makeStrongestPathsGraphsWithPreferenceGraph:[vote makePreferenceDiGraph]]];
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Decider_Data" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Decider_Data.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
