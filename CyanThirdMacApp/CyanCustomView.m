
//
//  CyanCustomView.m
//  CyanThirdMacApp
//
//  Created by cuiyan on 16/6/21.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "CyanCustomView.h"
#import <AppKit/AppKit.h>

@implementation CyanCustomView


//- (BOOL)wantsUpdateLayer{
//    
//    return YES;
//}
//
//- (void)updateLayer{
//    
//    self.layer.backgroundColor = (__bridge CGColorRef _Nullable)(self.backGroudColor);
//}

- (void)setBackGroudColor:(NSColor *)backGroudColor{
    
    _backGroudColor = backGroudColor;
    
//    [self setNeedsDisplay:YES];
}



- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    
    [_backGroudColor setFill];
    NSRectFill(dirtyRect);
    
    [super drawRect:dirtyRect];
}

@end
