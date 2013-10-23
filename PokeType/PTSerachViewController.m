//
//  PTSerachViewController.m
//  PokeType
//
//  Created by Satoshi SUZUKI on 2013/10/24.
//  Copyright (c) 2013年 AknEp. All rights reserved.
//

#import "PTSerachViewController.h"

#import "PTResultViewController.h"

#import "PTType.h"

@interface PTSerachViewController ()

@property NSArray *result;

@end

@implementation PTSerachViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *query = self.searchDisplayController.searchBar.text;
    self.result = [PTType search:query];
    return [self.result count];
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // ここで self.tableView をつかっているのは意図的なものです。 こうしないと、scopeを選択したときに正しく動作しません。
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSDictionary *poke = self.result[indexPath.row];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:10];
    UILabel *numberLabel = (UILabel *)[cell viewWithTag:21];
    UILabel *typeLabel = (UILabel *)[cell viewWithTag:22];
    
    nameLabel.text = poke[@"name"];
    numberLabel.text = [poke[@"num"] stringValue];
    
    NSArray *types = poke[@"types"];
    NSUInteger firstTypeId  = [types[0] integerValue];
    NSUInteger secondTypeId = [types[1] integerValue];
    
    NSString *firstTypeString  = [PTType stringForTypeId:firstTypeId];
    NSString *secondTypeString = [PTType stringForTypeId:secondTypeId];
    
    if( firstTypeId == 0 ){
        typeLabel.text = secondTypeString;
    }else if( secondTypeId == 0 ){
        typeLabel.text = firstTypeString;
    }else{
        typeLabel.text = [NSString stringWithFormat:@"%@ / %@", firstTypeString, secondTypeString];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = nil;
    if( self.tableView.indexPathForSelectedRow ){
        indexPath = self.tableView.indexPathForSelectedRow;
    }
    if( self.searchDisplayController.searchResultsTableView.indexPathForSelectedRow ){
        indexPath = self.searchDisplayController.searchResultsTableView.indexPathForSelectedRow;
    }
    
    NSArray *types = self.result[indexPath.row][@"types"];
    
    PTResultViewController *resultViewController = segue.destinationViewController;
    resultViewController.firstTypeId = [types[0] integerValue];
    resultViewController.secondTypeId = [types[1] integerValue];
    
}

@end
