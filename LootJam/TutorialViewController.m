//
//  TutorialViewController.m
//  LootJam
//
//  Created by Arash Kashi on 7/9/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andRows:(int)rows andCols:(int)cols andCellLimit:(int)cellTypes
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil andRows:rows andCols:cols andCellLimit:cellTypes];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
