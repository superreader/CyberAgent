//
//  RankingViewSelectViewController.h
//  CyberAgent
//
//  Created by 柏木翔太 on 12/09/05.
//  Copyright (c) 2012年 柏木翔太. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingViewSelectViewController : UIViewController{
    UINavigationBar* objectNaviBar;
    
    
    // ナビゲーションアイテムを生成
    UINavigationItem* naviItem;
    
    // 戻るボタンを生成
    UIBarButtonItem* backButton;

}

+ (NSString*)btnSelect;

- (IBAction)btn1:(id)sender;
- (IBAction)btn2:(id)sender;
- (IBAction)btn3:(id)sender;
- (IBAction)btn4:(id)sender;



@end
