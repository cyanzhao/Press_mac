//
//  CyanViewController.m
//  CyanSecondMacApp
//
//  Created by cuiyan on 16/6/17.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "CyanViewController.h"
#import "CyanPressPanelView.h"

@interface CyanViewController ()<NSWindowDelegate>{
    
    CyanPressPanelView *panelView;
}
- (IBAction)redoOneStep:(id)sender;

@end

@implementation CyanViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {

    }
    return self;
}

- (void)viewWillAppear{
    
    [super viewWillAppear];
    
//    self.view.window.contentView.bounds = CGRectMake(0, 0, 700, 700);

    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    NSLog(@"--->%f",height);
    
    CGFloat panelOX = width<660?30:(width-600)/2;
    CGFloat panelOY = height <720?-(600-(height-60)):(height-600)/2;
    
    panelView.frame = CGRectMake(panelOX,  panelOY, 600, 600);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    /*
     
        测试mac 开发基本的操作
        页面跳转、UI搭建
        
        实现五子棋的棋盘Ui布局
     
     */
    
    //棋盘view
//     棋盘  适配
//    当window 足够小时，棋盘右下覆盖，保留左上的显示  大于某尺寸时，固定center(window.center)
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    CGFloat panelOX = width<660?30:(width-600)/2;
    CGFloat panelOY = height <720?-(600-(height-60)):(height-600)/2;
    
    panelView = [[CyanPressPanelView alloc]initWithFrame: CGRectMake(panelOX,  panelOY, 600, 600)];
    [self.view addSubview:panelView];
    
    
    NSLog(@"%@",self.view.isFlipped?@"yes":@"no");
}


#pragma mark -- window delegate


- (void)windowDidResize:(NSNotification *)notification{
    
    NSLog(@"%@",notification);
    

    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    NSLog(@"--->%f",height);
    
    CGFloat panelOX = width<660?30:(width-600)/2;
    CGFloat panelOY = height <720?-(600-(height-60)):(height-600)/2;

    panelView.frame = CGRectMake(panelOX,  panelOY, 600, 600);
    
}

- (void)windowDidMove:(NSNotification *)notification{
    
    NSLog(@"%@",notification);
}

- (IBAction)clearButtonClicked:(id)sender {
        
    [panelView restartGame];
}

- (IBAction)redoOneStep:(id)sender {
    
    [panelView redoOneStep];
}
@end
