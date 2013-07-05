//
//  Cell.m
//  LootJam
//
//  Created by Arash Kashi on 7/3/13.
//  Copyright (c) 2013 Wooga. All rights reserved.
//

#import "Cell.h"

@implementation Cell


-(instancetype)initWithType:(CellType)cellType andSize:(float)size
{
    // Initiate the parameters
    _height = _width = size;
    _xMargin = _yMargin = 5.0;
    
    _cellType = cellType;
    
    if (cellType != DUMMY) {
        //the tile background
        UIImage* img = [UIImage imageNamed:[Cell filenameForCellType:cellType]];
        
        //create a new object
        self = [super initWithImage:img];
    } else
        self.backgroundColor = [UIColor clearColor];

    if (self != nil) {
        self.frame = CGRectMake(0,0,_width, _height);
    }
    self.userInteractionEnabled = YES;

    return self;
}

-(CGPoint)getPosition
{
    return _position;
}

-(void)moveTo:(CGPoint)to andCompletion:(void (^)(BOOL finished))completion
{
    _position = to;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(to.x, to.y, _width, _height);
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}

-(void)disableCell
{
    self.alpha = 0.5;
}

-(void)enableCell
{
    self.alpha = 1.0;
}

-(NSString *)stringCellType:(CellType)type
{
    if (type == ATTACK) {
        return @"ATTACK";
    } else if (type == HEALTH) {
        return @"HEALTH";
    } else if (type == MAGIC) {
        return @"MAGIC";
    } else if (type == CHARGE) {
        return @"CHARGE";
    } else if (type == DISABLE) {
        return @"DISABLE";
    } else if (type == JOKER) {
        return @"JOKER";
    } else if (type == DUMMY) {
        return @"DUMMY";
    } else {
        NSAssert(nil, @"cell type not found");
        return nil;
    }
}

-(void)setPosition:(CGPoint)position
{
    _position = position;
    self.frame = CGRectMake(position.x, position.y, _width, _height);
}

-(CellType)cellType
{
    return _cellType;
}

+(NSString *)filenameForCellType:(CellType)cellType
{
    if (cellType == ATTACK) {
        return @"gems_red.png";//return @"redgem-shape.png";
    } else if (cellType == HEALTH) {
        return @"gems_green.png";
    } else if (cellType == MAGIC) {
        return @"gems_blue.png";
    } else if (cellType == CHARGE) {
        return @"gems_purple.png";
    } else if (cellType == DISABLE) {
        return @"gems_yellow.png";
    } else if (cellType == JOKER) {
        return @"lucky_orange.png";
    } else {
        NSAssert(nil, @"cell type not found");
        return nil;
    }
}

-(void)handleTouch:(UITouch *)touch
{
    CGRect centeralFrame = CGRectMake(_xMargin, _yMargin, _width - _xMargin*2, _height - _yMargin*2);
    
    if (self.delegate && CGRectContainsPoint(centeralFrame, [touch locationInView:self])) {
        [self.delegate onTouchOnCellBegan:self];
        [self switchToSelected];
    }
}

-(void)animateOut
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self handleTouch:[touches anyObject]];
}

-(void)switchToSelected
{
    _isSelected = YES;
    self.backgroundColor = [UIColor brownColor];
}

-(void)switchToDeselected
{
    _isSelected = NO;
    self.backgroundColor = [UIColor clearColor];
}

//2
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self handleTouch:[touches anyObject]];
}

//3
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.delegate) {
        [self.delegate onTouchOnCellEnded:self];
    }

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
