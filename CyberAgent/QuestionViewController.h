//
//  QuestionViewConyroller.h
//  CyberAgent
//
//  Created by 柏木翔太 on 12/09/05.
//  Copyright (c) 2012年 柏木翔太. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "ReadQuestionText.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioServices.h>
#import "AllResultViewController.h"

@interface QuestionViewController : UIViewController{
    IBOutlet UILabel *questionQuantityNum;
    double qOperator;
    UIImageView *iv;
    UINavigationBar* objectNaviBar;
    
    
    // ナビゲーションアイテムを生成
    UINavigationItem* naviItem;
    
    // 戻るボタンを生成
    UIBarButtonItem* backButton;
}

//クラスメソッド
+(NSInteger*)answerNum;


- (IBAction)shuffleQuestionImage:(NSInteger)questionQuantity;
- (void)setQuestion;
- (IBAction) judgmentQuastionRight:(UIButton *)sender;
- (IBAction) judgmentQuastionLeft:(UIButton *)sender;
-(void)setQuestionQuantity: (NSString*)qq;
-(void)AnswerSound;

@property  (nonatomic, retain) IBOutlet UILabel *questionQuantityNum;

@property (strong, nonatomic) NSString *questionNumLabel;


@property (weak, nonatomic) IBOutlet UIImageView *Questionimg;

@property (weak, nonatomic) IBOutlet UILabel *QuestionString;

@property (strong, nonatomic) IBOutlet UIImageView *rightAndWrong;

@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;


@property (weak, nonatomic) IBOutlet UIProgressView *pv;


@end
