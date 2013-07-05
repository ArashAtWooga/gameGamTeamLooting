//
//  CharacterStats.m
//  WoogaGameJamTest
//
//  Created by Adam Telfer on 7/4/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import "CharacterStats.h"

@implementation CharacterStats

- (id) init
{
    if (self = [super init]) {
        self.maxHP = 25;
        self.chargeMeterSize = 5;
        self.magicCooldown = 1;
    }
    return self;
}

@end
