//
//  ViewController.m
//  CyberAgent
//
//  Created by 上野 博司 on 12/09/05.
//  Copyright (c) 2012年 上野 博司. All rights reserved.
//

#import "ViewController.h"
#import "QuestionViewController.h"

@interface ViewController ()

@end

@implementation ViewController


static  NSString *Qnum;

- (IBAction)startBtn1:(id)sender {
    Qnum = [NSString stringWithFormat:@"10"];
}

- (IBAction)startBtn2:(id)sender {
    Qnum = [NSString stringWithFormat:@"20"];
}

- (IBAction)startBtn3:(id)sender {
    Qnum = [NSString stringWithFormat:@"30"];
}

- (IBAction)startBtn4:(id)sender {
    Qnum = [NSString stringWithFormat:@"200"];
}

- (void)viewDidLoad
{
    
   Qnum = [NSString stringWithFormat:@"10"];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

/*
//セグメントで選ばれた問題数を表示
- (IBAction)questionQuantity:(id)sender {
    int index = [sender selectedSegmentIndex];
    Qnum = [NSString stringWithFormat:@"10"];
    if (index == 0) {
         Qnum = [NSString stringWithFormat:@"10"];
    }
    else if(index == 1){
        Qnum = [NSString stringWithFormat:@"50"];
    }
    else if(index == 2){
        Qnum = [NSString stringWithFormat:@"100"];
    }
    else if(index == 3){
        Qnum = [NSString stringWithFormat:@"200"];
    }
  
    NSLog(@"Qnum = %@",Qnum);
}
 */

+ (NSString*)Qnum {
    NSLog(@"qnum:%@",Qnum);
    return Qnum;
}

//- (IBAction)btnStart:(id)sender {
//    // サブ画面のビューコントローラを取得
//    QuestionViewConyroller *qvc = [[QuestionViewConyroller alloc] initWithNibName:nil bundle:nil];
//    [self presentModalViewController:qvc animated:YES];
//
//    // サブ画面のmsgValueプロパティに文字列を代入
//    [qvc setQuestionQuantity:Qnum];
//}

@end
