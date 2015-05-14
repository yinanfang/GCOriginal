//
//  FirstViewController.m
//  GCOriginal
//
//  Created by Lucas Fang on 5/13/15.
//  Copyright (c) 2015 Lucas Fang. All rights reserved.
//

#import "FirstViewController.h"
#import "PebbleKit/PebbleKit.h"

@interface FirstViewController () <PBPebbleCentralDelegate>

@property PBWatch *watch;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"app started!!");
    [self.labelStatus setText:@"Ready to go!"];
    
    uuid_t myAppUUIDbytes;
    NSUUID *myAppUUID = [[NSUUID alloc] initWithUUIDString:@"25becbb7-c0bc-4180-82b6-b36f1bf894c7"];
    [myAppUUID getUUIDBytes:myAppUUIDbytes];
    [[PBPebbleCentral defaultCentral] setAppUUID:[NSData dataWithBytes:myAppUUIDbytes length:16]];
    [[PBPebbleCentral defaultCentral] setDelegate:self];
    // Get watch reference
    self.watch = [[PBPebbleCentral defaultCentral] lastConnectedWatch];
    
    // pull data from timeline
    
    
    
    
}

- (IBAction)pressStart:(UIButton *)sender {
    NSLog(@"pressed start...");
    
    [self pullTimelinePins];
    
    
    
    
}

- (void)pullTimelinePins {
    NSLog(@"Pulling pins info");
}

- (void)pushUpdates {
//    if(self.watch) {
//        // Watch connected!
//        [self.labelStatus setText:@"Pushing updates..."];
//        
//        // Register for AppMessage delivery
//        [self.watch appMessagesAddReceiveUpdateHandler:^BOOL(PBWatch *watch, NSDictionary *update) {
//            // A new message has been received in 'update'
//            if([update objectForKey:@(KEY_CHOICE)]) {
//                // The KEY_CHOICE key is in the message!
//                remoteChoice = [[update objectForKey:@(KEY_CHOICE)] intValue];
//                
//                // Has the iOS player chosen already?
//                if(localChoice != CHOICE_WAITING) {
//                    [self doMatch];
//                }
//            }
//        
//            return YES;
//        }];
//    } else {
//        // Watch not connected!
//        [self.labelStatus setText:@"Watch NOT connected!"];
//    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
