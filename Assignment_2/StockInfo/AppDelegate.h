//
//  AppDelegate.h
//  StockInfo
//
//  Created by Parth Patel on 2018-04-18.
//  Copyright © 2018 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@protocol SwiftProtocol;
@class SwiftClass;
@class KB;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;



- (void)saveContext;


@end

