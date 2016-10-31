//
//  CyanViewController.h
//  CyanSecondMacApp
//
//  Created by cuiyan on 16/6/17.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CyanViewController : NSViewController<NSWindowDelegate>
@property (weak) IBOutlet NSButton *clearButton;
- (IBAction)clearButtonClicked:(id)sender;

@end
