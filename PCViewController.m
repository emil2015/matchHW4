//
//  PCViewController.m
//  Matchismo
//
//  Created by David Gross on 11/17/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//
#import "PlayingCardView.h"
#import "PCViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PCViewController ()
@property (strong, nonatomic) IBOutletCollection(PlayingCardView) NSArray *playingCardViews;

@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation PCViewController

-(CardMatchingGame *)game{
    if (!_game) { NSLog(@"Game nil");
        _game = [[CardMatchingGame alloc] initWithCardCount:81//[self.setCardViews count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (PlayingCardView *meh in self.playingCardViews){
        [meh addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:meh action:@selector(pinch:)]];
        //[self.gridView addSubview:meh];
        
    }
}

- (void)hereIsTheCard:(NSInteger)para{
    NSLog(@"Here's the card");
    
    NSUInteger cardIndex = para; //sender.view.tag; //[self.setCardViews indexOfObject:sender.view.tag];
    // Supposed to find th card in teh view that will give me the proper index for the card bit it's alwys 6....
    
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    NSLog(@"View TOuched");
    //[self updateUI];
}

- (void)updateUI
{
    NSLog(@"PlayingCardViewController - UpdateUI - Start");
    for (PlayingCardView *cardButton in self.playingCardViews) {
        NSUInteger cardIndex = [self.playingCardViews indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        
        //[cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        cardButton.backgroundColor = [UIColor colorWithPatternImage:[self imageForCard:card]];
        //[cardButton setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
        //cardButton.enabled = !card.matched;
    } // end for cardButton
    //self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long) self.game.score];
    //    self.feedbackLabel.text = [NSString stringWithFormat:@"%@", [self.game feedback]];
    //[self.feedbackLabel setAttributedText:[self.game feedback]];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
