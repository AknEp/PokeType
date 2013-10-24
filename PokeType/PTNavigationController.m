//
//  PTNavigationController.m
//  PokeType
//
//  Created by Satoshi SUZUKI on 2013/10/24.
//  Copyright (c) 2013年 AknEp. All rights reserved.
//

#import "PTNavigationController.h"

#import <FlurrySDK/Flurry.h>

@interface PTNavigationController ()

@end

@implementation PTNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [Flurry logAllPageViews:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
