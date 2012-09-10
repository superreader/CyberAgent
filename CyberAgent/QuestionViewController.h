//
//  QuestionViewConyroller.h
//  CyberAgent
//
//  Created by 柏木 翔太 on 12/09/06.
//  Copyright (c) 2012年 上野 博司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionViewController : UIViewController{
    IBOutlet UILabel *label;
}

//クラスメソッド
+(NSInteger*)answerNum;


- (IBAction)shuffleQuestionImage:(NSInteger)questionQuantity;
- (void)setQuestion;
- (IBAction) judgmentQuastionRight:(UIButton *)sender;
- (IBAction) judgmentQuastionLeft:(UIButton *)sender;
-(void)setQuestionQuantity: (NSString*)qq;
-(void)AnswerSound;

@property  (nonatomic, retain) IBOutlet UILabel *label;

@property (strong, nonatomic) NSString *questionNumLabel;


@property (weak, nonatomic) IBOutlet UIImageView *Questionimg;

@property (weak, nonatomic) IBOutlet UILabel *QuestionString;

@property (strong, nonatomic) IBOutlet UIImageView *rightAndWrong;

@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;


@end
