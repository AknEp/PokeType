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

@interface PTViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *type1PickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *type2PickerView;

@end

@implementation PTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if( [self.type1PickerView selectedRowInComponent:0] == [self.type2PickerView selectedRowInComponent:0] ){
        //TODO UIAlertView 出したい。 後でBlockKitを入れてからにする？
        // ... ボタンの押下が可不可で表現すべき？
        
        return NO;
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PTResultViewController *resultViewController = segue.destinationViewController;
    resultViewController.firstTypeId = [self.type1PickerView selectedRowInComponent:0];
    resultViewController.secondTypeId = [self.type2PickerView selectedRowInComponent:0];
}


@end
