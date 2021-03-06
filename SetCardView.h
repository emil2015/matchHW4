//
//  SetCardView.h
//  Drawing
//
//  Created by Sameh Fakhouri on 10/29/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface SetCardView : UIView

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic)         NSUInteger count;
@property (nonatomic, strong) NSString *shade;

+ (NSArray *)validSymbols;
+ (NSArray *)validShades;
+ (NSArray *)validColors;
+ (NSUInteger)maxCount;

@property NSUInteger cardIndexForView;

@property BOOL isChosen;
@property BOOL isMatched;

- (void)tap;

- (void)removeMe;

@property ViewController *myViewController;

//- (void)IsHidden:(BOOL)isHidden;

@end
