//
//  QuestionViewConyroller.m
//  CyberAgent
//
//  Created by 柏木 翔太 on 12/09/06.
//  Copyright (c) 2012年 上野 博司. All rights reserved.
//
//test

#import "ViewController.h"
#import "QuestionViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

@synthesize Questionimg;
@synthesize QuestionString;
@synthesize rightAndWrong;
@synthesize leftButton;
@synthesize rightButton;
@synthesize pv;

@synthesize questionQuantityNum;


//問題のボタンは右が正解だったらTrue
//           左が正解だったらFalse
bool questionAns = false;
//現在の問題数
int sequence;
NSMutableArray *anArray;
//正解数
int answerCount;
//問題数
int numQuestion;

//正誤判定
bool questionResult = false;

//問題を答えたかどうかの判定
BOOL questionSelected = true;

//正解したかどうかの表示を行うかどうかの値 0:非表示 1:正解 2:不正解
int resultShow;

//問題数
NSString *nq;

//問題数が無限の設定かどうか
BOOL infiniteMode;

//問題が入っているarrayの残りの大きさ
int questionArrayLength;

//バックボタンを起動させるかどうか
BOOL backBtn;


BOOL questionFinished;


BOOL flag = false;

//初期設定
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    return self;
}



/*
 問題のスタート設定
 */
- (void)viewDidLoad
{
    
    //現在の問題数
    sequence = 0;
    //正解数
    answerCount = 0;
    //問題数
    numQuestion = 0;
    //Timer管理の変数
    qOperator = 0.0;
    
    resultShow = 0;
    
    questionArrayLength = 0;
    
    //問題数が無限かどうか
    infiniteMode=false;
    
    //バックボタンを起動させるか
    backBtn = false;
    
    questionResult = false;
    
    questionFinished = false;
    
    
    //一つ前の画面で問題数を設定したのでその数字の格納
    //問題数の受け渡し
    nq = [ViewController Qnum];
//    
//    NSString *ImagePath = [[NSBundle mainBundle] pathForResource:@"image_5" ofType:@"jpg"];
//    UIImage *imege = [[UIImage alloc] initWithContentsOfFile:ImagePath];
//    Questionimg.image = imege;
// 
//
    

//[self countDown];
    
    
    
    //プログレスバー初期設定
    pv.progress = 1.0;
    //プログレスバーの色の変更
    pv.progressTintColor = [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:1.0f];

    //問題数の設定が無限かどうか
    if ([nq isEqualToString:@"200"]){
        infiniteMode = true;
        numQuestion = 2000;
    }
    //問題数に制限あり
    else{
        //問題数の設定
        numQuestion = [nq intValue];
        //numQuestion = 10;
        infiniteMode = false;
    }
    
    //問題文の設定
    anArray = [[NSMutableArray alloc] init];
    anArray = [ReadQuestionText SetTextToArray];
    
     //タイマーの部分
    NSLog(@"start");
    [NSTimer
    scheduledTimerWithTimeInterval:0.01
    target:self
    selector:@selector(questionOperator:)
    userInfo:nil
    repeats:YES];
    
    
    [super viewDidLoad];
    
    
    
    // ナビゲーションバーを生成
    objectNaviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    objectNaviBar.tintColor = [UIColor blackColor];
    
    // ナビゲーションアイテムを生成
    
    naviItem = [[UINavigationItem alloc] initWithTitle:@""];
    
    // 戻るボタンを生成
    backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(doBack:) ];

   // backButton.tintColor = [UIColor greenColor];

    
    
    // ナビゲーションアイテムの右側に戻るボタンを設置
    naviItem.leftBarButtonItem = backButton;
    //[naviItem.leftBarButtonItem  buttonWithType:101];
    
    // ナビゲーションバーにナビゲーションアイテムを設置
    [objectNaviBar pushNavigationItem:naviItem animated:YES];
    
    // ビューにナビゲーションアイテムを設置
    [self.view addSubview:objectNaviBar];
    
 	// Do any additional setup after loading the view.
    
}




// 戻るボタンの実装
- (void)doBack:(id)sender
{
    backBtn = true;
}

- (void)viewDidUnload
{
    [self setQuestionimg:nil];
    [self setQuestionString:nil];
    [self setRightAndWrong:nil];
    [self setLeftButton:nil];
    [self setRightButton:nil];
    [self setPv:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//前の画面から問題数の受け渡し
-(void)setQuestionQuantity: (NSString*)qq{
    
    NSLog(@"numtest=%@", qq);
    [questionQuantityNum setText:qq];
}


//次の画面に正解数を渡す
+(NSInteger*)answerNum{
    NSInteger *ansCount;
    ansCount = (NSInteger*)answerCount;
    NSLog(@"answerCount = %d ",answerCount);

    return ansCount;
}


//問題を呼び出したり色々な設定を行うところ
-(void)questionOperator:(NSTimer *)timer {
    
    
   
    //問題数無限大の時に設定の問題が足りなくなったらもっかい問題を取りに行く
    if([anArray count] == questionArrayLength +1){
        questionArrayLength = 0;
        anArray = [[NSMutableArray alloc] init];
        anArray = [ReadQuestionText SetTextToArray];
        questionArrayLength = 0;
    }
    
    //プログレスバーの値を変更する
    pv.progress = 1-(qOperator/4);
    
    
    //バックボタンを起動させる
    if (backBtn) {
        [timer invalidate];
        //問題文の開放
        [anArray removeAllObjects];
        NSLog(@"back");
        //   [self.navigationController popViewControllerAnimated:YES];
        ViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [self presentModalViewController:vc animated:YES ];

    }
    
    
    //時間切れによる不正解
    if (!questionSelected || qOperator  > 4.0) {
        NSLog(@"時間切れによる不正解");
        //問題は不正解
        questionResult = false;
        //不正解音を鳴らす
        [self AnswerSound];
        resultShow = 2;
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
    
    if (qOperator  > 4.0 || qOperator < 0.01) {
        sequence++;
        questionArrayLength++;
    }
    

    //問題の終了条件に入ったかどうか
    [self checkFinishedQuestion:timer];
    
    

    //新しい問題に遷移
    if ((qOperator  > 4.0 || qOperator < 0.01 )&& !questionFinished) {
        if(!questionResult){
            [self questionResultShow];
        }
        //questionResult = false;
        
        NSString *str = [NSString stringWithFormat : @"%d", sequence];
        str = [NSString stringWithFormat:@"問 %@",str];
        naviItem.title = str;
        [self changeQuestion];
        NSLog(@"%d",numQuestion);
        
    }
    
    //タイマーを管理する数字を更新する
    qOperator = qOperator + 0.01;
    
      
}

-(void)checkFinishedQuestion:(NSTimer *)timer {
    
    //問題の終了判定
    if (sequence-1 == numQuestion && !infiniteMode) {
        
        [timer invalidate];
        
        //問題文の開放
        [anArray removeAllObjects];
        
        //問題数に応じて行き先を変える
        if ([nq isEqualToString:@"10"]) {
            NSLog(@"Finished 10 question");
            ResultViewController *rvc= [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
            [self presentModalViewController:rvc animated:YES];
        }
        else if([nq isEqualToString:@"20"]){
            NSLog(@"Finished 50 question");
            Result50ViewController *rvc50= [self.storyboard instantiateViewControllerWithIdentifier:@"Result50ViewController"];
            [self presentModalViewController:rvc50 animated:YES ];
        }
        else if([nq isEqualToString:@"30"]){
            NSLog(@"Finished 100 question");
            Result100ViewController *rvc100 = [self.storyboard instantiateViewControllerWithIdentifier:@"Result100ViewController"];
            [self presentModalViewController:rvc100 animated:YES ];
        }
        
        NSLog(@"正解数は %d です",(int)answerCount);
        
        NSLog(@"stop");
        questionFinished = true;
    }
    //問題数無限大で問題を間違えたら結果に行く(sequenceは初期のバグ取り)
    else if(infiniteMode && !questionResult && sequence > 1) {
        [timer invalidate];
        
        //問題文の開放
        [anArray removeAllObjects];
        
        
        NSLog(@"Finished infinite question");
        ResultInfinityViewController *rvc= [self.storyboard instantiateViewControllerWithIdentifier:@"ResultInfinityViewController"];
        [self presentModalViewController:rvc animated:YES ];
        
        
        questionFinished = true;

    }

}

-(void) questionResultShow{
    
    //正解したかの画像を表示させる
    if (resultShow == 1){
        //正解のイメージを表示させる
        NSString *aImagePath = [[NSBundle mainBundle] pathForResource:@"seikai" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:aImagePath];
        iv = [[UIImageView alloc] initWithImage:image];
        
        
        [self.view addSubview:iv];
        NSLog(@"right show");
        
        iv.frame = CGRectMake(0, 0, 400, 300);
        iv.center = CGPointMake(160, 150);
        [UIView beginAnimations:nil context:nil];  // 条件指定開始
        [UIView setAnimationDuration:0.4];  // 0.2秒かけてアニメーションを終了させる
        [UIView setAnimationDelay:0.1];  // 3秒後にアニメーションを開始する
        [UIView setAnimationRepeatCount:1.0];  // アニメーションを5回繰り返す
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];  // アニメーションは一定速度
        iv.alpha = 0.0;
        
        [UIView commitAnimations];  // アニメーション開始！
        // [iv removeFromSuperview];
        
        resultShow = 0;
        
    }
    else if(resultShow == 2){
        NSString *aImagePath = [[NSBundle mainBundle] pathForResource:@"huseikai" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:aImagePath];
        iv = [[UIImageView alloc] initWithImage:image];
        
        
        [self.view addSubview:iv];
        NSLog(@"wrong show");
        
        iv.frame = CGRectMake(0, 0, 400, 300);
        iv.center = CGPointMake(175, 150);
        [UIView beginAnimations:nil context:nil];  // 条件指定開始
        [UIView setAnimationDuration:0.2];  // 2秒かけてアニメーションを終了させる
        [UIView setAnimationDelay:0.1];  // 3秒後にアニメーションを開始する
        [UIView setAnimationRepeatCount:1.0];  // アニメーションを5回繰り返す
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];  // アニメーションは一定速度
        iv.alpha = 0.0;
        
        [UIView commitAnimations];  // アニメーション開始！
        resultShow = 0;
        
    }

}


/*
 問題を変える
 */
- (void)changeQuestion{

    
    rightAndWrong.hidden = true;
    
    qOperator = 0.0;
    //問題に答えられたかどうかのbool値の初期化
    questionSelected = true;
    
    NSMutableArray *question = [[NSMutableArray alloc] init];

    
    //問題のセット
    question = [anArray objectAtIndex:questionArrayLength];
    
    
    //問題画像をセット
    NSString *imageName = [question objectAtIndex:0];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];    //問題文の種類の呼び出し
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    Questionimg.image = image;
    
    
    //問題文をセット
    NSString *questionText = [question objectAtIndex:1];
    QuestionString.text = questionText;
 
    
    //問題ボタンの設定
    [self setButton:question];
    

//    //正解数を数える
//    if(questionResult){
//        answerCount = answerCount + 1;
//    }
    
    //問題文をすすめる
}

/*
 問題ごとにボタンの情報をセットする
 */
-(void) setButton: (NSMutableArray*)quastion{
    
    //問題のボタンは右が正解だったらTrue
    //           左が正解だったらFalse
    
    //問題ボタンの設定
    NSString *questionAnsButtonText = [quastion objectAtIndex:2];
    NSString *questionNotAnsButtonText = [quastion objectAtIndex:3];
   
    //タイムシードを使って毎回同じ値が出ないようにした
    srandom(time(NULL));
    NSInteger answerSelect = random() % 2;
 //   NSInteger answerSelect = 0;
    
    NSLog(@"answerSelect %d",answerSelect);

    //右が正解
    if (answerSelect == 0) {
        
        //ボタンのラベルの設定
        [rightButton setTitle:questionAnsButtonText forState:UIControlStateNormal];
        [leftButton setTitle:questionNotAnsButtonText forState:UIControlStateNormal];

        //右が正解なのでtrue
        questionAns = true;

    }
    //左が正解
    else if(answerSelect == 1){
        
        //ボタンのラベルの設定
        [rightButton setTitle:questionNotAnsButtonText forState:UIControlStateNormal];
        [leftButton setTitle:questionAnsButtonText forState:UIControlStateNormal];

        //左が正解なのでfalse
        questionAns = false;
    }
    
}


-(void)AnswerSound{
    SystemSoundID soundID;
    
    //正解時
    if (questionResult) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"right" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        AudioServicesPlaySystemSound(soundID);
        
    }
    else{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"wrong" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        AudioServicesPlaySystemSound(soundID);
    }
}



/*
 問題の正解か不正解の判定（右ボタン）
 */
-(IBAction) judgmentQuastionRight:(UIButton *)sender{
    
   //右が正解だった場合
    if (questionAns) {
        NSLog(@"正解！！！");

        questionResult = true;

        //正解時に音を鳴らす
        [self AnswerSound];
        answerCount = answerCount + 1;

        
              
        resultShow = 1;
    }
    else{
        NSLog(@"不正解！！！");

        
        //不正解だった
        questionResult = false;

        
        //不正解時に音を鳴らす
        [self AnswerSound];
        
        resultShow = 2;
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

        //不正解のイメージを表示させる
//        NSString *aImagePath = [[NSBundle mainBundle] pathForResource:@"wrong" ofType:@"jpg"];
//        UIImage *imege = [[UIImage alloc] initWithContentsOfFile:aImagePath];
//        rightAndWrong.image = imege;
//        rightAndWrong.hidden = false;
//        [NSThread sleepForTimeInterval:1.0];        
    }

    
    //問題には答えた(正解かどうかはどうでもいい)
    questionSelected = true;
    
    NSLog(@"push button answerCount = %d",(int)answerCount);
    qOperator = 0.0;
    
    
    [self questionResultShow];

}

/*
 問題の正解か不正解の判定（左ボタン）
 */
-(IBAction) judgmentQuastionLeft:(UIButton *)sender{

    if(!questionAns){
        NSLog(@"正解！！！");
        //正解だった
        questionResult = true;

        //正解時に音を鳴らす
        [self AnswerSound];
        answerCount = answerCount + 1;
                
        //正解のイメージを表示させる
        resultShow = 1;
    }
    else{
        NSLog(@"不正解！！！");
        
        
        //不正解だった
        questionResult = false;

        //不正解時に音を鳴らす
        [self AnswerSound];

        
        //不正解のイメージを表示させる
        resultShow = 2;
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

    }
    //問題には答えた(正解かどうかはどうでもいい)
    questionSelected = true;

    
    NSLog(@"push button answerCount = %d",(int)answerCount);

    qOperator = 0.0;
    
    [self questionResultShow];

}




@end
