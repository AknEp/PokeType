//
//  PTType.h
//  PokeType
//
//  Created by Satoshi SUZUKI on 2013/10/23.
//  Copyright (c) 2013年 AknEp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTType : NSObject

+ (NSUInteger)countOfTypes;
+ (NSString*)stringForTypeId:(NSUInteger)typeId;

@end
