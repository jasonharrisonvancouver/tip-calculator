//
//  ViewController.m
//  TipCalculator
//
//  Created by jason harrison on 2019-01-18.
//  Copyright © 2019 jason harrison. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UIButton *tipButton;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (weak, nonatomic) IBOutlet UISlider *adjustTipPercentage;

@end

@implementation TipViewController
- (IBAction)slideTipValueChanged:(UISlider *)sender {
    double tipAmount = sender.value/100 * [self.billAmountTextField.text doubleValue];
    self.tipPercentageTextField.text = @"";
    self.tipPercentageTextField.text = [NSString stringWithFormat:@"%f%%", sender.value];
    
    self.tipAmountLabel.text = @"";
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppearance) name:<#(nullable NSNotificationName)#> object:nil]
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // if top of keyboard size will be higher than the bottom of the tipAmountLabel
    
    //if(keyboardSize.height)
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

- (IBAction)calculateTip:(UIButton *)sender {
    double tipAmount = [self.tipPercentageTextField.text doubleValue]/100 * [self.billAmountTextField.text doubleValue];
    self.tipAmountLabel.text = @"";
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
}

@end
