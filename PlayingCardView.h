//
//  PlayingCardView.h
//  SuperCard
//
//  Created by sameh on 10/15/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCViewController.h"

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (nonatomic, strong) NSString *suit;
@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

- (void)tap;

@property PCViewController *myViewController;

@end
