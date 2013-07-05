//
//  GameViewController.h
//  LootJam
//
//  Created by Arash Kashi on 7/3/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Grid.h"
#import "CharacterStats.h"

@class GameInstance;

@interface GameViewController : UIViewController <GridDelegateProtocol, UIAlertViewDelegate>
{
    float _cellSize;
    
    int _numberOfColumns;
    int _numberOfRows;
    int _gameIteration;
    Grid *_grid;
    
    GameInstance* game;
}

@property (strong, nonatomic) IBOutlet UIImageView *firstSelectedCell;
@property (strong, nonatomic) IBOutlet UIImageView *secondSelectedCell;
@property (strong, nonatomic) IBOutlet UIImageView *thirdSelectedCell;

@property (weak, nonatomic) IBOutlet UIImageView *leftPlayerTurn;
@property (weak, nonatomic) IBOutlet UIImageView *rightPlayerTurn;

@property (weak, nonatomic) IBOutlet UILabel *leftHPLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightHPLabel;

@property (weak, nonatomic) IBOutlet UILabel *leftChargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *LeftDisableLabel;

@property (weak, nonatomic) IBOutlet UILabel *rightChargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightDisableLabel;

@property (weak, nonatomic) IBOutlet UITextView *log;
@property (weak, nonatomic) IBOutlet UILabel *log1;
@property (weak, nonatomic) IBOutlet UILabel *log2;
@property (weak, nonatomic) IBOutlet UILabel *log3;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andRows:(int)rows andCols:(int)cols andCellLimit:(int)cellTypes;

-(void)injectPlayerStatForPlayerOne:(CharacterStats *)player1 andPlayerTwo:(CharacterStats *)playerTwo;

@end
