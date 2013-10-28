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
#import "PTFlurry.h"

@interface PTSerachViewController ()

@property NSArray *result;

@end

@implementation PTSerachViewController

- (void)viewDidLoad
{
    self.searchDisplayController.searchBar.delegate = self;
    [self search:@""];
    [super viewDidLoad];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.result count];
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
    if( [segue.identifier isEqualToString:@"GoToResult"] ){
        
        NSIndexPath *indexPath = nil;
        if( self.tableView.indexPathForSelectedRow ){
            indexPath = self.tableView.indexPathForSelectedRow;
        }
        if( self.searchDisplayController.searchResultsTableView.indexPathForSelectedRow ){
            indexPath = self.searchDisplayController.searchResultsTableView.indexPathForSelectedRow;
        }
        
        NSDictionary *pokemon = self.result[indexPath.row];
        NSArray *types = pokemon[@"types"];
        
        PTResultViewController *resultViewController = segue.destinationViewController;
        resultViewController.firstTypeId = [types[0] integerValue];
        resultViewController.secondTypeId = [types[1] integerValue];
        
        [PTFlurry logGoToPokemon:pokemon];
    }
    
}

#pragma UISearchDisplayControllerDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [PTFlurry logSearchPokemon:searchString];
    
    NSMutableString *mutableConvertedString = [searchString mutableCopy];
    CFStringTransform((CFMutableStringRef)mutableConvertedString, NULL, kCFStringTransformHiraganaKatakana, false);
    NSString *convertedString = [NSString stringWithString:mutableConvertedString];
    if( ! [convertedString isEqualToString:searchString] ){
        self.searchDisplayController.searchBar.text = convertedString;
        return NO;
    }
    
    [self search:convertedString];
    
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView
{
    [self search:@""];
    [self.tableView reloadData];
}

#pragma UISearchBarDelegate

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    
//    NSString *baseString = searchBar.text;
//    NSCharacterSet *alphabetSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
//    NSRange alphabetRange = [baseString rangeOfCharacterFromSet:alphabetSet];
//    
//    if( alphabetRange.location == NSNotFound){
//        return YES;
//    }
//    
//    searchBar.text = [baseString stringByReplacingCharactersInRange:range withString:text];
    return YES;
}

#pragma mark - Search Helper

- (void)search:(NSString*)query
{
    self.result = [PTType search:query];
}

@end
