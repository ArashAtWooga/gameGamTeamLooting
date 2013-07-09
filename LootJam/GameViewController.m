
//
//  GameViewController.m
//  LootJam
//
//  Created by Arash Kashi on 7/3/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import "GameViewController.h"
#import "Cell.h"
#import "CharacterStats.h"
#import "GameInstance.h"
#import "CharacterInstance.h"
#import "AppDelegate.h"


@interface GameViewController ()

@end

@implementation GameViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andRows:(int)rows andCols:(int)cols andCellLimit:(int)cellTypes
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        _cellSize = 70.0;
    } else {
        _cellSize = 140.0;
    }
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.view.userInteractionEnabled = YES;
    if (self) {
        _numberOfRows = rows;
        _numberOfColumns = cols;
        _gameIteration = 0;
        
        // Custom initialization
        _grid = [[Grid alloc] initGridWithRows:_numberOfColumns andColumns:_numberOfRows andCellSize:_cellSize andCellLimit:cellTypes];
        [_grid drawGridInView:self.view atPosition:[self gridPositionForCellSize]];
        _grid.delegate = self;
        
        self.leftPlayerTurn.alpha = 0.0;
    }

    return self;
}

-(void)TutorialPhaseOne
{
    self.tutorialView.frame = CGRectMake(100, 100, self.tutorialView.frame.size.width, self.tutorialView.frame.size.height);
    [self.tutorialLabel setText:@"first player chooses three"];
}

-(void)tutorialPhaseTwo
{
    
}

-(void)tutorialPhaseThree
{
    
}

-(void)tutorialPhaseFour
{
    
}

-(void)tutorialPhaseFive
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
//    [self.view addSubview:self.tutorialView];
//    self.tutorialView.frame = CGRectMake(-200, 100, self.tutorialView.frame.size.width, self.tutorialView.frame.size.height);
//    [UIView animateWithDuration:2 animations:^{
//        [self TutorialPhaseOne];
//    } completion:^(BOOL finished) {
//        if (finished) {
//            [self tutorialPhaseTwo];
//        }
//    }];
}



-(void)injectPlayerStatForPlayerOne:(CharacterStats *)player1 andPlayerTwo:(CharacterStats *)playerTwo
{
    [self initatePlayers:player1  andPlayerTwo:playerTwo];
}

-(CGPoint)gridPositionForCellSize
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return CGPointMake(([[UIScreen mainScreen] bounds].size.width - _numberOfRows * _cellSize)/2, 120.0);
    }
    else {
        return CGPointMake(([[UIScreen mainScreen] bounds].size.width - _numberOfRows * _cellSize)/2, 240.0);
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    //    _xOffset = pt.x - self.center.x;
    //    _yOffset = pt.y - self.center.y;
    NSLog(@"Game is touched");
}

//2
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    //    self.center = CGPointMake(pt.x - _xOffset, pt.y - _yOffset);
}

//3
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    [self touchesMoved:touches withEvent:event];
}

-(void)onSelectionMade:(NSArray *)selectedCells
{
    CellType first = [(Cell*)[selectedCells objectAtIndex:0] cellType];
    CellType second = [(Cell*)[selectedCells objectAtIndex:1] cellType];
    CellType third = [(Cell*)[selectedCells objectAtIndex:2] cellType];

    [self.firstSelectedCell setImage:[UIImage imageNamed:[Cell filenameForCellType:first]]];
    [self.secondSelectedCell setImage:[UIImage imageNamed:[Cell filenameForCellType:second]]];
    [self.thirdSelectedCell setImage:[UIImage imageNamed:[Cell filenameForCellType:third]]];

}

-(void)initatePlayers:(CharacterStats *)playerOne  andPlayerTwo:(CharacterStats *)playerTwo
{
    CharacterStats* player1stats = playerOne;
    
    CharacterStats* player2stats = playerTwo;
    
    game = [[GameInstance alloc] initWithCharacters:player1stats player2:player2stats];
    
    self.leftHPLabel.text = [NSString stringWithFormat:@"HP: %i/%i" , game.player1.hp , game.player1.stats.maxHP];
    self.rightHPLabel.text = [NSString stringWithFormat:@"HP: %i/%i" , game.player2.hp, game.player2.stats.maxHP];
    
    self.leftChargeLabel.text = [NSString stringWithFormat:@"CH: %i/%i", game.player1.charge, game.player1.stats.chargeMeterSize];
    
    self.rightChargeLabel.text = [NSString stringWithFormat:@"CH: %i/%i", game.player2.charge, game.player2.stats.chargeMeterSize];
    
    self.LeftDisableLabel.text = [self getDisabledText:game.player1 playerNum:1];
    self.rightDisableLabel.text = [self getDisabledText:game.player2 playerNum:0];
}

-(void)togglePlayerTurn
{
    if (self.leftPlayerTurn.alpha == 0.0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.leftPlayerTurn.alpha = 1.0;
            self.rightPlayerTurn.alpha = 0.0;
        }];
    } else
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.leftPlayerTurn.alpha = 0.0;
            self.rightPlayerTurn.alpha = 1.0;
        }];
    }
}

-(int)getNumberProperties:(NSArray *)play withType:(CellType)type
{
    int result = 0;
    
    for (Cell *cell in play) {
        if ([cell cellType] == type) {
            result++;
        }
    }

    return result;
}

-(NSString *)stringType:(NSNumber*)type
{
    NSDictionary *map =  @{@(0):@"A", @(1):@"M", @(2):@"CH", @(3):@"D", @(4):@"H"};
    return [map objectForKey:type];
}


-(NSString *)getDisabledText:(CharacterInstance *)characterIntance playerNum:(int)playerNum
{
    NSMutableString* string = [NSMutableString string];
    [string appendString:@"D:"];
    
    for (int i = 0; i < 5; ++i) {
        if ([characterIntance isTypeDisabled:i] > 0) {
            NSString *disType = [self stringType:@(i)];
            int disAmount = [characterIntance isTypeDisabled:i];
            [string appendString:[NSString stringWithFormat:@"%@(%i)", disType, disAmount]];
        }
    }
    
    
    NSMutableArray *disabled = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; ++i) {
        if (playerNum == 2) {
            if ([game.player1 isTypeDisabled:i] > 0) {
                [disabled addObject:[self stringType:@(i)]];
            }
        } else if (playerNum ==1){
            if ([game.player2 isTypeDisabled:i] > 0) {
                [disabled addObject:[self stringType:@(i)]];
            }
        }
    }
    [_grid updateDisabledCell:disabled];
    
    return string;
}

-(void)processVictoryWithWinner:(int)winner
{
    NSString *winnerMessage = (winner == 1)? @"Left WON" : @"Right WON";
    UIAlertView *uiAlert = [[UIAlertView alloc] initWithTitle:@"Winner" message:winnerMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [uiAlert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.navController popToRootViewControllerAnimated:YES];
}

-(void)onPlayerPlayed:(NSArray *)play
{
    [self togglePlayerTurn];
    _gameIteration ++;
    
    int playerNum = ((_gameIteration) % 2) + 1;
    
    NSMutableArray *logs = [game executeMove:playerNum attackCells:[self getNumberProperties:play withType:ATTACK] magicCells:[self getNumberProperties:play withType:MAGIC] chargeCells:[self getNumberProperties:play withType:CHARGE] disableCells:[self getNumberProperties:play withType:DISABLE] healthCells:[self getNumberProperties:play withType:HEALTH]];
    
    self.log1.text = @"";
    self.log2.text = @"";
    self.log3.text = @"";
    for (int i = 0; i < [logs count]; i++) {
        if (i == 0) {
            self.log1.text = [logs objectAtIndex:i] ;
        }
        
        if (i == 1) {
            self.log2.text = [logs objectAtIndex:i] ;
        }
        
        if (i == 2) {
            self.log3.text = [logs objectAtIndex:i] ;
        }
    }
    
    self.leftHPLabel.text = [NSString stringWithFormat:@"HP: %i/%i" , game.player1.hp , game.player1.stats.maxHP];
    self.rightHPLabel.text = [NSString stringWithFormat:@"HP: %i/%i" , game.player2.hp, game.player2.stats.maxHP];
    
    self.leftChargeLabel.text = [NSString stringWithFormat:@"CH: %i/%i", game.player1.charge, game.player1.stats.chargeMeterSize];
    
    self.rightChargeLabel.text = [NSString stringWithFormat:@"CH: %i/%i", game.player2.charge, game.player2.stats.chargeMeterSize];
    
    self.LeftDisableLabel.text = [self getDisabledText:game.player1 playerNum:playerNum];
    self.rightDisableLabel.text = [self getDisabledText:game.player2 playerNum:playerNum];
    
    
    if (game.player1.hp <= 0 || game.player2.hp <= 0) {
        
        [self processVictoryWithWinner:(game.player1.hp <= 0)? 2 : 1];
    }
    

}




- (IBAction)onResetTapped:(id)sender {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.navController popToRootViewControllerAnimated:YES];
}
@end
