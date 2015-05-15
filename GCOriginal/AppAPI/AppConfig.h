//
//  AppConfig.h
//  GCOriginal
//
//  Created by Lucas Fang on 5/15/15.
//  Copyright (c) 2015 Lucas Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

// Theme Color
#define ThemeColor01                0x1D4E89FF  // PANTONE 19-4052 Classic Blue
#define ThemeColor01_Variation01    0x567DABFF  // More black. Go down
#define ThemeColor01_Variation02    0x376296FF  // More black. Go down
#define ThemeColor01_Variation03    0x113B6EFF  // More black. Go down
#define ThemeColor01_Variation04    0x062954FF  // More black. Go down

#define FontSize_H1                 18.0f
#define FontSize_H2                 16.0f
#define FontSize_P1                 16.0f


#pragma mark - Device Type
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE5S ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE4S ([[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IOS8 (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)
#define IS_IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#pragma mark - Screen width and height
// iPhone4S@2x: W*H = 320*480
// iPhone5S@R4: W*H = 320*568
#define ScreenBounds                [AppAPI getScreenBoundsDependOnOrientation]
#define ScreenSize                  [AppAPI getScreenBoundsDependOnOrientation].size
#define ScreenWidth                 [AppAPI getScreenBoundsDependOnOrientation].size.width
#define ScreenHeight                [AppAPI getScreenBoundsDependOnOrientation].size.height
// Keyboard
#define KeyboardSizePortrait        CGRectMake(320, 216)
#define KeyboardHeightPortrait      216.0f
#define KeyboardSizeLandscape       CGRectMake(480, 162)       // iPhone 4
#define KeyboardHeightLandscape     162.0f

#pragma mark - Math
#define METERS_PER_MILE 1609.344


@interface AppConfig : NSObject

@end
