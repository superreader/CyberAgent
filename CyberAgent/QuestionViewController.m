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
#import "ResultViewController.h"
#import "ReadQuestionText.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioServices.h>

@interface QuestionViewController ()

@end

@implementation QuestionViewController

@synthesize Questionimg;
@synthesize QuestionString;
@synthesize rightAndWrong;
@synthesize leftButton;
@synthesize rightButton;

@synthesize questionQuantityNum;


//問題のボタンは右が正解だったらTrue
//           左が正解だったらFalse
bool questionAns = false;
//現在の問題数
int sequence = 0;
NSMutableArray *anArray ;
//正解数
int answerCount = 0;
//問題数
int numQuestion = 5;

//正誤判定
bool questionResult = false;

//問題を答えたかどうかノ判定
BOOL questionSelected = true;


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
    
    sequence = 0;
    answerCount= 0;

    //一つ前の画面で問題数を設定したのでその数字の格納
    //問題数の受け渡し
    NSString *nq = [ViewController Qnum];
    numQuestion = [nq intValue];
    
    
    NSString *ImagePath = [[NSBundle mainBundle] pathForResource:@"image_5" ofType:@"jpg"];
    UIImage *imege = [[UIImage alloc] initWithContentsOfFile:ImagePath];
    Questionimg.image = imege;
 
    
    
    
    //問題文の設定
    anArray = [[NSMutableArray alloc] init];
    anArray= [ReadQuestionText SetTextToArray];
    
    
  
    
    //タイマーの部分
    NSLog(@"start");
    [NSTimer
    scheduledTimerWithTimeInterval:3.5
    target:self
    selector:@selector(tmp:)
    userInfo:nil
    repeats:YES];
    
    [super viewDidLoad];
    
 	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setQuestionimg:nil];
    [self setQuestionString:nil];
    [self setRightAndWrong:nil];
    [self setLeftButton:nil];
    [self setRightButton:nil];
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
    ansCount = answerCount;
    return ansCount;
}

-(void)tmp:(NSTimer *)timer {
    [timer invalidate];
    [self changeQuestion];
    //問題の終了判定
    if (sequence >= numQuestion /*&& [timer isValid]*/) {
        [timer invalidate];
        
        ResultViewController *rvc= [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
        [self presentModalViewController:rvc animated:YES ];
        NSLog(@"正解数は %d です",(int)answerCount);
        
        NSLog(@"stop");
    }
    
}

/*
 問題を変える
 */
- (void)changeQuestion{

    
    //問題に答えられたかどうかのbool値の初期化
    questionSelected = true;
    



    
    //問題のセット
    NSMutableArray *quastion = [[NSMutableArray alloc] init];
    quastion = [anArray objectAtIndex:sequence];
    
    
    //問題画像をセット
    NSString *imageName = [quastion objectAtIndex:0];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];    //問題文の種類の呼び出し
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    Questionimg.image = image;
    
    
    //問題文をセット
    NSString *questionText = [quastion objectAtIndex:1];
    QuestionString.text = questionText;
 
    
    //問題ボタンの設定
    [self setButton:quastion];
    
    
        
    //時間切れによる不正解
    if (!questionSelected) {
        NSLog(@"時間切れによる不正解");
        
    }else{
           }
    
    
    
    if(questionResult){
        //正解数を数える
        answerCount = answerCount + 1;
    }
    
    //問題文をすすめる
    sequence++;
    
    
        
    
//    //問題の終了判定
//    if (sequence >= numQuestion /*&& [timer isValid]*/) {
//        [timer invalidate];
//        
//        ResultViewController *rvc= [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
//        [self presentModalViewController:rvc animated:YES ];
//        NSLog(@"正解数は %d です",(int)answerCount);
//        
//        NSLog(@"stop");
//    }
//    NSLog(@"changeQuestion  answerCount = %d",(int)answerCount);

    
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
   
    NSInteger answerSelect = rand() % 2;
    
    NSLog(@"answerSelect %d",answerSelect);

    //右が正解
    if (answerSelect == 0) {
        
        //ボタンのラベルの設定
        rightButton.titleLabel.text = questionAnsButtonText;
        leftButton.titleLabel.text = questionNotAnsButtonText;
        //右が正解なのでtrue
        questionAns = true;

    }
    //左が正解
    else if(answerSelect == 1){
        
        //ボタンのラベルの設定
        leftButton.titleLabel.text = questionAnsButtonText;
        rightButton.titleLabel.text = questionNotAnsButtonText;
        //左が正解なのでfalse
        questionAns = false;
    }
    
}


-(void)AnswerSound{
    SystemSoundID soundID;
    
    //正解時
    if (questionAns) {
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
    
    //ボタンを押したので次の問題までロック！！
    [leftButton setTitle:@"押せません" forState:UIControlStateDisabled];
    [rightButton setTitle:@"押せません" forState:UIControlStateDisabled];

    
    //右が正解だった場合
    if (questionAns) {
        NSLog(@"正解！！！");

        questionResult = true;

        //正解時に音を鳴らす
        [self AnswerSound];

        
              
        //正解のイメージを表示させる
        NSString *aImagePath = [[NSBundle mainBundle] pathForResource:@"right" ofType:@"jpg"];
        UIImage *imege = [[UIImage alloc] initWithContentsOfFile:aImagePath];
        rightAndWrong.image = imege;
        rightAndWrong.hidden = false;
        [self.view addSubview:rightAndWrong];
        //rightAndWrong.hidden = true;
        
        


    }
    else{
        NSLog(@"不正解！！！");

        
        //不正解だった
        questionResult = false;

        
        //不正解時に音を鳴らす
        [self AnswerSound];
        
        
        //不正解のイメージを表示させる
        NSString *aImagePath = [[NSBundle mainBundle] pathForResource:@"wrong" ofType:@"jpg"];
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:aImagePath];
        UIImageView *image = [[UIImageView alloc] initWithImage:img];
        
    }

    
    //問題には答えた(正解かどうかはどうでもいい)
    questionSelected = true;
    
//    // タイマーを停止したい場合
//    [timer invalidate];
//    NSLog(@"Timer Status : %d",[timer isValid]);
//
    
    NSLog(@"push button answerCount = %d",(int)answerCount);
    [self changeQuestion];

}



/*
 問題の正解か不正解の判定（左ボタン）
 */
-(IBAction) judgmentQuastionLeft:(UIButton *)sender{
    
    
    //ボタンを押したので次の問題までロック！！
    [leftButton setTitle:@"押せません" forState:UIControlStateDisabled];
    [rightButton setTitle:@"押せません" forState:UIControlStateDisabled];
    
    
    if(!questionAns){
        NSLog(@"正解！！！");
        //不正解だった
        questionResult = false;

        
        //正解時に音を鳴らす
        [self AnswerSound];
        
        
        
        //正解のイメージを表示させる
        NSString *aImagePath = [[NSBundle mainBundle] pathForResource:@"right" ofType:@"jpg"];
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:aImagePath];
        UIImageView *image = [[UIImageView alloc] initWithImage:img];
        
        //正解イメージのセット
        rightAndWrong = image;
        rightAndWrong.hidden = NO;
//        rightAndWrong.hidden = true;
        
        

    }
    else{
        NSLog(@"不正解！！！");
        
        
        //不正解だった
        questionResult = false;

        //不正解時に音を鳴らす
        [self AnswerSound];

        
        //不正解のイメージを表示させる
        NSString *aImagePath = [[NSBundle mainBundle] pathForResource:@"wrong" ofType:@"jpg"];
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:aImagePath];
        UIImageView *image = [[UIImageView alloc] initWithImage:img];
        

    }
    //問題には答えた(正解かどうかはどうでもいい)
    questionSelected = true;

    
    NSLog(@"push button answerCount = %d",(int)answerCount);

    [self changeQuestion];
}



/*
 正解か不正解かの表示
*/
-(void)rightAndWorng:(NSTimer *)timer{
    
    //正誤表示
    if(questionResult){
        
        //正解のイメージを表示させる
        NSString *aImagePath = [[NSBundle mainBundle] pathForResource:@"right" ofType:@"jpg"];
        UIImage *imege = [[UIImage alloc] initWithContentsOfFile:aImagePath];
        rightAndWrong.image = imege;
        rightAndWrong.hidden = false;
        
        NSLog(@"right Sound");
        //スリープ処理
        //        [NSThread sleepForTimeInterval:0.5];
        //  rightAndWrong.hidden = true;
        
    }
    else{
        
        //不正解のイメージを表示させる
        NSString *aImagePath = [[NSBundle mainBundle] pathForResource:@"wrong" ofType:@"mp3"];
        UIImage *imege = [[UIImage alloc] initWithContentsOfFile:aImagePath];
        rightAndWrong.image = imege;
        rightAndWrong.hidden = false;
        
        NSLog(@"wrong Sound");

        //スリープ処理
        //[NSThread sleepForTimeInterval:0.5];
        
    }

}
//
////問題文を設定する
//-(void)setQuestion{
//    anArray = [[NSMutableArray alloc] init];
//    
//    
//    
//    //    for(int num = 0 ;num < 5;num++){
//    NSMutableArray *quastion = [[NSMutableArray alloc] init];
//    //画像の名前、問題、問題の正解、問題の不正解
//    NSString *imageName = [NSString stringWithFormat:@"image_0"];
//    NSString *quastionText = [NSString stringWithFormat:@"彼らの芸歴は30年より"];
//    NSString *answer = [NSString stringWithFormat:@"短い"];
//    NSString *notAnswer = [NSString stringWithFormat:@"長い"];
//    [quastion addObject:imageName];
//    [quastion addObject:quastionText];
//    [quastion addObject:answer];
//    [quastion addObject:notAnswer];
//    
//    [anArray addObject:quastion];
//    
//    
//    quastion = [[NSMutableArray alloc] init];
//    //画像の名前、問題、問題の正解、問題の不正解(FUZIWARA)
//    imageName = [NSString stringWithFormat:@"image_1"];
//    quastionText = [NSString stringWithFormat:@"彼らの芸歴は20年より"];
//    answer = [NSString stringWithFormat:@"長い"];
//    notAnswer = [NSString stringWithFormat:@"短い"];
//    [quastion addObject:imageName];
//    [quastion addObject:quastionText];
//    [quastion addObject:answer];
//    [quastion addObject:notAnswer];
//    
//    [anArray addObject:quastion];
//    
//    
//    quastion = [[NSMutableArray alloc] init];
//    //画像の名前、問題、問題の正解、問題の不正解(とんねるず)
//    imageName = [NSString stringWithFormat:@"image_2"];
//    quastionText = [NSString stringWithFormat:@"彼らの芸歴は30年より"];
//    answer = [NSString stringWithFormat:@"長い"];
//    notAnswer = [NSString stringWithFormat:@"短い"];
//    [quastion addObject:imageName];
//    [quastion addObject:quastionText];
//    [quastion addObject:answer];
//    [quastion addObject:notAnswer];
//    
//    [anArray addObject:quastion];
//    
//    
//    
//    quastion = [[NSMutableArray alloc] init];
//    //画像の名前、問題、問題の正解、問題の不正解(くりーむしちゅー)
//    imageName = [NSString stringWithFormat:@"image_3"];
//    quastionText = [NSString stringWithFormat:@"彼らの芸歴は20年より"];
//    answer = [NSString stringWithFormat:@"短い"];
//    notAnswer = [NSString stringWithFormat:@"長い"];
//    [quastion addObject:imageName];
//    [quastion addObject:quastionText];
//    [quastion addObject:answer];
//    [quastion addObject:notAnswer];
//    [anArray addObject:quastion];
//    
//    
//    
//    quastion = [[NSMutableArray alloc] init];
//    //画像の名前、問題、問題の正解、問題の不正解(キャイ～ン)
//    imageName = [NSString stringWithFormat:@"image_4"];
//    quastionText = [NSString stringWithFormat:@"彼らの芸歴は20年より"];
//    answer = [NSString stringWithFormat:@"長い"];
//    notAnswer = [NSString stringWithFormat:@"短い"];
//    [quastion addObject:imageName];
//    [quastion addObject:quastionText];
//    [quastion addObject:answer];
//    [quastion addObject:notAnswer];
//    
//    [anArray addObject:quastion];
//    
//    
//    quastion = [[NSMutableArray alloc] init];
//    //画像の名前、問題、問題の正解、問題の不正解(キャイ～ン)
//    imageName = [NSString stringWithFormat:@"right"];
//    quastionText = [NSString stringWithFormat:@"end"];
//    answer = [NSString stringWithFormat:@"end"];
//    notAnswer = [NSString stringWithFormat:@"end"];
//    [quastion addObject:imageName];
//    [quastion addObject:quastionText];
//    [quastion addObject:answer];
//    [quastion addObject:notAnswer];
//    
//    [anArray addObject:quastion];
//    //  }
//}

@end
