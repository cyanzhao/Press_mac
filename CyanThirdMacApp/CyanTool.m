
//
//  CyanTool.m
//  CyanThirdMacApp
//
//  Created by cuiyan on 16/6/23.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "CyanTool.h"
#import <AppKit/AppKit.h>

@implementation CyanTool

+ (CGColorRef)NSColorToCGColortransForms:(NSColor *)color
{
    const NSInteger numberOfComponents = [color numberOfComponents];
    CGFloat components[numberOfComponents];
    CGColorSpaceRef colorSpace = [[color colorSpace] CGColorSpace];
    [color getComponents:(CGFloat *)&components];
    return (__bridge CGColorRef)(id)CFBridgingRelease(CGColorCreate(colorSpace, components));
}

@end
