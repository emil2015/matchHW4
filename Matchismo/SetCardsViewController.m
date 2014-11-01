//
//  SetCardsViewController.m
//  Matchismo
//
//  Created by Sameh Fakhouri on 9/26/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "SetCardsViewController.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "HistoryViewController.h"

@interface SetCardsViewController ()
@end


@implementation SetCardsViewController



- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // this is a 3 card matching game
    [self.game matchThreeCards];
    
    [self updateUI];
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"SetCardViewController - prepareToSegue - Start");
    if ([segue.identifier isEqualToString:@"Set Card History"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
            hvc.gameHistory = [self.game getGameHistory];
        }
    }
    NSLog(@"SetCardViewController - prepareToSegue - End");
}



- (IBAction)touchDealButton:(id)sender
{
    [super touchDealButton:sender];
    
    // this is a 3 card matching game
    [self.game matchThreeCards];
}



- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *)card;
            NSString *titleString = setCard.contents;
            
            NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:titleString];
            
            UIColor *foregroundColor = [setCard color];
            UIColor *strokeColor = [foregroundColor copy];
            foregroundColor = [foregroundColor colorWithAlphaComponent:setCard.shade];
            
            [title setAttributes:@{NSForegroundColorAttributeName:foregroundColor,
                                   NSStrokeWidthAttributeName:@-5,
                                   NSStrokeColorAttributeName:strokeColor}
                           range:NSMakeRange(0, [title length])];
            [cardButton setAttributedTitle:title forState:UIControlStateNormal];
            cardButton.enabled = !card.matched;
            if (setCard.isChosen && !setCard.isMatched) {
                [cardButton setBackgroundImage:[UIImage imageNamed:@"selectedCardFront"] forState:UIControlStateNormal];
            } else {
                [cardButton setBackgroundImage:[UIImage imageNamed:@"cardFront"] forState:UIControlStateNormal];
            }
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long) self.game.score];
//    self.feedbackLabel.text = [NSString stringWithFormat:@"%@", [self.game feedback]];
    [self.feedbackLabel setAttributedText:[self.game feedback]];
}

@end
