//
//  GameInstance.h
//  WoogaGameJamTest
//
//  Created by Adam Telfer on 7/4/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CharacterInstance;
@class CharacterStats;

@interface GameInstance : NSObject
{
    
}

@property CharacterInstance* player1;
@property CharacterInstance* player2;

- (id) initWithCharacters:(CharacterStats*)p1data player2:(CharacterStats*)p2data;

- (NSMutableArray *) executeMove:(int)playerNumber attackCells:(int)atk magicCells:(int)mag chargeCells:(int)charge disableCells:(int)charge healthCells:(int)health;

@end
