//
//  PTResultViewController.h
//  PokeType
//
//  Created by Satoshi SUZUKI on 2013/10/23.
//  Copyright (c) 2013年 AknEp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTResultViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property NSUInteger firstTypeId;
@property NSUInteger secondTypeId;

@end
