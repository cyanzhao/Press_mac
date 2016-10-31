//
//  AppDelegate.m
//  CyanThirdMacApp
//
//  Created by cuiyan on 16/6/20.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "AppDelegate.h"
#import "CyanNewWindowController.h"
#import "CyanViewController.h"

@interface AppDelegate ()<NSWindowDelegate>{
    
    
    CyanNewWindowController *windowCtrl;
    CyanViewController *viewCtrl;
    
}
- (IBAction)shownewClicked:(id)sender;

@property (weak) IBOutlet NSButton *showNewWindow;
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    viewCtrl = [[CyanViewController alloc]initWithNibName:@"CyanViewController" bundle:nil];
    viewCtrl.view.frame = self.window.contentView.bounds;

    //第1种添加ViewController的方法
    [self.window.contentViewController addChildViewController:viewCtrl];
    self.window.contentView = viewCtrl.view;
    
    //第二种添加ViewController的方法
//    [self.window.contentView addSubview:viewCtrl.view];
    
    
    
    self.window.contentView.wantsLayer = YES;
    self.window.delegate = viewCtrl;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)shownewClicked:(id)sender {
    
//    [self.window close];
    
    //不能是局部变量
    windowCtrl = [[CyanNewWindowController alloc]initWithWindowNibName:@"CyanNewWindowController"];
    windowCtrl.window.delegate = self;
    [windowCtrl showWindow:self];
    
    [windowCtrl.window center];
    [windowCtrl.window makeKeyWindow];
    [windowCtrl.window orderFront:self];
}


#pragma mark -- window delegate
- (void)windowDidMove:(NSNotification *)notification{
    
    NSLog(@"windowDidMove");
}

@end
