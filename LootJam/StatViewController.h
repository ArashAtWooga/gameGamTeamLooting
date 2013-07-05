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

- (IBAction) clickedPlayButton:(id)sender;

@end
