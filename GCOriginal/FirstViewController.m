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

@property __block BOOL isFree;
@property __block int currentCount;
@property int totalCount;

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
    
    self.isFree = YES;
    self.currentCount = 0;
    self.totalCount = (int)[self.pinInfoArray count];
    
    // Push updates
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
                                   @(0), @(Code_IconType),
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
        NSLog(@"Pushing updates...");
        [self.labelStatus setText:@"Pushing updates..."];
        
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
                }
            }
        }];
    
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
