//
//  TutorialViewController.h
//  LootJam
//
//  Created by Arash Kashi on 7/9/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewControllerIpad.h"

@interface TutorialViewController : GameViewControllerIpad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andRows:(int)rows andCols:(int)cols andCellLimit:(int)cellTypes;


@end
