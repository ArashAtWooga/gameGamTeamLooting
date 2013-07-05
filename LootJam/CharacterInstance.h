//
//  CharacterInstance.h
//  WoogaGameJamTest
//
//  Created by Adam Telfer on 7/4/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAttackType 0
#define kMagicType 1
#define kChargeType 2
#define kDisableType 3
#define kHealthType 4


@class CharacterStats;

@interface CharacterInstance : NSObject

@property NSMutableDictionary* config;

@property CharacterStats* stats;

@property int hp;

@property int charge;

@property NSMutableArray* disables;

- (id) initWithStats:(CharacterStats*)stats;

- (int) isTypeDisabled:(int)attackType; // 0 => not disabled, >0 => disabled for that many turns
- (int) disableType:(int)attackType forTurns:(int)turns;

- (void) updateOnNewTurn;

- (int) getAttackDamage:(int)numberOfAttackCells;
- (int) getMagicDamage:(int)numberOfMagicCells;
- (int) getChargeDamage:(int)numberOfChargeCells;
- (int) addHealthCells:(int)numberOfHealthCells;
- (int) doesDisable:(int)numberOfDisableCells; // 0 => not disabled, >0 => number of disabled actions

- (int) receiveAttackDamage:(int)attackDamage;
- (int) receiveMagicDamage:(int)magicDamage;
- (int) receiveChargeDamage:(int)chargeDamage;

@end