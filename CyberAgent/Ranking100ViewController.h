//
//  Ranking100ViewController.h
//  CyberAgent
//
//  Created by 柏木 翔太 on 12/09/11.
//  Copyright (c) 2012年 上野 博司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ranking100ViewController : UIViewController{
    
    NSInteger num;//何回目のゲームンなのかを記録する変数
    
    NSUserDefaults *ud;//結果の保存用
    
    NSMutableArray *rank;//ソート後のiny型arrayを表示用に格納するための配列
    
    int i,j;//for分用
    int tmp;//ソート時に使う一時的な変数
    int s;//保存されている数値を配列にコピーする時に使う一次変数
    
}

@property (weak, nonatomic) IBOutlet UILabel *RankingToptxt;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end