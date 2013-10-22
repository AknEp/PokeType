//
//  PTResultViewController.m
//  PokeType
//
//  Created by Satoshi SUZUKI on 2013/10/23.
//  Copyright (c) 2013年 AknEp. All rights reserved.
//

#import "PTResultViewController.h"

#import "PTType.h"

@interface PTResultViewController ()

@property NSDictionary *result;

@end

@implementation PTResultViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.result = [PTType structuredResultWithFirstTypeId:self.firstTypeId secondTypeId:self.secondTypeId];
}

- (NSString*)sectionStringWithId:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"quadruples";
            break;
        case 1:
            return @"doubles";
            break;
        case 2:
            return @"halves";
            break;
        case 3:
            return @"quarters";
            break;
        case 4:
            return @"zeros";
            break;
    }
    return nil;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.result objectForKey:[self sectionStringWithId:section]] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            if( [[self.result objectForKey:[self sectionStringWithId:section]] count] > 0 ){
                return @"4倍";
            }
            break;
        case 1:
            if( [[self.result objectForKey:[self sectionStringWithId:section]] count] > 0 ){
                return @"2倍";
            }
            break;
        case 2:
            if( [[self.result objectForKey:[self sectionStringWithId:section]] count] > 0 ){
                return @"1/2";
            }
            break;
        case 3:
            if( [[self.result objectForKey:[self sectionStringWithId:section]] count] > 0 ){
                return @"1/4";
            }
            break;
        case 4:
            if( [[self.result objectForKey:[self sectionStringWithId:section]] count] > 0 ){
                return @"こうかがない";
            }
            break;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    UILabel *label = (UILabel *)[cell viewWithTag:10];
    NSNumber *typeId = self.result[[self sectionStringWithId:indexPath.section]][indexPath.row];
    label.text = [PTType stringForTypeId:[typeId integerValue]];
    
    return cell;
}

#pragma mark - UITableViewDelegate


@end
