//
//  RankingViewSelectViewController.m
//  CyberAgent
//
//  Created by 柏木翔太 on 12/09/05.
//  Copyright (c) 2012年 柏木翔太. All rights reserved.
//

#import "RankingViewSelectViewController.h"
#import "ViewController.h"
#import "AllRankingViewController.h"

@interface RankingViewSelectViewController ()

@end

@implementation RankingViewSelectViewController

//バックボタンを起動させるかどうか
BOOL backBtn;

//どのボタンが押されたか記録する
static  NSString *btnSelect;

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
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;//アニメーションの指定
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

- (IBAction)btn1:(id)sender {
    btnSelect = [NSString stringWithFormat:@"10"];
    AllRankingViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"AllRankingViewController"];
    [self presentModalViewController:vc animated:YES ];
}

- (IBAction)btn2:(id)sender {
    btnSelect = [NSString stringWithFormat:@"20"];
    AllRankingViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"AllRankingViewController"];
    [self presentModalViewController:vc animated:YES ];
}

- (IBAction)btn3:(id)sender {
    btnSelect = [NSString stringWithFormat:@"30"];
    AllRankingViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"AllRankingViewController"];
    [self presentModalViewController:vc animated:YES ];
}

- (IBAction)btn4:(id)sender {
    btnSelect = [NSString stringWithFormat:@"連続正解"];
    AllRankingViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"AllRankingViewController"];
    [self presentModalViewController:vc animated:YES ];
}

//外からbtnSelectを見るためのクラス
+ (NSString*)btnSelect {
    NSLog(@"qnum:%@",btnSelect);
    return btnSelect;
}


@end
