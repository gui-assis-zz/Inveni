//
//  AppDelegate.h
//  Inveni
//
//  Created by Guilherme Augusto on 31/10/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabController.h"
#import "MenuViewController.h"
#import "NetworkHelper.h"

#import "EstabelecimentoService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSString *macAddressDevice;
@property (strong, nonatomic) EstabelecimentoService *estabService;

- (NSURL *)applicationDocumentsDirectory;
- (UINavigationController*) getRootNavigationController;

@end
