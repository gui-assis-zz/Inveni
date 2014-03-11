//
//  AppHelper.h
//  ModelExample
//
//  Created by Franco Carbonaro on 23/09/10.
//  Copyright 2010 Franco Carbonaro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppHelper : NSObject {
	
}

+ (NSManagedObjectContext *)mainManagedObjectContext;

+ (NSDictionary *)getPlistWithName: (NSString *)theName;
+ (NSDictionary *)getSettingsPlist;

+(UINavigationController*) getRootNavigationController;

+(NSString*)getMacAddressDevice;

@end