//
//  CentralViewController.m
//  GCOriginal
//
//  Created by Lucas Fang on 5/15/15.
//  Copyright (c) 2015 Lucas Fang. All rights reserved.
//

#import "CentralViewController.h"
#import "PebbleKit/PebbleKit.h"
#import <FlatUIKit/FlatUIKit.h>
#import "AppConfig.h"

@interface CentralViewController ()

@end

@implementation CentralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"BLE Central";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}

- (void)updateViewConstraints {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









+ (FUIButton *)ButtonWithTitle:(NSString *)title inBold:(BOOL)IsBold
{
    FUIButton *button = [[FUIButton alloc] init];
    button.buttonColor = [self getColorWithRGBAinHex:ThemeColor01];
    button.shadowColor = [self getColorWithRGBAinHex:ThemeColor01_Variation01];
    button.shadowHeight = 1.0f;
    button.cornerRadius = 6.0f;
    if (IsBold) {
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:FontSize_P1];
    }else{
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:FontSize_P1];
    }
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    return button;
}

+ (UIColor *)getColorWithRGBAinHex:(NSUInteger)color
{
    return [UIColor colorWithRed:((color >> 24) & 0xFF) / 255.0f
                           green:((color >> 16) & 0xFF) / 255.0f
                            blue:((color >> 8) & 0xFF) / 255.0f
                           alpha:((color) & 0xFF) / 255.0f];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
