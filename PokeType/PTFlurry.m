//
//  PTFlurry.m
//  PokeType
//
//  Created by Satoshi SUZUKI on 2013/10/24.
//  Copyright (c) 2013年 AknEp. All rights reserved.
//

#import "PTFlurry.h"

#import <FlurrySDK/Flurry.h>

static NSString * const PTFlurrySearchPokemon = @"Search Pokemon";
static NSString * const PTFlurrySearchType = @"Search Type";
static NSString * const PTFlurryGoToPokemon = @"Go To Pokemon";

@implementation PTFlurry

+ (void)logSearchPokemon:(NSString*)query
{
    [Flurry logEvent:PTFlurrySearchPokemon withParameters:@{@"query":query}];
}

+ (void)logGoToPokemon:(NSDictionary*)pokemon
{
    [Flurry logEvent:PTFlurryGoToPokemon withParameters:pokemon];
}

+ (void)logSearchType:(NSUInteger)type1 type2:(NSUInteger)type2
{
    [Flurry logEvent:PTFlurrySearchType withParameters:@{@"type1":@(type1),@"type2":@(type2)}];
}

@end
