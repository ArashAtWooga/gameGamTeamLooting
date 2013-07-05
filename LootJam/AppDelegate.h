//
//  AppDelegate.h
//  LootJam
//
//  Created by Arash Kashi on 7/3/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"

@class RootViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController *viewController;

@property (strong, nonatomic) UINavigationController* navController;

@end
