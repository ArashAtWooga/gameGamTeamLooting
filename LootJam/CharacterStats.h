//
//  CharacterStats.h
//  WoogaGameJamTest
//
//  Created by Adam Telfer on 7/4/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterStats : NSObject

@property int maxHP;

@property int chargeMeterSize;
@property int chargeDamageBonus;
@property int attackDamageBonus;
@property int magicDamageBonus;
@property int disableChanceBonus;
@property int healthBonus;

@property int magicCooldown;

- (id) initFromDictionary:(NSDictionary*)dict;

@end
