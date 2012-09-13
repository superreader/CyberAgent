//
//  CountDownViewController.m
//  CyberAgent
//
//  Created by 上野 博司 on 12/09/12.
//  Copyright (c) 2012年 上野 博司. All rights reserved.
//

#import "CountDownViewController.h"
#import "QuestionViewController.h"

@interface CountDownViewController ()

@end


int sequence;

@implementation CountDownViewController

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
    
    UIImage *backgroundImage = [UIImage imageNamed:@"back.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    NSLog(@"viewDidLoad start");
    sequence = 3;
    
    [NSTimer
     scheduledTimerWithTimeInterval:1
     target:self
     selector:@selector(countDown:)
     userInfo:nil
     repeats:YES];
    
   
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)countDown : (NSTimer*)timer{
    
    if(sequence > 0){
    //問題画像をセット
    NSString *str = [NSString stringWithFormat : @"%d", sequence];
    str = [NSString stringWithFormat:@"%@",str];

    NSString *imagePath = [[NSBundle mainBundle] pathForResource:str ofType:@"png"];    //問題文の種類の呼び出し
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview: iv];
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

        [timer invalidate];
        QuestionViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionViewController"];
        [self presentModalViewController:vc animated:YES ];
     
        
    }
    

}
-(void)tmp : (NSTimer*)timer{
 //   [NSThread sleepForTimeInterval:1.0];
    [timer invalidate];
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

@end
