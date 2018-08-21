//
//  NDIntroPageView.m
//  NDParallaxIntroView
//
//  Created by Simon Wicha on 17/04/2016.
//  Copyright © 2016 Simon Wicha. All rights reserved.
//

#import "NDIntroView.h"
#import "NDIntroPageView.h"
#import "UIDeviceHardware.h"

@interface NDIntroView () <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIScrollView *parallaxBackgroundScrollView;

@property (strong, nonatomic) NSMutableArray<UIView *> *pageViews;
@property (strong, nonatomic) NSArray <NSDictionary*> *onboardContentArray;

@end

@implementation NDIntroView

- (id)initWithFrame:(CGRect)frame parallaxImage:(UIImage *)parallaxImage andData:(NSArray *)data {
    self = [super initWithFrame:frame];
    if(self) {
        self.onboardContentArray = data;
        NSString *platformString = [UIDeviceHardware platformString];
        
        if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
        {
            NSLog(@"testediphone7");
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-50, 0, self.scrollView.frame.size.width * self.onboardContentArray.count, self.frame.size.height)];
            [imageView setImage:parallaxImage];
            imageView.contentMode = UIViewContentModeLeft;
            [self.parallaxBackgroundScrollView addSubview:imageView];
        }
        else if ([platformString isEqualToString:@"iPhone X"])
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-179, 0, self.scrollView.frame.size.width * self.onboardContentArray.count, self.frame.size.height)];
            [imageView setImage:parallaxImage];
            
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.parallaxBackgroundScrollView addSubview:imageView];
        }
        else
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-50, 0, self.scrollView.frame.size.width * self.onboardContentArray.count, self.frame.size.height)];
            [imageView setImage:parallaxImage];
            imageView.contentMode = UIViewContentModeLeft;
            [self.parallaxBackgroundScrollView addSubview:imageView];
        }
        
        [self addSubview:self.parallaxBackgroundScrollView];
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        
        [self generateIntroPageViews];
    }
    return self;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
    CGFloat backgroundScrollValue = 0.5f;//self.backgroundImage.size.width/self.onboardContentArray.count/self.frame.size.width;
    [self.parallaxBackgroundScrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x  * backgroundScrollValue, self.scrollView.contentOffset.y) animated:NO];
}

- (void)generateIntroPageViews {
    
    NSString *platformString = [UIDeviceHardware platformString];
    
    if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
    {
        [self.onboardContentArray enumerateObjectsUsingBlock:^(NSDictionary *pageDict, NSUInteger idx, BOOL *stop) {
            
            
            NDIntroPageView *pageView = [[[NSBundle mainBundle] loadNibNamed:@"NDIntroPageView" owner:nil options:nil] lastObject];
            pageView.frame = CGRectMake(self.frame.size.width * idx, 0, self.frame.size.width, self.frame.size.height);
            pageView.titlelabel.text = (pageDict[kNDIntroPageTitle]) ? pageDict[kNDIntroPageTitle] : @"nil";
            pageView.descriptionLabel.text = (pageDict[kNDIntroPageDescription]) ? pageDict[kNDIntroPageDescription] : @"";
            pageView.imageView.image = [[UIImage imageNamed:(pageDict[kNDIntroPageImageName]) ? pageDict[kNDIntroPageImageName] : @""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            pageView.imageHorizontalConstraint.constant = ([pageDict[kNDIntroPageImageHorizontalConstraintValue] floatValue]) ? [pageDict[kNDIntroPageImageHorizontalConstraintValue] floatValue] : -130.f;
            pageView.titleLabelHeightConstraint.constant = ([pageDict[kNDIntroPageTitleLabelHeightConstraintValue] floatValue]) ? [pageDict[kNDIntroPageTitleLabelHeightConstraintValue] floatValue] : 80.f;
            if (self.onboardContentArray.count - 1 == idx) [pageView addSubview:self.lastPageButton];
            [self.scrollView addSubview:pageView];
        }];
    }
    else if ([platformString isEqualToString:@"iPhone X"])
    {
        [self.onboardContentArray enumerateObjectsUsingBlock:^(NSDictionary *pageDict, NSUInteger idx, BOOL *stop) {
            
            
            NDIntroPageView *pageView = [[[NSBundle mainBundle] loadNibNamed:@"NDIntroPageViewiphonex" owner:nil options:nil] lastObject];
            pageView.frame = CGRectMake(self.frame.size.width * idx, 0, self.frame.size.width, self.frame.size.height);
            pageView.titlelabel.text = (pageDict[kNDIntroPageTitle]) ? pageDict[kNDIntroPageTitle] : @"nil";
            pageView.descriptionLabel.text = (pageDict[kNDIntroPageDescription]) ? pageDict[kNDIntroPageDescription] : @"";
            pageView.imageView.image = [[UIImage imageNamed:(pageDict[kNDIntroPageImageName]) ? pageDict[kNDIntroPageImageName] : @""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            pageView.imageHorizontalConstraint.constant = ([pageDict[kNDIntroPageImageHorizontalConstraintValue] floatValue]) ? [pageDict[kNDIntroPageImageHorizontalConstraintValue] floatValue] : -130.f;
            pageView.titleLabelHeightConstraint.constant = ([pageDict[kNDIntroPageTitleLabelHeightConstraintValue] floatValue]) ? [pageDict[kNDIntroPageTitleLabelHeightConstraintValue] floatValue] : 80.f;
            if (self.onboardContentArray.count - 1 == idx) [pageView addSubview:self.lastPageButton];
            [self.scrollView addSubview:pageView];
        }];
    }
    else
    {
        [self.onboardContentArray enumerateObjectsUsingBlock:^(NSDictionary *pageDict, NSUInteger idx, BOOL *stop) {
            
            
            NDIntroPageView *pageView = [[[NSBundle mainBundle] loadNibNamed:@"NDIntroPageView" owner:nil options:nil] lastObject];
            pageView.frame = CGRectMake(self.frame.size.width * idx, 0, self.frame.size.width, self.frame.size.height);
            pageView.titlelabel.text = (pageDict[kNDIntroPageTitle]) ? pageDict[kNDIntroPageTitle] : @"nil";
            pageView.descriptionLabel.text = (pageDict[kNDIntroPageDescription]) ? pageDict[kNDIntroPageDescription] : @"";
            pageView.imageView.image = [[UIImage imageNamed:(pageDict[kNDIntroPageImageName]) ? pageDict[kNDIntroPageImageName] : @""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            pageView.imageHorizontalConstraint.constant = ([pageDict[kNDIntroPageImageHorizontalConstraintValue] floatValue]) ? [pageDict[kNDIntroPageImageHorizontalConstraintValue] floatValue] : -130.f;
            pageView.titleLabelHeightConstraint.constant = ([pageDict[kNDIntroPageTitleLabelHeightConstraintValue] floatValue]) ? [pageDict[kNDIntroPageTitleLabelHeightConstraintValue] floatValue] : 80.f;
            if (self.onboardContentArray.count - 1 == idx) [pageView addSubview:self.lastPageButton];
            [self.scrollView addSubview:pageView];
        }];
    }
   
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * self.onboardContentArray.count, self.scrollView.frame.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return _scrollView;
}

-(UIScrollView *)parallaxBackgroundScrollView {
    if (!_parallaxBackgroundScrollView) {
        _parallaxBackgroundScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _parallaxBackgroundScrollView.delegate = self;
        _parallaxBackgroundScrollView.pagingEnabled = YES;
        _parallaxBackgroundScrollView.userInteractionEnabled = NO;
        _parallaxBackgroundScrollView.contentSize = CGSizeMake(self.frame.size.width*4, self.scrollView.frame.size.height);
        _parallaxBackgroundScrollView.showsHorizontalScrollIndicator = NO;
        [_parallaxBackgroundScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return _parallaxBackgroundScrollView;
}

-(UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-80, self.frame.size.width, 10)];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.numberOfPages = self.onboardContentArray.count;
    }
    return _pageControl;
}




@end
