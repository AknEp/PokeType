//
//  PTViewController.m
//  PokeType
//
//  Created by Satoshi SUZUKI on 2013/10/23.
//  Copyright (c) 2013年 AknEp. All rights reserved.
//

#import "PTViewController.h"

#import "PTResultViewController.h"
#import "PTType.h"
#import "PTFlurry.h"

@interface PTViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *type1PickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *type2PickerView;

@end

@implementation PTViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self configureCanGoToResult];
}

#pragma mark UIPickerViewDataSource & Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [PTType countOfTypes];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [PTType stringForTypeId:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self configureCanGoToResult];
}

#pragma - Configuring Views

- (void) configureCanGoToResult
{
    BOOL canGoToResult = ( [self.type1PickerView selectedRowInComponent:0] != [self.type2PickerView selectedRowInComponent:0] );
    
    self.navigationItem.rightBarButtonItem.enabled = canGoToResult;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( [segue.identifier isEqualToString:@"GoToResult"] ){
        PTResultViewController *resultViewController = segue.destinationViewController;
        
        NSUInteger firstTypeId = [self.type1PickerView selectedRowInComponent:0];
        NSUInteger secondTypeId = [self.type2PickerView selectedRowInComponent:0];
        
        resultViewController.firstTypeId = firstTypeId;
        resultViewController.secondTypeId = secondTypeId;
        
        [PTFlurry logSearchType:firstTypeId type2:secondTypeId];
    }
}


@end
