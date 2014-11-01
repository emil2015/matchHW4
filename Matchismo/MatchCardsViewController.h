//
//  MatchCardsViewController.h
//  Matchismo
//
//  Created by sameh on 3/26/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//
// Abstract class. Subclasses must implement abstract methods
// listed below.

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "Deck.h"

@interface MatchCardsViewController : UIViewController

@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;

// these are protected methods
// for subclasses only
- (Deck *)createDeck;   // abstract
- (void)updateUI;       // abstract

- (IBAction)touchDealButton:(id)sender;

@end
