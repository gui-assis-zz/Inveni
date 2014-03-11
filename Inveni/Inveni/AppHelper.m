//
//  AppHelper.m
//  ModelExample
//
//  Created by Franco Carbonaro on 14/12/10.
//  Copyright 2010 Franco Carbonaro. All rights reserved.
//

#import "AppHelper.h"
#import "AppDelegate.h"


#define kPreferencesName @"Boticario Mobile-Info.plist"

@implementation AppHelper

+(NSString*)getPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return [docDir stringByAppendingPathComponent:kPreferencesName];
    
}

+ (NSManagedObjectContext *)mainManagedObjectContext {
	return [((AppDelegate *)[[UIApplication sharedApplication] delegate]) managedObjectContext];
}

+ (NSDictionary *)getPlistWithName: (NSString *)theName {
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:theName ofType:@"plist"];
	NSDictionary *plist = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
	
	return plist;
}

+ (NSDictionary *)getSettingsPlist {
	return [self getPlistWithName:@"Settings"];
}

+(NSString*)getMacAddressDevice {
    return [((AppDelegate *)[[UIApplication sharedApplication] delegate]) macAddressDevice];
}

+(UINavigationController*) getRootNavigationController {
    AppDelegate *delegate = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
    return [delegate getRootNavigationController];
}

@end