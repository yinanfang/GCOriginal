//
//  CentralViewController.m
//  GCOriginal
//
//  Created by Lucas Fang on 5/15/15.
//  Copyright (c) 2015 Lucas Fang. All rights reserved.
//

#import "CentralViewController.h"
#import "AppAPI.h"

@interface CentralViewController ()

@property BOOL didSetupConstraints;

@property FUIButton *btn_Push;


@end

@implementation CentralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"BLE Central";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.btn_Push = [AppAPI ButtonWithTitle:@"Push" inBold:YES];
    [self.view addSubview:self.btn_Push];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Show View" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
    
    [self updateViewConstraints];
}

- (void)updateViewConstraints {
    if(!self.didSetupConstraints) {
        // App logo
        NSLog(@"setting up constraints");
        
        
        [self.btn_Push mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-ScreenHeight/5);
            make.size.mas_equalTo(CGSizeMake(250, 60));
            
            

        }];
        
        
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
