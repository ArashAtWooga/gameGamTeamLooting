//
//  ViewController.h
//  WoogaGameJamTest
//
//  Created by Adam Telfer on 7/4/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterStats.h"
@interface StatViewController : UIViewController <UITextFieldDelegate>
{
    CharacterStats* player1stats;
    CharacterStats* player2stats;
}
@property (weak, nonatomic) IBOutlet UILabel *leftPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightPlayerLabel;

@property IBOutlet UITextField* player1hp;
@property IBOutlet UITextField* player1atk;
@property IBOutlet UITextField* player1mag;
@property IBOutlet UITextField* player1chg;
@property IBOutlet UITextField* player1dis;
@property IBOutlet UITextField* player1hth;
@property IBOutlet UITextField* player1magicdelay;
@property IBOutlet UITextField* player1chargesize;

@property IBOutlet UITextField* player2hp;
@property IBOutlet UITextField* player2atk;
@property IBOutlet UITextField* player2mag;
@property IBOutlet UITextField* player2chg;
@property IBOutlet UITextField* player2dis;
@property IBOutlet UITextField* player2hth;
@property IBOutlet UITextField* player2magicdelay;
@property IBOutlet UITextField* player2chargesize;

@property IBOutlet UITextField* gameSize;
@property IBOutlet UITextField* gameLimit;


@property (weak, nonatomic) IBOutlet UIButton *leftBarbarianBut;
@property (weak, nonatomic) IBOutlet UIButton *leftElfBut;
@property (weak, nonatomic) IBOutlet UIButton *leftMonkBut;
@property (weak, nonatomic) IBOutlet UIButton *leftMageBut;
@property (weak, nonatomic) IBOutlet UIButton *leftAlchemistBut;

- (IBAction)onLeftBarbarianTapped:(id)sender;
- (IBAction)onLeftElfTapped:(id)sender;
- (IBAction)onLeftMageTapped:(id)sender;
- (IBAction)onLeftAlchemistTapped:(id)sender;
- (IBAction)onLeftMonkTapped:(id)sender;

- (IBAction)onRightBarbarianTapped:(id)sender;
- (IBAction)onRightElfTapped:(id)sender;
- (IBAction)onRightMageTapped:(id)sender;
- (IBAction)onRightAlchemistTapped:(id)sender;
- (IBAction)onRightMonkTapped:(id)sender;


- (IBAction) clickedPlayButton:(id)sender;

@end
