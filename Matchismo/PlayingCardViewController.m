//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Sameh Fakhouri on 10/1/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "HistoryViewController.h"

@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController



- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}



- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"PlayingCardViewController - ViewWillAppear - Start");
    [super viewWillAppear:animated];
    
    // this is a 2 card matching game
    [self.game matchTwoCards];
    
    [self updateUI];
    NSLog(@"PlayingCardViewController - ViewWillAppear - End");
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"PlayingCardViewController - prepareToSegue - Start");
    if ([segue.identifier isEqualToString:@"Playing Card History"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *hvc = (HistoryViewController *) segue.destinationViewController;
            hvc.gameHistory = [self.game getGameHistory];
        }
    }
    NSLog(@"PlayingCardViewController - prepareToSegue - End");
}



- (IBAction)touchDealButton:(id)sender
{
    [super touchDealButton:sender];
    
    // this is a 2 card matching game
    [self.game matchTwoCards];
}



- (void)updateUI
{
    NSLog(@"PlayingCardViewController - UpdateUI - Start");
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
    } // end for cardButton
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long) self.game.score];
//    self.feedbackLabel.text = [NSString stringWithFormat:@"%@", [self.game feedback]];
    [self.feedbackLabel setAttributedText:[self.game feedback]];
    NSLog(@"PlayingCardViewController - UpdateUI - End");
}



- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}



- (UIImage *)imageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

@end
