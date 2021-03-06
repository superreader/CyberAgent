//
//  CountDownViewController.m
//  CyberAgent
//
//  Created by 柏木翔太 on 12/09/05.
//  Copyright (c) 2012年 柏木翔太. All rights reserved.
//


#import "CountDownViewController.h"
#import "QuestionViewController.h"

@interface CountDownViewController ()

@end


int sequence;

@implementation CountDownViewController
@synthesize CountDown;

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
    
//    UIImage *backgroundImage = [UIImage imageNamed:@"back.png"];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    NSLog(@"viewDidLoad start");
    
    sequence = 3;
        
    [NSTimer
     scheduledTimerWithTimeInterval:1
     target:self
     selector:@selector(countDown:)
     userInfo:nil
     repeats:YES];
    
    //画像の設定
    [self changeImage:sequence];
    sequence--;
    
	// Do any additional setup after loading the view.
}

-(void)countDown : (NSTimer*)timer{
    
    
    if(sequence > 0){
    
        //問題画像をセット
        [self changeImage:sequence];
        sequence--;
        NSLog(@"sequence %d",sequence);
        
    
    }else if(sequence == 0){
        
        //一拍開けるため
        [NSTimer
         scheduledTimerWithTimeInterval:1
         target:self
         selector:@selector(tmp:)
         userInfo:nil
         repeats:YES];

        //Viewの呼び出し
        [timer invalidate];
        QuestionViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionViewController"];
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;//アニメーションの指定
        [self presentModalViewController:vc animated:YES ];
                
    }
    

}
-(void)changeImage:(int)sequence{
    NSString *str = [NSString stringWithFormat : @"%d", sequence];
    str = [NSString stringWithFormat:@"%@",str];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:str ofType:@"png"];    //問題文の種類の呼び出し
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    //UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    
    
    //[self.view addSubview: iv];
    CountDown.image = image;
    
    //アニメーションの設定
    self.CountDown.alpha = 1.0;
	self.CountDown.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.CountDown.alpha = 1.0;
                         self.CountDown.transform = CGAffineTransformMakeScale(2.2, 2.2);
                     }
     ];

    

}
-(void)tmp : (NSTimer*)timer{
    [timer invalidate];
}

- (void)viewDidUnload
{
    [self setCountDown:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
