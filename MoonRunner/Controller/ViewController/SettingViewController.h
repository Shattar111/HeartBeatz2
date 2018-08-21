//
//  SettingViewController.h
//  HeartBeatz
//  SettingViewController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import <MessageUI/MessageUI.h>

BOOL areAdsRemoved;
BOOL useMetric;
BOOL useAnalysis;

@interface SettingViewController : UIViewController <SKProductsRequestDelegate, SKPaymentTransactionObserver, MFMailComposeViewControllerDelegate>{
    
    IBOutlet UISwitch *ads;
    IBOutlet UISwitch *metric;
    IBOutlet UISwitch *analysis;
}

- (IBAction)restore;
- (IBAction)tapsRemoveAds;

@end
