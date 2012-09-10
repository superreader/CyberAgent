//
//  ReadQuestionText.m
//  CyberAgent
//
//  Created by 上野 博司 on 12/09/08.
//  Copyright (c) 2012年 上野 博司. All rights reserved.
//

#import "ReadQuestionText.h"

@implementation ReadQuestionText


/*
 CSVファイルからデータを読み取る
 */
+ (NSString*)ReadCSVFile{
    
    NSString *targetFileNametxt = @"QuestionText";
    NSString* path = [[NSBundle mainBundle] pathForResource:targetFileNametxt ofType:@"csv"];
    NSString* text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@ = %@",targetFileNametxt,text);
    
    return text;
}


/*
 問題データをArrayに詰める
 */
+(NSMutableArray*)SetTextToArray{
    
    NSString *text = [self ReadCSVFile];
    NSArray* lines = [text componentsSeparatedByString:@"\n"];
    
    NSString *obj;
    NSArray *items;
    NSMutableArray *matrics; // 保管する配列
    matrics = [[NSMutableArray alloc]initWithCapacity:1];
    for(obj in lines){
        items =[obj componentsSeparatedByString:@","]; //コンマごとに区切る
        [matrics addObject:items]; // matrics に入れる。
    }


    
    
    return matrics;
}

@end
