//
//  AppAPI.m
//  GCOriginal
//
//  Created by Lucas Fang on 5/15/15.
//  Copyright (c) 2015 Lucas Fang. All rights reserved.
//

#import "AppAPI.h"

@implementation AppAPI


+ (CGRect)getScreenBoundsDependOnOrientation
{
    CGRect screenBounds = [UIScreen mainScreen].bounds ;
    if(IS_IOS8){
        return screenBounds ;
    }
    CGFloat width = CGRectGetWidth(screenBounds)  ;
    CGFloat height = CGRectGetHeight(screenBounds) ;
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        screenBounds.size = CGSizeMake(width, height);
    }else if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        screenBounds.size = CGSizeMake(height, width);
    }
    return screenBounds ;
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
@end
