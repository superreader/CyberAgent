//
//  Ranking50ViewController.m
//  CyberAgent
//
//  Created by 柏木 翔太 on 12/09/10.
//  Copyright (c) 2012年 上野 博司. All rights reserved.
//

#import "Ranking50ViewController.h"

@interface Ranking50ViewController ()

@end

@implementation Ranking50ViewController
@synthesize ResultLabel;
@synthesize yourRank;
@synthesize tableView;

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
    
    //ans = (int)[QuestionViewController answerNum];
    
    ans = rand() % 100;//0～9の数値をランダムに取得
    //ans = (int)[QuestionViewController answerNum];
    
    
    self.ResultLabel.text = [NSString stringWithFormat:@"正解数は%d問です！！",ans];
    
    ud = [NSUserDefaults standardUserDefaults];//保存先のオブジェクトの宣言
    numfif = [ud integerForKey:@"KEY_numfif"];//何回目のプレイかを記憶する変数numの宣言
    
    //    int array[num+1];//int配列の宣言
    
    [ud setInteger:ans forKey:[NSString stringWithFormat:@"50-%d",numfif]];//Keyに変数numを指定し、ansの値を保存先オブジェクトに保存
    
    /*
     //int型配列に今までの結果をコピー
     for(i=0;i<=num;i++){
     s = [ud integerForKey:[NSString stringWithFormat:@"%d",i]];  // Keyに変数iを指定し、内容をinteger型として取得
     array[i]=s;//配列に代入
     }
     
     //int配列内の表示
     NSLog(@"int配列内の表示開始");
     for(i=0;i<=num;i++){
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
     for(i=0;i<=num;i++){
     NSLog(@"%d",array[i]);
     }
     NSLog(@"ソート後int配列内の表示終了");
     */
    
    numfif++;
    [ud setInteger:numfif forKey:@"KEY_numfif"];
    
    // Do any additional setup after loading the view.
}

//tableの設定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numfif;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //ランキングデータのロードとソート開始
    int array[numfif];//ソート用配列の宣言
    for(i=0;i<=numfif;i++){
        s = [ud integerForKey:[NSString stringWithFormat:@"50-%d",i]];  // Keyに変数iを指定し、内容をinteger型として取得
        array[i]=s;//配列に代入
    }
    
    //int配列のソート
    for (i = 0; i <numfif; i++) {
        for (j = numfif ; j > i; j--) {
            if (array[j-1] < array[j]) {
                tmp = array[j-1];
                array[j-1] = array[j];
                array[j] = tmp;
            }
        }
    }
    //ランキングデータのロードとソート終了
    
    //ansの結果がランキング中で何位なのかを調べる
    for(i=0;i<=numfif;i++){
        if(array[numfif-i]==ans){
            zyuni=(numfif-i+1);//同立の場合は直近の結果が上位になる数式アルゴリズム
        }
    }
    
    //結果が何位かの表示
    self.yourRank.text = [NSString stringWithFormat:@"あなたの順位は%d位です！！",zyuni];
    
    static NSString *MyIdentifier = @"MyIdentifer";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier];
    }
    
    //セルに表示する内容を代入
    cell.textLabel.text = [NSString stringWithFormat:@"%d位　　　　　　　　%d問",(indexPath.row+1),array[indexPath.row]];
    
    //セルの選択時の処理をなくす(ハイライトをなくす)
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //セルインクタンスを返す
    return cell;
}

//今回の順位のセルの色を変える
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row  == zyuni-1) {
        cell.backgroundColor = [UIColor colorWithHue:0.33
                                          saturation:1.0
                                          brightness:1.0
                                               alpha:1.0];
    }
}

//tableの設定終了

- (void)viewDidUnload
{
    [self setResultLabel:nil];
    [self setYourRank:nil];
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
