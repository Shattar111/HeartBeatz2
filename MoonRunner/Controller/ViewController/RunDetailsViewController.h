//
//  RunDetailsViewController.h
//  HeartBeatz
//  RunDetailsViewController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "Run.h"
#import "MathController.h"
#import "Location.h"
#import "MulticolorPolylineSegment.h"
#import "SummaryTableViewCell.h"
#import "AnalysisViewController.h"
#import "SettingViewController.h"

#import "ButtonTableCell.h"
#import "InfoTableViewCell.h"
#import "BasicTableViewCell.h"
#import "RunHelper.h"
#import "WeatherTableViewCell.h"
#import "NewRunViewController.h"

@class Run;

@interface RunDetailsViewController : UIViewController <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *masterArray;
    NSArray *array;
    NSArray *name;
    NSArray *valueA;
}
@property BOOL saveNewRun;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Run *run;
@property (strong, nonatomic) NSArray *colorSegmentArray;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UITableView *table;
@property (nonatomic, weak) IBOutlet UIButton *backButton;

@end
