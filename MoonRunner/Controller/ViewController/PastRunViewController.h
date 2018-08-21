//
//  PastRunViewController.h
//  HeartBeatz
//  PastRunViewController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RunDetailsViewController.h"
#import "Run.h"
#import "InfoTableViewCell.h"
#import "MathController.h"
#import "SettingViewController.h"

@interface PastRunViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *runArray;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
