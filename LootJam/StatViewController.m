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
#import "TutorialViewController.h"

@interface StatViewController ()

@end

@implementation StatViewController

- (IBAction)onLeftBarbarianTapped:(id)sender {
    [self.leftPlayerLabel setText:@"Barbarian"];
    
    [self.player1hp setText:@"25"];
    [self.player1atk setText:@"2"];
    [self.player1mag setText:@"-1"];
    [self.player1chg setText:@"0"];
    [self.player1dis setText:@"0"];
    [self.player1hth setText:@"0"];
    [self.player1magicdelay setText:@"1"];
    [self.player1chargesize setText:@"5"];
}

- (IBAction)onLeftElfTapped:(id)sender {
    [self.leftPlayerLabel setText:@"Elf"];
    
    [self.player1hp setText:@"27"];
    [self.player1atk setText:@"0"];
    [self.player1mag setText:@"0"];
    [self.player1chg setText:@"0"];
    [self.player1dis setText:@"0"];
    [self.player1hth setText:@"1"];
    [self.player1magicdelay setText:@"1"];
    [self.player1chargesize setText:@"6"];
}

- (IBAction)onLeftMageTapped:(id)sender {
    [self.leftPlayerLabel setText:@"Mage"];
    
    [self.player1hp setText:@"25"];
    [self.player1atk setText:@"-1"];
    [self.player1mag setText:@"2"];
    [self.player1chg setText:@"0"];
    [self.player1dis setText:@"0"];
    [self.player1hth setText:@"0"];
    [self.player1magicdelay setText:@"1"];
    [self.player1chargesize setText:@"5"];
}

- (IBAction)onLeftAlchemistTapped:(id)sender {
    [self.leftPlayerLabel setText:@"Alchemist"];
    
    [self.player1hp setText:@"25"];
    [self.player1atk setText:@"0"];
    [self.player1mag setText:@"0"];
    [self.player1chg setText:@"0"];
    [self.player1dis setText:@"1"];
    [self.player1hth setText:@"0"];
    [self.player1magicdelay setText:@"2"];
    [self.player1chargesize setText:@"5"];
}

- (IBAction)onLeftMonkTapped:(id)sender {
    [self.leftPlayerLabel setText:@"Monk"];
    
    [self.player1hp setText:@"25"];
    [self.player1atk setText:@"0"];
    [self.player1mag setText:@"0"];
    [self.player1chg setText:@"3"];
    [self.player1dis setText:@"0"];
    [self.player1hth setText:@"-1"];
    [self.player1magicdelay setText:@"1"];
    [self.player1chargesize setText:@"5"];
    
}

- (IBAction)onRightBarbarianTapped:(id)sender {
    [self.rightPlayerLabel setText:@"Barbarian"];
    
    [self.player2hp setText:@"25"];
    [self.player2atk setText:@"2"];
    [self.player2mag setText:@"-1"];
    [self.player2chg setText:@"0"];
    [self.player2dis setText:@"0"];
    [self.player2hth setText:@"0"];
    [self.player2magicdelay setText:@"1"];
    [self.player2chargesize setText:@"5"];
    
}

- (IBAction)onRightElfTapped:(id)sender {
    [self.rightPlayerLabel setText:@"Elf"];
    
    [self.player2hp setText:@"27"];
    [self.player2atk setText:@"0"];
    [self.player2mag setText:@"0"];
    [self.player2chg setText:@"0"];
    [self.player2dis setText:@"0"];
    [self.player2hth setText:@"1"];
    [self.player2magicdelay setText:@"1"];
    [self.player2chargesize setText:@"6"];
}

- (IBAction)onRightMageTapped:(id)sender {
    [self.rightPlayerLabel setText:@"Mage"];
    
    [self.player2hp setText:@"25"];
    [self.player2atk setText:@"-1"];
    [self.player2mag setText:@"2"];
    [self.player2chg setText:@"0"];
    [self.player2dis setText:@"0"];
    [self.player2hth setText:@"0"];
    [self.player2magicdelay setText:@"1"];
    [self.player2chargesize setText:@"5"];
    
}
- (IBAction)onRightAlchemistTapped:(id)sender {
    [self.rightPlayerLabel setText:@"Alchemist"];
    
    [self.player2hp setText:@"25"];
    [self.player2atk setText:@"0"];
    [self.player2mag setText:@"0"];
    [self.player2chg setText:@"0"];
    [self.player2dis setText:@"1"];
    [self.player2hth setText:@"0"];
    [self.player2magicdelay setText:@"2"];
    [self.player2chargesize setText:@"5"];
}
- (IBAction)onRightMonkTapped:(id)sender {
    [self.rightPlayerLabel setText:@"Monk"];
    
    [self.player2hp setText:@"25"];
    [self.player2atk setText:@"0"];
    [self.player2mag setText:@"0"];
    [self.player2chg setText:@"3"];
    [self.player2dis setText:@"0"];
    [self.player2hth setText:@"-1"];
    [self.player2magicdelay setText:@"1"];
    [self.player2chargesize setText:@"5"];
}

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
- (IBAction)clickedTutorialButton:(id)sender {
    
    if ([self.leftPlayerLabel.text isEqual:@""] || [self.rightPlayerLabel.text isEqual:@""]) {
        
        UIAlertView *uiAlert = [[UIAlertView alloc] initWithTitle:@"Select Players" message:@"Please Select two destinies even for tutorial purposes!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [uiAlert show];
        return;
    }
    

    
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
    
    gameController.isTutorial = YES;
    
    gameController.view.userInteractionEnabled = NO;
    // Pass the parameters
    [gameController injectPlayerStatForPlayerOne:player1stats andPlayerTwo:player2stats];
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.navController pushViewController:gameController animated:YES];
    
}

- (IBAction) clickedPlayButton:(id)sender
{
    if ([self.leftPlayerLabel.text isEqual:@""] || [self.rightPlayerLabel.text isEqual:@""]) {
        
        UIAlertView *uiAlert = [[UIAlertView alloc] initWithTitle:@"Select Players" message:@"Please Select two destinies!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [uiAlert show];
        return;
    }
    
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
