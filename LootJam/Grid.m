//
//  Grid.m
//  LootJam
//
//  Created by Arash Kashi on 7/3/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import "Grid.h"


@implementation Grid 

-(id)initGridWithRows:(int)numberOfRows andColumns:(int)numberOfColumns andCellSize:(float)size andCellLimit:(int)cellTypes{
    if (self = [super init]) {
        
        columns = [[NSMutableArray alloc] init];
        _selectedCells = [[NSMutableArray alloc] init];
        
        _cellSize = size;
        
        _cellLimit = cellTypes;
        
        _numberOfcolumns = numberOfRows;
        _numberOfRows = numberOfColumns;
        
        _turnToken = 0;
        
        for (int i = 0; i < numberOfColumns; i++) {
            NSMutableArray *row = [[NSMutableArray alloc] init];
            for (int j = 0; j < numberOfRows; j++) {
                Cell *cell = [[Cell alloc] initWithType:[self randomCellType] andSize:_cellSize];
                [cell setPosition:CGPointMake(j * cell.frame.size.height, i * cell.frame.size.width)];
                cell.delegate = self;
                [row addObject:cell];
            }
            [columns addObject:row];
        }
    }
    return self;
}

-(Cell *)cellAtRow:(int)row andColumn:(int)col
{
    return [[columns objectAtIndex:row] objectAtIndex:col];
}

-(void)putCellIntoGrid:(Cell *)cell atRow:(int)row andColumn:(int)col
{
    [[columns objectAtIndex:row] setObject:cell atIndex:col];
}

-(void)moveCell:(Cell*)cell to:(CellGridPosition)to isNewToGrid:(BOOL)newCell
{
    Cell *destinationCell = [self cellAtRow:to.row andColumn:to.column];
    CGPoint destination = [destinationCell getPosition];
    
    // Remove cell at destination
    [self removeCellFromGrid:destinationCell];
    
    // Replace the destination with the new cell
    [self putCellIntoGrid:cell atRow:to.row andColumn:to.column];
    
    // replace the source cell with a dummy one
    if (!newCell) {
        CellGridPosition sourceGridPosition = [self gridPositionForCell:cell];
        Cell *dummy = [[Cell alloc] initWithType:DUMMY andSize:_cellSize];
        [dummy setPosition:[cell getPosition]];
        [self putCellIntoGrid:dummy atRow:sourceGridPosition.row andColumn:sourceGridPosition.column];
    }

    // Move the cell to new location
    [cell moveTo:destination andCompletion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
}

-(void)removeCellFromGrid:(Cell *)cell
{
    [cell animateOut];
    // Remove from grid
    CellGridPosition gridPosition = [self gridPositionForCell:cell];
    Cell *dummyCell = [[Cell alloc] initWithType:DUMMY andSize:_cellSize];
    [dummyCell setPosition:[cell getPosition]];
    [[columns objectAtIndex:gridPosition.row] setObject:dummyCell atIndex:gridPosition.column];
}

-(CellGridPosition)gridPositionForCell:(Cell*)cell
{
    CellGridPosition result;
    
    for (int i = 0; i< _numberOfRows; i++) {
        for (int j = 0; j< _numberOfcolumns; j++) {
            if ([cell isEqual:[((NSMutableArray *)[columns objectAtIndex:i]) objectAtIndex:j]]) {
                result.column = j;
                result.row = i;
                return result;
            }
        }
    }
    
    NSAssert(nil, @"Cell is not in the grid");
    return result;
}

-(CellType)randomCellType {
    int rangeLow = 0;
    int rangeHigh = _cellLimit-1;
    
    int result =  arc4random() % (rangeHigh-rangeLow+1) + rangeLow;
    return (CellType)result;
}

-(void)drawGridInView:(UIView *)view atPosition:(CGPoint)point
{
    _gridPosition = point;
    _view = view;
    
    for (NSMutableArray *row in columns) {
        for (Cell *cell in row) {
            [cell setPosition:CGPointMake(point.x + cell.frame.origin.x, point.y + cell.frame.origin.y)];
            [view addSubview:cell];
        }
    }
}

-(BOOL)cellsSelectedStraight:(NSMutableArray *)selectedCells
{
    int sumOfRows = 0;
    int sumOfCols = 0;
    
    for (int i = 0; i < selectedCells.count; i++) {
        for (int j = i + 1; j < selectedCells.count; j++) {
                Cell *_cellOne = [selectedCells objectAtIndex:i];
                Cell *_cellTwo = [selectedCells objectAtIndex:j];
                
                sumOfRows = sumOfRows + abs( [self gridPositionForCell:_cellOne].row - [self gridPositionForCell:_cellTwo].row );
                sumOfCols = sumOfCols + abs( [self gridPositionForCell:_cellOne].column - [self gridPositionForCell:_cellTwo].column );
        }
    }
    
    BOOL inARow = sumOfRows == 0 && sumOfCols == 4;
    BOOL inAColumn = sumOfCols == 0 && sumOfRows == 4;
    
    return inARow || inAColumn;
}

-(BOOL)cellsSelectedDiagnal:(NSMutableArray *)selectedCells
{
    int sumOfRows = 0;
    int sumOfCols = 0;
    
    for (int i = 0; i < selectedCells.count; i++) {
        for (int j = i + 1; j < selectedCells.count; j++) {
            Cell *_cellOne = [selectedCells objectAtIndex:i];
            Cell *_cellTwo = [selectedCells objectAtIndex:j];
            
            sumOfRows = sumOfRows + abs( [self gridPositionForCell:_cellOne].row - [self gridPositionForCell:_cellTwo].row );
            sumOfCols = sumOfCols + abs( [self gridPositionForCell:_cellOne].column - [self gridPositionForCell:_cellTwo].column );
        }
    }
    return sumOfRows == 4 && sumOfCols == 4;
}

-(BOOL)cellSelectedCorrectly:(NSMutableArray *)selectedCells
{
    return [self cellsSelectedStraight:selectedCells] || [self cellsSelectedDiagnal:selectedCells];
}

-(void)deselectSelectedCell:(NSMutableArray *)selectedCells
{
    for (Cell *cell in selectedCells)
    {
        [cell switchToDeselected];
    }
}

-(CellType)convertCellType:(NSString *)cellTypeString
{
    if ([cellTypeString isEqualToString:@"A"])
        return ATTACK;
    else if ([cellTypeString isEqualToString:@"M"])
        return MAGIC;
    else if ([cellTypeString isEqualToString:@"CH"])
        return CHARGE;
    else if ([cellTypeString isEqualToString:@"D"])
        return DISABLE;
    else if ([cellTypeString isEqualToString:@"H"])
        return HEALTH;
    else {
        NSAssert(nil, @"cell type not supported");
        return HEALTH;
    }
}

-(NSArray *)convertCellTypeArray:(NSArray *)intput
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (NSString *item in intput){
        [result addObject:@([self convertCellType:item])];
    }
    
    return result;
}

-(void)updateDisabledCell:(NSArray *)disabled
{
    int counter = 0;
    _disabled = disabled;

    disabled = [self convertCellTypeArray:disabled];
    
    for (NSArray *column in columns) {
        for (Cell *cell in column) {
            [cell enableCell];
            for (NSNumber *item in disabled) {
                NSLog(@"Cell updated: %i", ++counter);
                if ([item intValue] == [cell cellType]) {
                    [cell disableCell];
                }
            }
        }
    }
    
    
}

-(void)fillupGrid
{
    for (int i = 0; i <_numberOfcolumns; i ++)
    {
        [self fillupColumn:i];
    }
}

-(CGPoint)loadingPositionForCol:(int)col
{
    Cell *destinationCell = [self cellAtRow:0 andColumn:col];
    CGPoint topRow = [destinationCell getPosition];
    
    return  CGPointMake(topRow.x, topRow.y - 30);
}

-(void)fillupColumn:(int)col
{
    int dummyRow = [self getFirstRowWithDummyCellInColumn:col];
    if (dummyRow == _numberOfRows) {
        [self updateDisabledCell:_disabled];
        return;
    } else {
        // Get a reference to cells above dummy
        CellGridPosition newGridPosition;
        for (int i = dummyRow; i > 0; i--) {
            Cell *cell = [self cellAtRow:i-1 andColumn:col];
            
            
            newGridPosition.row = [self gridPositionForCell:cell].row + 1;
            newGridPosition.column = [self gridPositionForCell:cell].column;
            [self moveCell:cell to:newGridPosition isNewToGrid:NO];
        }
        
        Cell *newCell = [[Cell alloc] initWithType:[self randomCellType] andSize:_cellSize];
        newCell.delegate = self;
        
        [newCell setPosition:[self loadingPositionForCol:col]];
        
        [_view addSubview:newCell];
        [_view bringSubviewToFront:newCell];
        newGridPosition.row = 0;
        newGridPosition.column = col;
        
        [self moveCell:newCell to:newGridPosition isNewToGrid:YES];
    }
    
    double delayInSeconds = .5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self fillupColumn:col];
    });
    
    
}

-(int)getFirstRowWithDummyCellInColumn:(int)col
{
    Cell *resultCell;
    for (int i = _numberOfRows - 1; i >= 0; i--) {
        resultCell =[self cellAtRow:i andColumn:col];
        if ([resultCell cellType] == DUMMY) {
            return i;
        }
    }
    return _numberOfRows;
}

-(void)processTurn
{
    // check if the cells properly
    if ([self cellSelectedCorrectly:_selectedCells]) {
        // Update the scores.
        if (self.delegate) {
            [self.delegate onSelectionMade:_selectedCells];
            [self.delegate onPlayerPlayed:_selectedCells];
        }
        
        // Remove the selected cells fromt he grid.
        for (Cell *cell in _selectedCells) {
            [self removeCellFromGrid:cell];
        }
        
        // Slide down new cells into the grid.
        [self fillupGrid];
        
        // update the scores
        
        //
        [self deselectSelectedCell:_selectedCells];
        [_selectedCells removeAllObjects];
    } else{
        [self deselectSelectedCell:_selectedCells];
        [_selectedCells removeAllObjects];
    }
    
    // collapse them if they are in the right order.
    
    // populate the board with new cells.
}

-(void)onTouchOnCellBegan:(Cell *)cell
{
    if ([_selectedCells containsObject:cell]) {
        return;
    } else
        [_selectedCells addObject:cell];
}

-(void)onTouchOnCellMoved:(id)cell
{
    
}

-(void)onTouchOnCellEnded:(id)cell
{
    if ([_selectedCells count] == 3) {
        for (Cell *cell in _selectedCells) {
            NSLog(@"Selected: %@", [cell stringCellType:[cell cellType]]);
        }
        if (_turnToken == 0) {
            NSLog(@"A:---------------");
            _turnToken = 1;
        } else {
            NSLog(@"B:---------------");
            _turnToken = 0;
        }

        [self processTurn];
    }
}

@end
