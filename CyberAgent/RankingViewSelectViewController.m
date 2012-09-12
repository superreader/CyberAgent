//
//  RankingViewSelectViewController.m
//  CyberAgent
//
//  Created by 柏木 翔太 on 12/09/12.
//  Copyright (c) 2012年 上野 博司. All rights reserved.
//

#import "RankingViewSelectViewController.h"
#import "ViewController.h"

@interface RankingViewSelectViewController ()

@end

@implementation RankingViewSelectViewController

//バックボタンを起動させるかどうか
BOOL backBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ナビゲーションバーを生成
    objectNaviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    objectNaviBar.tintColor = [UIColor blackColor];
    
    // ナビゲーションアイテムを生成
    
    naviItem = [[UINavigationItem alloc] initWithTitle:@""];
    
    // 戻るボタンを生成
    backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(doBack:)];

    //バックボタンを起動させるか
    backBtn = false;
    
    // ナビゲーションアイテムの右側に戻るボタンを設置
    naviItem.leftBarButtonItem = backButton;
    
    // ナビゲーションバーにナビゲーションアイテムを設置
    [objectNaviBar pushNavigationItem:naviItem animated:YES];
    
    // ビューにナビゲーションアイテムを設置
    [self.view addSubview:objectNaviBar];

    NSString *str = [NSString stringWithFormat : @"ランキング"];
    str = [NSString stringWithFormat:@"%@",str];
    naviItem.title = str;


	// Do any additional setup after loading the view.
}

// 戻るボタンの実装
- (void)doBack:(id)sender
{
    backBtn = true;
    ViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentModalViewController:vc animated:YES ];


}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
