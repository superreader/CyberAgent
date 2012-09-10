//
//  ViewController.h
//  CyberAgent
//
//  Created by 上野 博司 on 12/09/05.
//  Copyright (c) 2012年 上野 博司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
     UISegmentedControl * segment1;
}

+ (NSString*)Qnum;

//test
- (IBAction)questionQuantity:(id)sender;
- (IBAction)btnStart:(id)sender;

@property (nonatomic, retain) IBOutlet
UISegmentedControl * segment1;

@end
