//
//  ReadQuestionText.m
//  CyberAgent
//
//  Created by 柏木翔太 on 12/09/05.
//  Copyright (c) 2012年 柏木翔太. All rights reserved.
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
    
    srandom(time(NULL));
            
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

    int i = [matrics count];
    
    while (--i >0)
    {
        int j = random() % (i+1);
        [matrics exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    
    for(int i = 0 ; i <  30 ; i++){
        [tmp addObject:[matrics objectAtIndex:i]];
    }
    
    return tmp;
}

@end
