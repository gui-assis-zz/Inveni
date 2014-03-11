//
//  RootViewController.m
//  Inveni
//
//  Created by Guilherme Augusto on 01/11/13.
//  Copyright (c) 2013 Primus Tech. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

-(void) awakeFromNib{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tabController"];
    self.menuViewController    = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
    
    [self setLiveBlur:YES];
    self.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleDark;
}


@end
