//
//  AppAPI.h
//  GCOriginal
//
//  Created by Lucas Fang on 5/15/15.
//  Copyright (c) 2015 Lucas Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

// App
#import "AppConfig.h"

// PebbleKit
#import "PebbleKit/PebbleKit.h"

// AFNetworking
#import <AFNetworking.h>
// FlatUIKit
#import <FlatUIKit/FlatUIKit.h>
// Mantle
#import <Mantle/Mantle.h>
// Masonry
#import <Masonry.h>
// MBProgressHUD
#import "MBProgressHUD.h"
// POP
#import <pop/POP.h>
// ReactiveCocoa
#import <ReactiveCocoa/ReactiveCocoa.h>
// Shimmer
#import <Shimmer/FBShimmeringView.h>

@interface AppAPI : NSObject

+ (CGRect)getScreenBoundsDependOnOrientation;
+ (FUIButton *)ButtonWithTitle:(NSString *)title inBold:(BOOL)IsBold;
+ (UIColor *)getColorWithRGBAinHex:(NSUInteger)color;



@end
