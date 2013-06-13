//
//  AppDelegate.h
//  Pickup
//
//  Created by ALAIN KHUON on 24/04/13.
//  Copyright (c) 2013 ALAIN KHUON. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) FMDatabase *database;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
