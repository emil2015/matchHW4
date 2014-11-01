//
//  MatchCardsViewController.m
//  Matchismo
//
//  Created by sameh on 3/26/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "MatchCardsViewController.h"


@interface MatchCardsViewController ()
@end

@implementation MatchCardsViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}


- (Deck *)createDeck
{
    // abstract method
    return nil;
}

//
// Touching the "Deal" button resets the game
//
- (IBAction)touchDealButton:(id)sender {
    NSLog(@"MatchCardViewController - touchDealButton - Deal button has been pressed");
    self.game = nil;
    [self.game resetScore];
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    NSLog(@"MatchCardViewController - touchCardButton - Card with index %ld has been pressed", (long) cardIndex);
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}


- (void)updateUI
{
    // abstract method
}

@end
