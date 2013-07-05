//
//  CharacterInstance.m
//  WoogaGameJamTest
//
//  Created by Adam Telfer on 7/4/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import "CharacterInstance.h"

#import "CharacterStats.h"

@implementation CharacterInstance

- (void) resetStats
{
    self.disables = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil];
    self.hp = self.stats.maxHP;
    self.charge = 0;
}

- (id) initWithStats:(CharacterStats*)stats
{
    if (self = [super init]) {
        self.stats = stats;
        NSString* pathToFile = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"damageconfig.plist"];
        self.config = [NSDictionary dictionaryWithContentsOfFile:pathToFile];
        NSAssert([[self.config allKeys] count] > 0,@"No Keys found in Dictionary...");
        [self resetStats];
    }
    return self;
}

- (int) isTypeDisabled:(int)attackType { return [[self.disables objectAtIndex:attackType] intValue]; } // 0 => not disabled, >0 => disabled for that many turns
- (int) disableType:(int)attackType forTurns:(int)turns {
    
    if (attackType < 0 || attackType > 4) {
        NSLog(@"What am I doing here?");
        return 0;
    }
    
    int disabledFor = [self isTypeDisabled:attackType];
    disabledFor = disabledFor + turns;
    if (disabledFor < 0) disabledFor = 0;
    
    [self.disables replaceObjectAtIndex:attackType withObject:[NSNumber numberWithInt:disabledFor]];
    disabledFor = [self isTypeDisabled:attackType];
    return disabledFor;
}

- (int) rand_range:(int)min_n max:(int)max_n
{
    return rand() % (max_n - min_n + 1) + min_n;
}

- (BOOL) randomBoolWithYesPercentage:(int)percentage {
    return arc4random_uniform(100) < percentage;
}

- (void) updateOnNewTurn
{
    for (int i = 0; i < 5; ++i) {
        [self disableType:i forTurns:-1];
    }
}

- (int) getAttackDamage:(int)numberOfAttackCells {
    if ([self isTypeDisabled:kAttackType]) return 0;
    
    NSArray* attackPercentages = [self.config objectForKey:@"attack"];
    NSDictionary* dictForAttack = [attackPercentages objectAtIndex:numberOfAttackCells-1];
    
    int min = [[dictForAttack objectForKey:@"min"] intValue];
    int max = [[dictForAttack objectForKey:@"max"] intValue];
    
    int damage = [self rand_range:min max:max] + self.stats.attackDamageBonus;
    if (damage <= 0) {
        damage = 1;
    }
    return damage;
}
- (int) getMagicDamage:(int)numberOfMagicCells {
    if ([self isTypeDisabled:kMagicType]) return 0;
    
    NSArray* magicAttack = [self.config objectForKey:@"magic"];
    int baseDamage = [[magicAttack objectAtIndex:(numberOfMagicCells-1)] intValue];
    
    [self disableType:kMagicType forTurns:1+self.stats.magicCooldown];
    int damage = baseDamage + self.stats.magicDamageBonus;
    if (damage <= 0) {
        damage = 1;
    }
    return damage;
}
- (int) getChargeDamage:(int)numberOfChargeCells {
    
    if ([self isTypeDisabled:kChargeType]) return 0;
    
    NSArray* chargeAmount = [self.config objectForKey:@"chargeamount"];
    int chgAmt = [[chargeAmount objectAtIndex:(numberOfChargeCells-1)] intValue];
    
    NSDictionary* chargeDamage = [self.config objectForKey:@"chargedamage"];
    int min = [[chargeDamage objectForKey:@"min"] intValue];
    int max = [[chargeDamage objectForKey:@"max"] intValue];
    
    self.charge += chgAmt;
    int damage = 0;
    if (self.charge >= self.stats.chargeMeterSize) {
        damage = [self rand_range:min max:max] + self.stats.chargeDamageBonus;
        self.charge = self.charge - self.stats.chargeMeterSize;
    }
    return damage;
}
- (int) addHealthCells:(int)numberOfHealthCells {
    if ([self isTypeDisabled:kHealthType]) return 0;
    
    NSArray* healthAmount = [self.config objectForKey:@"health"];
    NSDictionary* dict = [healthAmount objectAtIndex:numberOfHealthCells-1];
    
    int min = [[dict objectForKey:@"min"] intValue];
    int max = [[dict objectForKey:@"max"] intValue];
    
    int hlth = [self rand_range:min max:max];
    
    int addHealth = hlth + self.stats.healthBonus;
    self.hp += addHealth;
    if (self.hp > self.stats.maxHP) self.hp = self.stats.maxHP;
    return addHealth;
}
- (int) doesDisable:(int)numberOfDisableCells {
    if ([self isTypeDisabled:kDisableType]) return 0;
    
    if (numberOfDisableCells == 1 && [self randomBoolWithYesPercentage:60 + self.stats.disableChanceBonus]) {
        return 1;
    } else if (numberOfDisableCells == 2 && [self randomBoolWithYesPercentage:100 + self.stats.disableChanceBonus]) {
        return 1;
    } else if (numberOfDisableCells == 3) {
        int num = 1;
        if ([self randomBoolWithYesPercentage:50]) {
            num = 2;
        }
        return num;
    } else {
        return 0;
    }
} // 0 => not disabled, >0 => number of disabled actions

- (int) receiveAttackDamage:(int)attackDamage
{
    self.hp -= attackDamage;
    return attackDamage;
}
- (int) receiveMagicDamage:(int)magicDamage
{
    self.hp -= magicDamage;
    return magicDamage;
}
- (int) receiveChargeDamage:(int)chargeDamage
{
    self.hp -= chargeDamage;
    return chargeDamage;
}


@end
