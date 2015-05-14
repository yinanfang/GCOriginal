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
@property NSMutableArray *pinInfoArray;

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
   
    
    
    
}

- (IBAction)pressStart:(UIButton *)sender {
    NSLog(@"pressed start...");
    
    [self pullTimelinePins];
    
}

- (void)pullTimelinePins {
    NSLog(@"Pulling pins info");
    
    // Reset all pin info
    self.pinInfoArray = [[NSMutableArray alloc] init];
    
    // Fake data
    [self fakeData];
    
    // Push updates
    [self pushUpdates];
}

#define Code_Hour       101
#define Code_Minute     102

- (void)fakeData {
//    for (int i = 0; i < 5; i++) {
//        NSMutableDictionary *item = [[NSMutableDictionary]]
//    }
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
    
}

- (void)pushUpdates {
    if(self.watch) {
        // Watch connected!
        [self.labelStatus setText:@"Pushing updates..."];
        
        // Send message to Pebble player
        for (int i = 0; i < [self.pinInfoArray count]; i++) {
            [self.watch appMessagesPushUpdate:self.pinInfoArray[i] onSent:^(PBWatch *watch, NSDictionary *update, NSError *error) {
                // Successful?
                if(error) {
                    NSLog(@"Error sending update: %@", error);
                } else {
                    NSLog(@"Update push secceeded!");

                }
            }];
        }
        
    
    
    
    } else {
        // Watch not connected!
        [self.labelStatus setText:@"Watch NOT connected!"];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
