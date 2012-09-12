//
//  Ranking50ViewController.m
//  CyberAgent
//
//  Created by 柏木 翔太 on 12/09/11.
//  Copyright (c) 2012年 上野 博司. All rights reserved.
//

#import "Ranking50ViewController.h"
#import "RankingViewSelectViewController.h"

@interface Ranking50ViewController ()

@end

@implementation Ranking50ViewController
@synthesize tableView;

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
    
    ud = [NSUserDefaults standardUserDefaults];//保存先のオブジェクトの宣言
    num = [ud integerForKey:@"KEY_numfif"];//何回目のプレイかを記憶する変数numをロード
        
    /*
     int array[num+1];//int配列の宣言
     
     //int型配列に今までの結果をコピー
     for(i=0;i<=num;i++){
     s = [ud integerForKey:[NSString stringWithFormat:@"%d",i]];  // Keyに変数iを指定し、内容をinteger型として取得
     array[i]=s;//配列に代入
     }
     
     //int配列内の表示
     NSLog(@"int配列内の表示開始");
     for(i=0;i<num;i++){
     NSLog(@"%d",array[i]);
     }
     NSLog(@"int配列内の表示終了");
     
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
     
     //ソート後int配列の表示
     NSLog(@"ソート後int配列内の表示開始");
     for(i=0;i<num;i++){
     NSLog(@"%d",array[i]);
     }
     NSLog(@"ソート後int配列内の表示終了");
     */
    
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
    
    if(num==0){
        NSString *str = [NSString stringWithFormat : @"まだプレイしていません"];
        str = [NSString stringWithFormat:@"%@",str];
        naviItem.title = str;
    }else{
        NSString *str = [NSString stringWithFormat : @"20問中正解数ランキング"];
        str = [NSString stringWithFormat:@"%@",str];
        naviItem.title = str;
    }
        
	// Do any additional setup after loading the view.
}

// 戻るボタンの実装
- (void)doBack:(id)sender
{
    backBtn = true;
    RankingViewSelectViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"RankingViewSelectViewController"];
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
    for(i=0;i<=num;i++){
        s = [ud integerForKey:[NSString stringWithFormat:@"50-%d",i]];  // Keyに変数iを指定し、内容をinteger型として取得
        array[i]=s;//配列に代入
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
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier];
    }
    
    //アラインを中央にする。
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    
    //セルに表示する内容を代入
    cell.textLabel.text = [NSString stringWithFormat:@"%d位　　    　　　%d問",(indexPath.row+1),array[indexPath.row]];
    //セルの選択時の処理をなくす(ハイライトをなくす)
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
