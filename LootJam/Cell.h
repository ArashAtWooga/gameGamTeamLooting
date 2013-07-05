//
//  Cell.h
//  LootJam
//
//  Created by Arash Kashi on 7/3/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ATTACK = 0,
    MAGIC,
    CHARGE,
    HEALTH,
    DISABLE,
    JOKER,
    DUMMY
}
CellType;

@protocol CellDelegateProtocol <NSObject>

-(void)onTouchOnCellBegan:(id)cell;
-(void)onTouchOnCellMoved:(id)cell;
-(void)onTouchOnCellEnded:(id)cell;

@end


@interface Cell : UIImageView
{
    float _height, _width;
    float _xMargin, _yMargin;
    
    CellType _cellType;
    
    BOOL _isSelected;
    CGPoint _position;
}

-(instancetype)initWithType:(CellType)cellType andSize:(float)size;
-(void)setPosition:(CGPoint)position;
-(CGPoint)getPosition;
-(NSString *)stringCellType:(CellType)type;

-(void)switchToSelected;
-(void)switchToDeselected;
-(void)animateOut;
-(void)moveTo:(CGPoint)to andCompletion:(void (^)(BOOL finished))completion;
-(CellType)cellType;
+(NSString *)filenameForCellType:(CellType)cellType;
-(void)disableCell;
-(void)enableCell;


@property (nonatomic, strong) id<CellDelegateProtocol> delegate;

@end
