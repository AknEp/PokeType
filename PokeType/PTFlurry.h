//
//  PTFlurry.h
//  PokeType
//
//  Created by Satoshi SUZUKI on 2013/10/24.
//  Copyright (c) 2013年 AknEp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTFlurry : NSObject

+ (void)logSearchPokemon:(NSString*)query;
+ (void)logGoToPokemon:(NSDictionary*)pokemon;
+ (void)logSearchType:(NSUInteger)type1 type2:(NSUInteger)type2;

@end
