//
//  AllRankingViewController.m
//  CyberAgent
//
//  Created by 柏木 翔太 on 12/09/20.
//  Copyright (c) 2012年 上野 博司. All rights reserved.
//

#import "AllRankingViewController.h"
#import "RankingViewSelectViewController.h"

@interface AllRankingViewController ()

@end

@implementation AllRankingViewController

//バックボタンを起動させるかどうか
@synthesize tableView;
BOOL backBtn;

//問題数
NSString *nq;

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
    
    //問題数の受け渡し
    nq = [RankingViewSelectViewController btnSelect];
    
    ud = [NSUserDefaults standardUserDefaults];//保存先のオブジェクトの宣言
    
    /************************ナビゲーションバー**********************************************/
    // ナビゲーションバーを生成
    objectNaviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    objectNaviBar.tintColor = [UIColor blackColor];
    // ナビゲーションアイテムを生成
    naviItem = [[UINavigationItem alloc] initWithTitle:@""];
    // 戻るボタンを生成
    backButton = [[UIBarButtonItem alloc] initWithTitle:@"戻る" style:UIBarButtonItemStyleBordered target:self action:@selector(doBack:) ];
    //backButton.tintColor = [UIColor greenColor];
    
    // ナビゲーションアイテムの右側に戻るボタンを設置
    naviItem.leftBarButtonItem = backButton;
    //[naviItem.leftBarButtonItem  buttonWithType:101];
    // ナビゲーションバーにナビゲーションアイテムを設置
    [objectNaviBar pushNavigationItem:naviItem animated:YES];
    // ビューにナビゲーションアイテムを設置
    [self.view addSubview:objectNaviBar];
    //タイトルを設定
    if ([nq isEqualToString:@"連続正解"]) {
        NSString *str = [NSString stringWithFormat : @"連続正解数ランキング"];
        str = [NSString stringWithFormat:@"%@",str];
        naviItem.title = str;
    }else{
        NSString *str = [NSString stringWithFormat : @"%@問正解数ランキング",nq];
        str = [NSString stringWithFormat:@"%@",str];
        naviItem.title = str;
    }
    /************************ナビゲーションバー**********************************************/
        
    if ([nq isEqualToString:@"10"]) {
        num = [ud integerForKey:@"KEY_num"];//何回目のプレイかを記憶する変数numをロード
    }else if([nq isEqualToString:@"20"]){
        num = [ud integerForKey:@"KEY_numfif"];//何回目のプレイかを記憶する変数numをロード
    }else if([nq isEqualToString:@"30"]){
        num = [ud integerForKey:@"KEY_numhun"];//何回目のプレイかを記憶する変数numをロード
    }else {
        num = [ud integerForKey:@"KEY_numinf"];//何回目のプレイかを記憶する変数numをロード
    }
    
    //tableViewの背景を透明にする
    self.tableView.backgroundColor = [UIColor clearColor];

	// Do any additional setup after loading the view.
}

// 戻るボタンの実装
- (void)doBack:(id)sender
{
    backBtn = true;
    RankingViewSelectViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"RankingViewSelectViewController"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;//アニメーションの指定
    [self presentModalViewController:vc animated:YES ];
}

//tableの設定開始

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //データの取得とソート
    int array[num];//ソート用int型配列の宣言
    
    //全てのデータをint型配列に代入
    if ([nq isEqualToString:@"10"]) {
        for(i=0;i<=num;i++){
            s = [ud integerForKey:[NSString stringWithFormat:@"%d",i]];  // Keyに変数iを指定し、内容をinteger型として取得
            array[i]=s;//配列に代入
        }
    }else if([nq isEqualToString:@"20"]){
        for(i=0;i<=num;i++){
            s = [ud integerForKey:[NSString stringWithFormat:@"50-%d",i]];  // Keyに変数iを指定し、内容をinteger型として取得
            array[i]=s;//配列に代入
        }
    }else if([nq isEqualToString:@"30"]){
        for(i=0;i<=num;i++){
            s = [ud integerForKey:[NSString stringWithFormat:@"100-%d",i]];  // Keyに変数iを指定し、内容をinteger型として取得
            array[i]=s;//配列に代入
        }
    }else {
        for(i=0;i<=num;i++){
            s = [ud integerForKey:[NSString stringWithFormat:@"inf-%d",i]];  // Keyに変数iを指定し、内容をinteger型として取得
            array[i]=s;//配列に代入
        }
    }
    
    //int配列のソート
    for (i = 0; i <num; i++) {
        for (j = num ; j > i; j--) {
            if (array[j-1] < array[j]) {
                tmp = array[j-1];
                array[j-1] = array[j];
                array[j] = tmp;
            }
        }
    }
    //データの取得とソート終了
    
    static NSString *MyIdentifier = @"MyIdentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    //アラインを中央にする。
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    
    //セルに表示する内容を代入
    cell.textLabel.text = [NSString stringWithFormat:@"%d位　　    　　　%d問",(indexPath.row+1),array[indexPath.row]];
    
    //セルの選択時の処理をなくす(ハイライトをなくす)
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //セルの文字色を変える
    cell.textLabel.textColor = [UIColor whiteColor];
    
    //セルインクタンスを返す
    return cell;
}


//tableの設定終了

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
