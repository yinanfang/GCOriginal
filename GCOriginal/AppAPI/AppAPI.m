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




+ (UIColor *)getColorWithRGBAinHex:(NSUInteger)color
{
    return [UIColor colorWithRed:((color >> 24) & 0xFF) / 255.0f
                           green:((color >> 16) & 0xFF) / 255.0f
                            blue:((color >> 8) & 0xFF) / 255.0f
                           alpha:((color) & 0xFF) / 255.0f];
}
@end

#pragma mark - UIkit and Foundation extention
@implementation UILabel (AdvancedInitialization)
+ (UILabel *)LabelTitleWithString:(NSString *)title align:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = alignment;
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:FontSize_H1]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[AppAPI getColorWithRGBAinHex:ThemeColor01]];
    [label setText:title];
    return label;
}

+ (UILabel *)LabelSubTitleWithString:(NSString *)title align:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = alignment;
    [label setFont:[UIFont fontWithName:@"Helvetica" size:FontSize_P1]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[AppAPI getColorWithRGBAinHex:ThemeColor01]];
    [label setText:title];
    return label;
}
@end


@implementation UIButton (AdvancedInitialization)
+ (UIButton *)ButtonWithTitle:(NSString *)title inBold:(BOOL)IsBold horizontalAlign:(UIControlContentHorizontalAlignment)horizontalAlign
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.contentEdgeInsets = Insets_Button;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    if (IsBold) {
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:FontSize_P1];
    }else{
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:FontSize_P1];
    }
    button.contentHorizontalAlignment = horizontalAlign;
    button.layer.borderWidth = WidthForEntryfieldBorder;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.cornerRadius = CornerRadius_General;
    button.clipsToBounds = YES;
    return button;
}
@end

@implementation FUIButton (AdvancedInitialization)
+ (FUIButton *)ButtonWithTitle:(NSString *)title inBold:(BOOL)IsBold
{
    FUIButton *button = [[FUIButton alloc] init];
    button.buttonColor = [AppAPI getColorWithRGBAinHex:ThemeColor01];
    button.shadowColor = [AppAPI getColorWithRGBAinHex:ThemeColor01_Variation01];
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
@end

@implementation UITextField (AdvancedInitialization)
+ (UITextField *)TextFieldWithPlaceHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType
{
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:FontSize_P1];
    textField.placeholder = placeHolder;
    textField.autocorrectionType = UITextAutocorrectionTypeYes;
    textField.keyboardType = keyboardType;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return textField;
}
@end

@implementation UIImageView (AdvancedInitialization)
+ (UIImageView *)ImageViewWithDefaultBackgroundImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor lightGrayColor];
    if (image) {
        [imageView setImage:image];
    }
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.cornerRadius = CornerRadius_General;
    imageView.clipsToBounds = YES;
    return imageView;
}
@end
