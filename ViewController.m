//
//  ViewController.m
//  Drawing
//
//  Created by Sameh Fakhouri on 10/29/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "ViewController.h"
#import "SetCardView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SetCardView *singleSolidGreen;
@property (weak, nonatomic) IBOutlet SetCardView *singleOutlinedPurple;
@property (weak, nonatomic) IBOutlet SetCardView *tripleStrippedRed;
@property (weak, nonatomic) IBOutlet SetCardView *dsdd;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    SetCardView *setCard = (SetCardView *) self.singleSolidGreen;
    setCard.symbol = @"Diamond";
    setCard.color = [UIColor greenColor];
    setCard.shade = @"Solid";
    setCard.count = 1;
    
    setCard = (SetCardView *) self.singleOutlinedPurple;
    setCard.symbol = @"Squiggle";
    setCard.color = [UIColor purpleColor];
    setCard.shade = @"outlined";
    setCard.count = 1;
    
    setCard = (SetCardView *) self.tripleStrippedRed;
    setCard.symbol = @"Oval";
    setCard.color = [UIColor redColor];
    setCard.shade = @"Striped";
    setCard.count = 3;
    
    setCard = (SetCardView *) self.dsdd;
    setCard.symbol = @"Diamond";
    setCard.color = [UIColor blueColor];
    setCard.shade = @"Striped";
    setCard.count = 2;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
