//
//  ResultInfinityViewController.m
//  CyberAgent
//
//  Created by 柏木翔太 on 12/09/05.
//  Copyright (c) 2012年 柏木翔太. All rights reserved.
//

#import "QuestionViewController.h"
#import "ResultInfinityViewController.h"


@interface ResultInfinityViewController ()

@end

@implementation ResultInfinityViewController
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
    
    ans = (int)[QuestionViewController answerNum];
    
    SystemSoundID soundID;
    UIImageView *iv;

    
    //全問正解時の処理
    if (ans >= 40 && ans < 50 ){
        
        //正解のイメージを表示させる
        NSString *aImagePath = [[NSBundle mainBundle] pathForResource:@"hosi1" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:aImagePath];
        iv = [[UIImageView alloc] initWithImage:image];
        
        [self.view addSubview:iv];
        NSLog(@"全問正解エフェクト");
        
        iv.frame = CGRectMake(0, 0, 300, 300);
        iv.center = CGPointMake(160, 150);
        [UIView beginAnimations:nil context:nil];  // 条件指定開始
        [UIView setAnimationDuration:1];  // 0.2秒かけてアニメーションを終了させる
        [UIView setAnimationDelay:0.1];  // 3秒後にアニメーションを開始する
        [UIView setAnimationRepeatCount:1.0];  // アニメーションを5回繰り返す
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];  // アニメーションは一定速度
        iv.alpha = 0.0;
        
        [UIView commitAnimations];  // アニメーション開始！
        
        //音を鳴らす
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hakusyu" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        AudioServicesPlaySystemSound(soundID);
    }else if(ans >= 50 && ans <70){
        
        //正解のイメージを表示させる
        NSString *aImagePath = [[NSBundle mainBundle] pathForResource:@"hosi2" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:aImagePath];
        iv = [[UIImageView alloc] initWithImage:image];
        
        [self.view addSubview:iv];
        NSLog(@"全問正解エフェクト");
        
        iv.frame = CGRectMake(0, 0, 300, 300);
        iv.center = CGPointMake(160, 150);
        [UIView beginAnimations:nil context:nil];  // 条件指定開始
        [UIView setAnimationDuration:1];  // 0.2秒かけてアニメーションを終了させる
        [UIView setAnimationDelay:0.1];  // 3秒後にアニメーションを開始する
        [UIView setAnimationRepeatCount:1.0];  // アニメーションを5回繰り返す
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];  // アニメーションは一定速度
        iv.alpha = 0.0;
        
        [UIView commitAnimations];  // アニメーション開始！
        
        //音を鳴らす
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hakusyu" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        AudioServicesPlaySystemSound(soundID);
        
    }else if(ans >= 70 && ans <100){
        
        //正解のイメージを表示させる
        NSString *aImagePath = [[NSBundle mainBundle] pathForResource:@"hosi3" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:aImagePath];
        iv = [[UIImageView alloc] initWithImage:image];
        
        [self.view addSubview:iv];
        NSLog(@"全問正解エフェクト");
        
        iv.frame = CGRectMake(0, 0, 300, 300);
        iv.center = CGPointMake(160, 150);
        [UIView beginAnimations:nil context:nil];  // 条件指定開始
        [UIView setAnimationDuration:1];  // 0.2秒かけてアニメーションを終了させる
        [UIView setAnimationDelay:0.1];  // 3秒後にアニメーションを開始する
        [UIView setAnimationRepeatCount:1.0];  // アニメーションを5回繰り返す
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];  // アニメーションは一定速度
        iv.alpha = 0.0;
        
        [UIView commitAnimations];  // アニメーション開始！
        
        //音を鳴らす
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hakusyu" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        AudioServicesPlaySystemSound(soundID);
        
    }else if(ans >= 100 ){
        
        //正解のイメージを表示させる
        NSString *aImagePath = [[NSBundle mainBundle] pathForResource:@"oukan" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:aImagePath];
        iv = [[UIImageView alloc] initWithImage:image];
        
        [self.view addSubview:iv];
        NSLog(@"全問正解エフェクト");
        
        iv.frame = CGRectMake(0, 0, 300, 300);
        iv.center = CGPointMake(160, 150);
        [UIView beginAnimations:nil context:nil];  // 条件指定開始
        [UIView setAnimationDuration:1];  // 0.2秒かけてアニメーションを終了させる
        [UIView setAnimationDelay:0.1];  // 3秒後にアニメーションを開始する
        [UIView setAnimationRepeatCount:1.0];  // アニメーションを5回繰り返す
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];  // アニメーションは一定速度
        iv.alpha = 0.0;
        
        [UIView commitAnimations];  // アニメーション開始！
        
        //音を鳴らす
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hakusyu" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        AudioServicesPlaySystemSound(soundID);
    }
    
    self.ResultLabel.text = [NSString stringWithFormat:@"連続%d問正解！！",ans];
    
    ud = [NSUserDefaults standardUserDefaults];//保存先のオブジェクトの宣言
    numinf = [ud integerForKey:@"KEY_numinf"];//何回目のプレイかを記憶する変数numの宣言
    
    //    int array[num+1];//int配列の宣言
    
    [ud setInteger:ans forKey:[NSString stringWithFormat:@"inf-%d",numinf]];//Keyに変数numを指定し、ansの値を保存先オブジェクトに保存
    
    //tableViewの背景を透明にする
    self.tableView.backgroundColor = [UIColor clearColor];

    numinf++;
    [ud setInteger:numinf forKey:@"KEY_numinf"];
    
    // Do any additional setup after loading the view.
}

//tableの設定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numinf;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //ランキングデータのロードとソート開始
    int array[numinf];//ソート用配列の宣言
    for(i=0;i<=numinf;i++){
        s = [ud integerForKey:[NSString stringWithFormat:@"inf-%d",i]];  // Keyに変数iを指定し、内容をinteger型として取得
        array[i]=s;//配列に代入
    }
    
    //int配列のソート
    for (i = 0; i <numinf; i++) {
        for (j = numinf; j > i; j--) {
            if (array[j-1] < array[j]) {
                tmp = array[j-1];
                array[j-1] = array[j];
                array[j] = tmp;
            }
        }
    }
    //ランキングデータのロードとソート終了
    
    //ansの結果がランキング中で何位なのかを調べる
    for(i=0;i<=numinf;i++){
        if(array[numinf-i]==ans){
            zyuni=(numinf-i+1);//同立の場合は直近の結果が上位になる数式アルゴリズム
        }
    }
    
    //結果が何位かの表示
    self.yourRank.text = [NSString stringWithFormat:@"あなたの順位は%d位です！！",zyuni];
    
    static NSString *MyIdentifier = @"MyIdentifer";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];    }
    
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
