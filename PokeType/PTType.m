//
//  PTType.m
//  PokeType
//
//  Created by Satoshi SUZUKI on 2013/10/23.
//  Copyright (c) 2013年 AknEp. All rights reserved.
//
// ノ	炎	水	電	草	氷	格	毒	地	飛	超	虫	岩	霊	竜	悪	鋼	妖

#import "PTType.h"


@interface PTType()

@end

@implementation PTType

+ (NSUInteger)countOfTypes
{
    return 19;
}

+ (NSString*)stringForTypeId:(NSUInteger)typeId
{
    NSArray *types =
    @[
      @"選択しない",
      @"ノーマル",
      @"ほのお",
      @"みず",
      @"でんき",
      @"くさ",
      @"こおり",
      @"かくとう",
      @"どく",
      @"じめん",
      @"ひこう",
      @"エスパー",
      @"むし",
      @"いわ",
      @"ゴースト",
      @"ドラゴン",
      @"あく",
      @"はがね",
      @"フェアリー",
      ];
    return types[typeId];
}

+ (NSDictionary*)structuredResultWithFirstTypeId:(NSUInteger)firstTypeId secondTypeId:(NSUInteger)secondTypeId
{
    NSArray *result = [self resultWithFirstTypeId:firstTypeId secondTypeId:secondTypeId];
    
    NSMutableArray *quadruples = [NSMutableArray array];
    NSMutableArray *doubles    = [NSMutableArray array];
    NSMutableArray *halves     = [NSMutableArray array];
    NSMutableArray *quarters   = [NSMutableArray array];
    NSMutableArray *zeros      = [NSMutableArray array];
    
    // 1から初めているのは、0番の「選択しない」を飛ばすためです。
    for( NSUInteger typeId=1; typeId<[PTType countOfTypes]; typeId++ ){
        NSNumber *powerNumber = result[typeId];
        double power = [powerNumber doubleValue];
        
        if( power == 4.0 ){
            [quadruples addObject:@(typeId)];
        }
        
        if( power == 2.0 ){
            [doubles addObject:@(typeId)];
        }
        
        if( power == 0.5 ){
            [halves addObject:@(typeId)];
        }
        
        if( power == 0.25 ){
            [quarters addObject:@(typeId)];
        }
        
        if( power == 0.0 ){
            [zeros addObject:@(typeId)];
        }
        
    }
    
    return
    @{
      @"quadruples" : [NSArray arrayWithArray:quadruples],
      @"doubles"    : [NSArray arrayWithArray:doubles],
      @"quarters"   : [NSArray arrayWithArray:quarters],
      @"halves"     : [NSArray arrayWithArray:halves],
      @"zeros"      : [NSArray arrayWithArray:zeros],
      };
    
}

+ (NSArray*)resultWithFirstTypeId:(NSUInteger)firstTypeId secondTypeId:(NSUInteger)secondTypeId
{
    NSArray *typeTable = [self typeTable];
    
    NSArray *firstTypePower = [typeTable objectAtIndex:firstTypeId];
    NSArray *secondTypePower = [typeTable objectAtIndex:secondTypeId];
    
    
    NSMutableArray *resultPower = [NSMutableArray arrayWithCapacity:[self countOfTypes]];
    
    for( NSInteger count=0; count< [self countOfTypes]; count++ ){
        resultPower[count] = @([firstTypePower[count] doubleValue] * [secondTypePower[count] doubleValue]);
    }
    
    return [NSArray arrayWithArray:resultPower];
}


#pragma protected like methods


+ (NSArray*)typeTable
{
    return @[
             @[@(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0)], // 選択しない
             @[@(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(0.5), @(1.0), @(1.0), @(1.0), @(0.5), @(1.0)], // ノーマル
             @[@(1.0), @(1.0), @(1.0), @(0.5), @(0.5), @(1.0), @(2.0), @(2.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(2.0), @(0.5), @(1.0), @(0.5), @(1.0), @(2.0), @(1.0)], // ほのお
             @[@(1.0), @(1.0), @(1.0), @(2.0), @(0.5), @(1.0), @(0.5), @(1.0), @(1.0), @(1.0), @(2.0), @(1.0), @(1.0), @(1.0), @(2.0), @(1.0), @(0.5), @(1.0), @(1.0), @(1.0)], // みず
             @[@(1.0), @(1.0), @(1.0), @(1.0), @(2.0), @(0.5), @(0.5), @(1.0), @(1.0), @(1.0), @(1.0), @(2.0), @(1.0), @(1.0), @(1.0), @(1.0), @(0.5), @(1.0), @(1.0), @(1.0)], // でんき
             @[@(1.0), @(1.0), @(1.0), @(0.5), @(2.0), @(1.0), @(0.5), @(1.0), @(1.0), @(0.5), @(2.0), @(0.5), @(1.0), @(0.5), @(2.0), @(1.0), @(0.5), @(1.0), @(0.5), @(1.0)], // くさ
             @[@(1.0), @(1.0), @(1.0), @(0.5), @(0.5), @(1.0), @(2.0), @(0.5), @(1.0), @(1.0), @(2.0), @(2.0), @(1.0), @(1.0), @(1.0), @(1.0), @(2.0), @(1.0), @(0.5), @(1.0)], // こおり
             @[@(1.0), @(1.0), @(2.0), @(1.0), @(1.0), @(1.0), @(1.0), @(2.0), @(1.0), @(0.5), @(1.0), @(0.5), @(0.5), @(0.5), @(2.0), @(1.0), @(1.0), @(2.0), @(2.0), @(0.5)], // かくとう
             @[@(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(2.0), @(1.0), @(1.0), @(0.5), @(0.5), @(1.0), @(1.0), @(1.0), @(0.5), @(0.5), @(1.0), @(1.0), @(1.0), @(2.0)], // どく
             @[@(1.0), @(1.0), @(1.0), @(2.0), @(1.0), @(2.0), @(0.5), @(1.0), @(1.0), @(2.0), @(1.0), @(1.0), @(1.0), @(0.5), @(2.0), @(1.0), @(1.0), @(1.0), @(2.0), @(1.0)], // じめん
             @[@(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(0.5), @(2.0), @(1.0), @(2.0), @(1.0), @(1.0), @(1.0), @(1.0), @(2.0), @(0.5), @(1.0), @(1.0), @(1.0), @(0.5), @(1.0)], // ひこう
             @[@(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(2.0), @(2.0), @(1.0), @(1.0), @(0.5), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(0.5), @(1.0)], // エスパー
             @[@(1.0), @(1.0), @(1.0), @(0.5), @(1.0), @(1.0), @(2.0), @(1.0), @(0.5), @(0.5), @(1.0), @(0.5), @(2.0), @(1.0), @(1.0), @(0.5), @(1.0), @(2.0), @(0.5), @(0.5)], // むし
             @[@(1.0), @(1.0), @(1.0), @(2.0), @(1.0), @(1.0), @(1.0), @(2.0), @(0.5), @(1.0), @(0.5), @(2.0), @(1.0), @(2.0), @(1.0), @(1.0), @(1.0), @(1.0), @(0.5), @(1.0)], // いわ
             @[@(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(2.0), @(1.0), @(1.0), @(2.0), @(1.0), @(0.5), @(1.0), @(1.0)], // ゴースト
             @[@(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(2.0), @(1.0), @(0.5), @(1.0)], // ドラゴン
             @[@(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(0.5), @(1.0), @(1.0), @(1.0), @(2.0), @(1.0), @(1.0), @(2.0), @(1.0), @(0.5), @(1.0), @(0.5)], // あく
             @[@(1.0), @(1.0), @(1.0), @(0.5), @(0.5), @(0.5), @(1.0), @(2.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(2.0), @(1.0), @(1.0), @(1.0), @(0.5), @(2.0)], // はがね
             @[@(1.0), @(1.0), @(1.0), @(0.5), @(1.0), @(1.0), @(1.0), @(1.0), @(2.0), @(0.5), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(1.0), @(2.0), @(2.0), @(0.5), @(1.0)], // フェアリー
             ];
}

@end
