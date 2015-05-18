//
//  CentralViewController.m
//  GCOriginal
//
//  Created by Lucas Fang on 5/15/15.
//  Copyright (c) 2015 Lucas Fang. All rights reserved.
//

#import "CentralViewController.h"
#import "AppAPI.h"

@interface CentralViewController () <PBPebbleCentralDelegate>

@property BOOL didSetupConstraints;

@property FUIButton *btn_selection1, *btn_selection2, *btn_selection3, *btn_selection4, *btn_selected;

@property int selectedType;

@property FUIButton *btn_Push;
@property UILabel *label_Status;

@property PBWatch *watch;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property NSMutableArray *pinInfoArray;
@property __block int currentCount;
@property int totalCount;

@end

@implementation CentralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // View Init
    self.title = @"BLE Central";
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectedType = 1;
    
    // Get the watch
    uuid_t myAppUUIDbytes;
    NSUUID *myAppUUID = [[NSUUID alloc] initWithUUIDString:@"25becbb7-c0bc-4180-82b6-b36f1bf894c7"];
    [myAppUUID getUUIDBytes:myAppUUIDbytes];
    [[PBPebbleCentral defaultCentral] setAppUUID:[NSData dataWithBytes:myAppUUIDbytes length:16]];
    [[PBPebbleCentral defaultCentral] setDelegate:self];
    // Get watch reference
    self.watch = [[PBPebbleCentral defaultCentral] lastConnectedWatch];
    
    // Selection setup
    self.btn_selection1 = [self setupButton:self.btn_selection1 withImageName:@"icon01"];
    
    self.btn_selection2 = [self setupButton:self.btn_selection1 withImageName:@"icon02_large"];

    self.btn_selection3 = [self setupButton:self.btn_selection1 withImageName:@"icon03_large"];

    self.btn_selection4 = [self setupButton:self.btn_selection1 withImageName:@"icon04_large"];
    
    self.btn_selected = [FUIButton ButtonWithTitle:@"" inBold:YES];
    [self.btn_selected setBackgroundImage:[UIImage imageNamed:@"icon01"] forState:UIControlStateNormal];
    [self.btn_selected setBackgroundImage:[UIImage imageNamed:@"icon01"] forState:UIControlStateHighlighted];
    [self.view addSubview:self.btn_selected];
    
    // Button setup
    self.btn_Push = [FUIButton ButtonWithTitle:@"Push" inBold:YES];
    [self.view addSubview:self.btn_Push];
    
    // Register Button
    [[self.btn_Push rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"Push button pressed");
        [self pullTimelinePins];
    }];
    
    self.label_Status = [UILabel LabelSubTitleWithString:@"Status: Ready to push" align:NSTextAlignmentCenter];
    self.label_Status.numberOfLines = 0;
    [self.view addSubview:self.label_Status];

    [self updateViewConstraints];
}

- (FUIButton *)setupButton:(FUIButton *)button withImageName:(NSString *)name {
    button = [FUIButton ButtonWithTitle:@"" inBold:YES];
    [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateHighlighted];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self animatePressWithButton:button];
        self.selectedType = 1;
    }];
    [self.view addSubview:button];
    return button;
}

- (void) animatePressWithButton:(FUIButton *)button {
    // Compress
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.springSpeed = 200;
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.8, 0.8)];
    scaleAnimation.springBounciness = 25.f;
    [button.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
    // Expand
    POPSpringAnimation *scaleAnimation2 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation2.beginTime = CACurrentMediaTime()+0.1;
    scaleAnimation2.springSpeed = 100;
    scaleAnimation2.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    scaleAnimation2.springBounciness = 24.5f;
    [button.layer pop_addAnimation:scaleAnimation2 forKey:@"scaleAnim2"];
}

#define IconSize        CGSizeMake(80, 80)
#define CenterOffset    70

- (void)updateViewConstraints {
    if(!self.didSetupConstraints) {
        // Selections
        [self.btn_selection1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(4.5*mas_Padding_Page_Large.top);
            make.centerX.equalTo(self.view.mas_centerX).with.offset(-CenterOffset);
            make.size.mas_equalTo(IconSize);
        }];
        [self.btn_selection2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(4.5*mas_Padding_Page_Large.top);
            make.centerX.equalTo(self.view.mas_centerX).with.offset(CenterOffset);
            make.size.mas_equalTo(IconSize);
        }];
        [self.btn_selection3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btn_selection1.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.centerX.equalTo(self.view.mas_centerX).with.offset(-CenterOffset);
            make.size.mas_equalTo(IconSize);
        }];
        [self.btn_selection4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btn_selection2.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.centerX.equalTo(self.view.mas_centerX).with.offset(CenterOffset);
            make.size.mas_equalTo(IconSize);
        }];
        [self.btn_selected mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btn_selection3.mas_bottom).with.offset(5*mas_Padding_Page_Default.top);
            make.centerX.equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(IconSize);
        }];
        
        // Command button
        [self.btn_Push mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-ScreenHeight/5);
            make.size.mas_equalTo(CGSizeMake(250, 60));
        }];
        [self.label_Status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.btn_Push.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.size.mas_equalTo(CGSizeMake(250, 60));
        }];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
    
}

- (void)pullTimelinePins {
    NSLog(@"Pulling pins info");
    [self.label_Status setText:@"Status: Pulling timeline pin info"];
    
    // Reset all pin info
    self.pinInfoArray = [[NSMutableArray alloc] init];
    
    // Fake data
    [self fakeData];
    
    self.currentCount = 0;
    self.totalCount = (int)[self.pinInfoArray count];
    
    // Push updates
    [self.label_Status setText:@"Status: Pushing timeline pin info"];
    NSLog(@"Pushing updates...");
    [self pushUpdates];
}

#define Code_Reset      0
#define Code_IconType   1
#define Code_Hour       101
#define Code_Minute     102
#define Code_End        999

- (void)fakeData {
    //    for (int i = 0; i < 5; i++) {
    //        NSMutableDictionary *item = [[NSMutableDictionary]]
    //    }
    
    NSMutableDictionary *item00 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @(0), @(Code_Reset),
                                   @(self.selectedType), @(Code_IconType),
                                   nil];
    [self.pinInfoArray addObject:item00];
    
    NSMutableDictionary *item01 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @(10), @(Code_Hour),
                                   @(15), @(Code_Minute),
                                   nil];
    [self.pinInfoArray addObject:item01];
    
    NSMutableDictionary *item02 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @(5), @(Code_Hour),
                                   @(40), @(Code_Minute),
                                   nil];
    [self.pinInfoArray addObject:item02];
    
    NSMutableDictionary *item999 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                    @(999), @(Code_End),
                                    nil];
    [self.pinInfoArray addObject:item999];
    
}

- (void)pushUpdates {
    if(self.watch) {
        // Send message to Pebble player
        [self.watch appMessagesPushUpdate:self.pinInfoArray[self.currentCount] onSent:^(PBWatch *watch, NSDictionary *update, NSError *error) {
            // Successful?
            if(error) {
                NSLog(@"Error sending update: %@", error);
            } else {
                NSLog(@"Update push secceeded!");
                self.currentCount++;
                if (self.currentCount < self.totalCount) {
                    NSLog(@"Needs to push more update!");
                    [self pushUpdates];
                } else {
                    [self.label_Status setText:@"Status: Finish pushing"];
                }
            }
        }];
        
    } else {
        // Watch not connected!
        [self.labelStatus setText:@"Status: Watch NOT connected!"];
    }
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
