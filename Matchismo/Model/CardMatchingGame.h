//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Sameh Fakhouri on 3/28/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// this is the designated initiazer for this class
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (void)resetScore;

- (void)matchTwoCards;
- (void)matchThreeCards;

- (NSAttributedString *)feedback;
- (NSAttributedString *)getGameHistory;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSInteger numberOfCardsToMatch;

@end
