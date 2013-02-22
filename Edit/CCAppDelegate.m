//
//  CCAppDelegate.m
//  Edit
//
//  Created by James Womack on 2/20/13.
//  Copyright (c) 2013 James Womack. All rights reserved.
//

#import "CCAppDelegate.h"

#import "CCViewController.h"


@interface CCAppDelegate ()

@property (strong, nonatomic) CCViewController *viewController;

@end


@implementation CCAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [UIWindow.alloc initWithFrame:UIScreen.mainScreen.bounds];
    BOOL isPhone = (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone);
    self.viewController = [CCViewController.alloc initWithNibName:isPhone?@"CCViewController_iPhone":@"CCViewController_iPad" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
