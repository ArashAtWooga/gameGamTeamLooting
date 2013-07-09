//
//  Grid.h
//  LootJam
//
//  Created by Arash Kashi on 7/3/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

typedef struct  {
    int row;
    int column;
}CellGridPosition ;

@protocol GridDelegateProtocol <NSObject>

-(void)onSelectionMade:(NSArray *)selectedCells;
-(void)onPlayerPlayed:(NSArray *)play;

@end

@interface Grid : NSObject <CellDelegateProtocol>
{
    NSMutableArray *columns;
    NSMutableArray *_selectedCells;
    
    float _cellSize;
    
    int _cellLimit;
    
    CGPoint _gridPosition;
    UIView *_view;
    
    int _numberOfRows;
    int _numberOfcolumns;
    
    int _turnToken;
    NSArray *_disabled;
}

@property (nonatomic, weak) id<GridDelegateProtocol> delegate;

-(id)initGridWithRows:(int)numberOfRows andColumns:(int)numberOfColumns andCellSize:(float)size andCellLimit:(int)cellTypes;
-(void)drawGridInView:(UIView *)view atPosition:(CGPoint)point;
-(void)updateDisabledCell:(NSArray *)disabled;
-(void)TouchCellInRow:(int)row andCol:(int)col;


@end
