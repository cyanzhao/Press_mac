


//
//  CyanPressPanelView.m
//  CyanThirdMacApp
//
//  Created by cuiyan on 16/6/21.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "CyanPressPanelView.h"
#import "CyanCustomView.h"

typedef enum{
    
    SelectStateBlack=0,
    SelectStateWhite,
    SelectStateNull
    
}SelectState;

@interface CyanButton : NSButton

@property (nonatomic,assign)SelectState selectState;
@property (nonatomic,strong) NSImageView *pressImgView;

- (instancetype)initWithFrame:(NSRect)frameRect withState:(SelectState)state;


@end

@implementation CyanButton

- (instancetype)init{
    
    return [self initWithFrame:CGRectZero withState:(SelectStateNull)];
}

- (instancetype)initWithState:(SelectState)state{
    
    return [self initWithFrame:CGRectZero withState:(state)];

}

- (instancetype)initWithFrame:(NSRect)frameRect{
    
    return [self initWithFrame:frameRect withState:(SelectStateNull)];

}

- (instancetype)initWithFrame:(NSRect)frameRect withState:(SelectState)state{
    
    self = [super initWithFrame:frameRect];
    
    if (self) {
        
        //creat subview, imageView show press image
        
        CGFloat width = 25;
        CGFloat height = 25;
        CGFloat OX = (CGRectGetWidth(frameRect)-width)<0?0:(CGRectGetWidth(frameRect)-width)/2;
        CGFloat OY = (CGRectGetHeight(frameRect)-height)<0?0:(CGRectGetHeight(frameRect)-height)/2;

        NSImageView *imgView = [[NSImageView alloc]initWithFrame:CGRectMake(OX, OY, width, height)];
        [imgView setImageScaling:(NSImageScaleAxesIndependently)];
        [self addSubview:imgView];
    
        self.pressImgView = imgView;
        
        self.title = @"";
        self.selectState = state;
        
    }
    
    return self;
}

- (void)setSelectState:(SelectState)selectState{
    
    _selectState = selectState;
    
    switch (_selectState) {
        case SelectStateNull:{
            
            
            self.pressImgView.image = [NSImage imageNamed:@""];
        }
            break;
        case SelectStateBlack:{
            self.pressImgView.image = [NSImage imageNamed:@"black.jpg"];

        }
            break;
        case SelectStateWhite:{
            self.pressImgView.image = [NSImage imageNamed:@"white.jpg"];

        }
            break;
        default:
            break;
    }

}


@end



typedef enum{
    
  DiretionTypeHor,
    DiretionTypeVor,
    DiretionTypeLeftUp,
    DiretionTypeRightDown
    
}DiretionType;

@interface CyanPressPanelView ()

@property (nonatomic,assign) BOOL unBlack;  //是否黑色棋子
@property (nonatomic,strong) CyanButton *lastPressButton;  //上次选中的棋子

@end


@implementation CyanPressPanelView

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect{
    
    
    self = [super initWithFrame:frameRect];
    
    if (self) {
        
        
        _unBlack = NO;
        
        //15 *15 press panel
        CGFloat length = CGRectGetWidth(frameRect);
        
        for (NSInteger i =0 ; i<15; i++) {
            
            //横线
            CyanCustomView *horLine = [[CyanCustomView alloc]initWithFrame:CGRectMake(20, 20+i*40-0.5, length-20*2, 1)];
            horLine.backGroudColor = [NSColor greenColor];
            [self addSubview:horLine];
            
            //纵
            CyanCustomView *vorLine = [[CyanCustomView alloc]initWithFrame:CGRectMake( 20+i*40-0.5 , 20, 1, length-20*2)];
            vorLine.backGroudColor = [NSColor greenColor];
            [self addSubview:vorLine];
        }
        
        //255 press
        for (NSInteger i = 0; i<255; i++) {
            
            //创建15*15个button,
            // black white null
            //after every event,vertify the button.state to confirm the game's result
            
            CyanButton *btn = [[CyanButton alloc]initWithFrame:CGRectMake(i%15*40,i/15*40, 40, 40) withState:(SelectStateNull)];
            
            btn.tag = i;
            [btn setTitle:[NSString stringWithFormat:@"%ld",(long)i]];
//            [(NSButtonCell*)[btn cell]setBackgroundColor:[NSColor redColor]];

            [btn setButtonType:(NSMomentaryLightButton)];

//            [(NSButtonCell *)[btn cell]setImageScaling:(NSImageScaleAxesIndependently)];
//            [btn highlight: YES];
            btn.bordered = NO;
            
            btn.target = self;
            btn.action = @selector(btnClicked:);
            
//            NSControl
            
//            btn.wantsLayer = YES;
//            btn.layer.borderWidth = 4.;
//            btn.layer.borderColor = (__bridge CGColorRef _Nullable)([NSColor redColor]);
//            btn.layer.backgroundColor =  (__bridge CGColorRef _Nullable)([NSColor redColor]);

            [self addSubview:btn];
        }
    }
    
    return self;
    
}

- (void)redoOneStep{
    
    self.lastPressButton.selectState = SelectStateNull;
    _unBlack = !_unBlack;
}

- (void)restartGame{
    
    
    self.lastPressButton = nil;
    _unBlack = NO;
    
    for (NSInteger i = 0; i<255; i++) {
        
        CyanButton *btn = [self viewWithTag:i];
        btn.selectState = SelectStateNull;
    }
    
}



- (void)btnClicked:(CyanButton *)btn{
    
    NSLog(@"btnclicked");
    
    if (btn.selectState != SelectStateNull) {
        
        return;
    }
    
    btn.selectState = _unBlack?SelectStateWhite:SelectStateBlack;
    
    
    self.lastPressButton = btn;
    
    //根据tag值 判断赢得标志
    //赢的话 alertNote

    
    BOOL result = [self judgeResultIndex:btn.tag state:btn.selectState];
    
    
    
    if (result) {
        
        
        NSAlert *alert = [[NSAlert alloc]init];
        
        NSMutableArray *butttons= [NSMutableArray array];
        
        NSArray *titles = @[@"确定"];
        
        for (NSString *title  in titles) {
            
            NSButton *btn = [alert addButtonWithTitle:title];
            [butttons addObject:btn];
        }
        
        alert.informativeText = [NSString stringWithFormat:@"%@ win",_unBlack?@"白旗":@"黑棋"];
        
        [alert runModal];
        
    }
    
    _unBlack = !_unBlack;
}


- (BOOL)judgeResultIndex:(NSInteger)index state:(SelectState)state{


    
    //2+2个方向
    
//    i-1  i-2    ..... i+1  i+2
//    i-1*n i-2*n .... i+1*n i+2*n
//    
//    i-1*n-1 ..... i+1*n+1
//    i-1*n+1 ..... i+1*n-1
//     x(+1、-1)   y(1、n)     a(+1、0、-1)   b（+1、0、-1）  //3个变量 期望 有direction数组直接控制，不手动更改
    
    
    NSInteger sum = 1;
    NSInteger panelLenth = 15;
    NSInteger directionSum = 4;
    NSInteger winPathNum = 5;
    
    NSArray *multiplys = @[@1,[NSNumber numberWithInteger:panelLenth],[NSNumber numberWithInteger:panelLenth],[NSNumber numberWithInteger:panelLenth]];
    NSArray *pluss = @[@0,@0,@-1,@1];
    NSArray *hor_vors = @[@0,@0,@1,@1];
    
    
    for (NSInteger dircetion = 0; dircetion < directionSum ; dircetion++) {
        
        NSInteger currentIndex = index;
        NSInteger shakeFlag = -1;       //震荡表示  ，比如-1 像左、上侧移动， 1 向右下方移动
        NSInteger shakeCircle = 2;      //允许的震荡周期数量
        NSInteger currentShakeCircle = 0;   //当前震荡的周期
        
        NSInteger pathNum = 1;  //表针走过的数量
        
        sum = 1;    //方便更改时，重置sum
        
        
        while (currentShakeCircle < shakeCircle) {
            
            NSInteger multiply = ((NSNumber *)multiplys[dircetion]).intValue;
            NSInteger hor_vor = ((NSNumber *)hor_vors[dircetion]).intValue;
            NSInteger plus = ((NSNumber *)pluss[dircetion]).intValue;

            
            currentIndex = currentIndex+(shakeFlag)*multiply+ 1 * shakeFlag * hor_vor * plus;
            
            NSLog(@"-currentIndex-->%ld",currentIndex);

            //走4个值 震荡值翻转
            
//            currentShakeCircle += (pathNum == directionSum);
//            shakeFlag *= ((pathNum == directionSum)?-1:1);
            
            NSInteger lastShakeFlag = shakeFlag;
            
            
            //超过边界 翻转
            
            if (currentIndex < 0 || currentIndex >= panelLenth*panelLenth) {
                
                shakeFlag *= -1;
                
            }else if (dircetion == DiretionTypeHor){
                
                
                shakeFlag *= ((currentIndex/panelLenth == index/panelLenth)?1:-1);
                
                
            }else if (dircetion== DiretionTypeLeftUp || dircetion == DiretionTypeRightDown){
                
                if (currentIndex/panelLenth != (index/panelLenth + pathNum*shakeFlag)) {
                    shakeFlag *= -1;
                }
            }
            
            
             // 状态不一致 翻转
            
            if (shakeFlag == lastShakeFlag) {
               
                //判断btn.tag == currentIndex .selectState
                CyanButton *btn = [self viewWithTag:currentIndex];
                
                if (btn.selectState == state) {
                  
                    sum ++;
                    
                    if (sum >= winPathNum) {
                        
                        NSLog(@"win");

                        dircetion = 999;    //结束外层循环
                        
                        return YES;
                    }
                    
                    
                }else{
                    shakeFlag *= -1;
                    
                    NSLog(@"----%ld--------  翻转 --------------",(long)dircetion);

                }
            }else{
                
                NSLog(@"----%ld--------  翻转 --------------",(long)dircetion);
            }
            
            
            
            
            
            
            
            //翻转后做的初始化操作
            
            
            
            pathNum = (lastShakeFlag == shakeFlag)?pathNum+1:1;

            
            currentShakeCircle += ((shakeFlag == lastShakeFlag) ?0:1);
            currentIndex = (shakeFlag == lastShakeFlag)?currentIndex:index;
            
            
        }
        
        NSLog(@"directin gap line ---------------------------------");
    }

    return NO;
}


- (void)mouseDown:(NSEvent *)theEvent{
    

    //after every event, add single press  white or black
    //
    
//    NSPoint eventPoint = theEvent.locationInWindow;
//    
//    NSPoint basePanelEvent = [self.window.contentView convertPoint:eventPoint toView:self];
//    
//    NSLog(@"  %f  %f",theEvent.locationInWindow.x,theEvent.locationInWindow.y);
//    NSLog(@"  %f  %f",basePanelEvent.x,basePanelEvent.y);

}


- (void)mouseUp:(NSEvent *)theEvent{
    
    
    NSLog(@" -------------------- ");
    
    
}

//the coordinate of subViews on press panel  is flipped
- (BOOL)isFlipped{
    
//    CGFloat OX = self.frame.origin.x;
//    CGFloat OY = self.frame.origin.y;
//    
//    CGFloat width = CGRectGetWidth(self.bounds);
//    CGFloat height = CGRectGetHeight(self.bounds);
//    
//    self.frame = CGRectMake(OX, height-OY, width, height);
    
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    
    
    [[NSColor lightGrayColor]setFill];
    
    NSRectFill(dirtyRect);
    
    [super drawRect:dirtyRect];
}

@end
