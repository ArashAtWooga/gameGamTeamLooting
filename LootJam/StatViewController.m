//
//  ViewController.m
//  WoogaGameJamTest
//
//  Created by Adam Telfer on 7/4/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import "StatViewController.h"
#import "CharacterStats.h"
#import "CharacterInstance.h"
#import "GameInstance.h"

#import "AppDelegate.h"
#import "GameViewController.h"
#import "GameViewControllerIpad.h"

@interface StatViewController ()

@end

@implementation StatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    player1stats = [[CharacterStats alloc] init];
    player2stats = [[CharacterStats alloc] init];
    
    self.gameLimit.text = @"5";
    self.gameSize.text = @"4";
    
    self.player1hp.text = @"25";
    self.player1atk.text = @"0";
    self.player1mag.text = @"0";
    self.player1chg.text = @"0";
    self.player1dis.text = @"0";
    self.player1hth.text = @"0";
    self.player1chargesize.text = @"5";
    self.player1magicdelay.text = @"1";
    
    self.player2hp.text = @"25";
    self.player2atk.text = @"0";
    self.player2mag.text = @"0";
    self.player2chg.text = @"0";
    self.player2dis.text = @"0";
    self.player2hth.text = @"0";
    self.player2chargesize.text = @"5";
    self.player2magicdelay.text = @"1";
    
    self.player1hp.delegate = self;
    self.player1atk.delegate = self;
    self.player1mag.delegate = self;
    self.player1chg.delegate = self;
    self.player1dis.delegate = self;
    self.player1hth.delegate = self;
    self.player1chargesize.delegate = self;
    self.player1magicdelay.delegate = self;
    
    self.player2hp.delegate = self;
    self.player2atk.delegate = self;
    self.player2mag.delegate = self;
    self.player2chg.delegate = self;
    self.player2dis.delegate = self;
    self.player2hth.delegate = self;
    self.player2chargesize.delegate = self;
    self.player2magicdelay.delegate = self;
    
    self.gameSize.delegate = self;
    self.gameLimit.delegate = self;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    player1stats.maxHP = [self.player1hp.text intValue];
    
    player1stats.attackDamageBonus = [self.player1atk.text intValue];
    player1stats.magicDamageBonus = [self.player1mag.text intValue];
    player1stats.chargeDamageBonus = [self.player1chg.text intValue];
    player1stats.disableChanceBonus = [self.player1dis.text intValue];
    player1stats.healthBonus = [self.player1hth.text intValue];
    
    player1stats.chargeMeterSize = [self.player1chargesize.text intValue];
    player1stats.magicCooldown = [self.player1magicdelay.text intValue];
    
    
    player2stats.maxHP = [self.player2hp.text intValue];
    
    player2stats.attackDamageBonus = [self.player2atk.text intValue];
    player2stats.magicDamageBonus = [self.player2mag.text intValue];
    player2stats.chargeDamageBonus = [self.player2chg.text intValue];
    player2stats.disableChanceBonus = [self.player2dis.text intValue];
    player2stats.healthBonus = [self.player2hth.text intValue];
    player2stats.chargeMeterSize = [self.player2chargesize.text intValue];
    player2stats.magicCooldown = [self.player2magicdelay.text intValue];
    
    
    // Any new character added is passed in as the "text" parameter
    if([string isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textField resignFirstResponder];
        
        
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    
    return YES;
}

- (int) rand_range:(int)min_n max:(int)max_n
{
    return rand() % (max_n - min_n + 1) + min_n;
}

- (IBAction) clickedPlayButton:(id)sender
{
    GameViewController* gameController;
    int size = [self.gameSize.text intValue];
    if (size <= 0) size = 4;
    int limit = [self.gameLimit.text intValue];
    if (limit <= 2) limit = 2;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        gameController = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil andRows:size andCols:size andCellLimit:limit];
    } else {
        gameController = (GameViewController*)[[GameViewControllerIpad alloc] initWithNibName:@"GameViewControllerIpad" bundle:nil andRows:size andCols:size andCellLimit:limit];
    }
    
    
    // Pass the parameters
    [gameController injectPlayerStatForPlayerOne:player1stats andPlayerTwo:player2stats];
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.navController pushViewController:gameController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
