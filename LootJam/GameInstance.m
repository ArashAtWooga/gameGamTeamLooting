//
//  GameInstance.m
//  WoogaGameJamTest
//
//  Created by Adam Telfer on 7/4/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import "GameInstance.h"

#import "CharacterInstance.h"
#import "CharacterStats.h"

@implementation GameInstance

- (id) initWithCharacters:(CharacterStats*)p1data player2:(CharacterStats*)p2data
{
    if (self = [super init]) {
        self.player1 = [[CharacterInstance alloc] initWithStats:p1data];
        self.player2 = [[CharacterInstance alloc] initWithStats:p2data];
    }
    return self;
}

- (int) rand_range:(int)min_n max:(int)max_n
{
    return rand() % (max_n - min_n + 1) + min_n;
}

- (BOOL) randomBoolWithYesPercentage:(int)percentage {
    return arc4random_uniform(100) < percentage;
}


- (NSMutableArray *) executeMove:(int)playerNumber attackCells:(int)atk magicCells:(int)mag chargeCells:(int)charge disableCells:(int)disable healthCells:(int)health
{
    NSMutableString *log = [[NSMutableString alloc] init];
    NSMutableArray *logs = [[NSMutableArray alloc] init];
    
    CharacterInstance* myPlayer;
    CharacterInstance* targetPlayer;
    
    if (playerNumber == 1) {
        myPlayer = self.player1;
        targetPlayer = self.player2;
    } else {
        myPlayer = self.player2;
        targetPlayer = self.player1;
    }
    
    
    
    if (atk > 0) {
        NSLog(@"Player %d uses %d Attack Cells",playerNumber,atk);
        int damage = [targetPlayer receiveAttackDamage:[myPlayer getAttackDamage:atk]];
        if (damage > 0) {
            NSLog(@"Player %d does %d attack damage to the other player",playerNumber,damage);
            [log appendFormat:@"Player %d does %d attack damage to the other player \n",playerNumber,damage];
            [logs addObject:[NSString stringWithFormat:@"Player %d does %d attack damage",playerNumber,damage]];
        }
    }
    
    if (mag > 0) {
        NSLog(@"Player %d uses %d Magic Cells",playerNumber,mag);
        int damage = [targetPlayer receiveMagicDamage:[myPlayer getMagicDamage:mag]];
        if (damage > 0) {
            NSLog(@"Player %d does %d magic damage to the other player",playerNumber,damage);
              [log appendFormat:@"Player %d does %d magic damage to the other player  \n",playerNumber,damage];
            [logs addObject:[NSString stringWithFormat:@"Player %d does %d magic damage",playerNumber,damage]];
        }
    }
    
    if (charge > 0) {
        NSLog(@"Player %d uses %d Charge Cells",playerNumber,charge);
        int damage = [targetPlayer receiveChargeDamage:[myPlayer getChargeDamage:charge]];
        if (damage == 0) {
            NSLog(@"Player %d charges up to %d of %d",playerNumber,myPlayer.charge,myPlayer.stats.chargeMeterSize);
            [log appendFormat:@"Player %d charges up to %d of %d \n",playerNumber,myPlayer.charge,myPlayer.stats.chargeMeterSize];
            [logs addObject:[NSString stringWithFormat:@"Player %d charges up to %d/%d",playerNumber,myPlayer.charge,myPlayer.stats.chargeMeterSize]];
        } else {
            NSLog(@"CHARGED! Player %d does %d charge damage",playerNumber,damage);
            [log appendFormat:@"CHARGE COMPLETE! Player %d does %d charge damage \n",playerNumber,damage];
            [logs addObject:[NSString stringWithFormat:@"CHARGED! Player %d does %d charge damage",playerNumber,damage]];
        }
    }
    
    if (disable > 0) {
        NSLog(@"Player %d uses %d Disable Cells",playerNumber,disable);
        int disableNum = [myPlayer doesDisable:disable];
        if (disableNum > 0) {
            int turns = 1;
            if (disable == 3) turns = 2;
            
            for (int i = 0; i < disableNum; ++i) {
                int gemType = [self rand_range:0 max:4];
                [targetPlayer disableType:gemType forTurns:turns];
                NSLog(@"Disabled! Player %d disables type %d for %d turns",playerNumber,gemType,1);
                [log appendFormat:@"DISABLED! Player %d disables other players type %d for %d turns\n",playerNumber,gemType,turns];
                [logs addObject:[NSString stringWithFormat:@"Disabled! Player %d disables type %d for %d turns",playerNumber,gemType,turns]];
            }
        } else {
            NSLog(@"Player %d Disable failed",playerNumber);
            [logs addObject:[NSString stringWithFormat:@"Player %d Disable failed",playerNumber]];
        }
    }
    
    if (health > 0) {
        NSLog(@"Player %d uses %d Health Cells",playerNumber,health);
        int healthUp = [myPlayer addHealthCells:health];
        if (healthUp > 0) {
            NSLog(@"Player %d adds %d health! now is at %d HP!",playerNumber,healthUp,myPlayer.hp);
            [log appendFormat:@"Player %d adds %d health! now is at %d HP!\n",playerNumber,healthUp,myPlayer.hp];
            [logs addObject:[NSString stringWithFormat:@"Player %d adds %d health!",playerNumber,healthUp,myPlayer.hp]];
        }
    }
    
    [myPlayer updateOnNewTurn];
    
    NSLog(@"Player 1 has %d health, Player 2 has %d health",self.player1.hp,self.player2.hp);
    
    return logs;
}



@end
