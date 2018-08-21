//
//  math.h
//  HeartBeatz
//  math
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Math : NSObject

+ (NSString *)stringifyDistance:(float)meters;

+ (NSString *)stringifySecondCount:(int)seconds usingLongFormat:(BOOL)longFormat;

+ (NSString *)stringifyAvgPaceFromDist:(float)meters overTime:(int)seconds;

+ (NSString *)stringifyStrideRateFromSteps:(int)steps overTime:(int)seconds;

@end
