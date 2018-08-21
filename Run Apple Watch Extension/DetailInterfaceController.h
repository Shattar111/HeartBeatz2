//
//  DetailInterfaceController.h
//  HeartBeatz
//  DetailInterfaceController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import "Math.h"
#import "InterfaceController.h"

@interface DetailInterfaceController : WKInterfaceController <WCSessionDelegate>{
    NSDictionary *localData;
    NSDictionary *data; 
}

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *Distance;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *Time;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *Pace;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *Heartrate;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *milisecondsLabel;
- (IBAction)save;

@end
