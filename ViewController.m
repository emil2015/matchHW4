//
//  ViewController.m
//  Drawing
//
//  Created by Sameh Fakhouri on 10/29/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "ViewController.h"
#import "SetCardView.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SetCardView *singleSolidGreen;
@property (weak, nonatomic) IBOutlet SetCardView *singleOutlinedPurple;
@property (weak, nonatomic) IBOutlet SetCardView *tripleStrippedRed;
@property (weak, nonatomic) IBOutlet SetCardView *dsdd;

//@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) IBOutletCollection(SetCardView) NSMutableArray *setCardViews;

@end

@implementation ViewController

- (IBAction)add3:(id)sender {
    for (SetCardView *setViews in self.setCardViews){
        if (setViews.hidden){
            setViews.hidden = NO;
        }
    }
    [self updateUI];
}

@synthesize game = _game;
-(CardMatchingGame *)game{
    if (!_game) { NSLog(@"Game nil");
        _game = [[CardMatchingGame alloc] initWithCardCount:81//[self.setCardViews count]
                                                 usingDeck:[self createDeck]];
    }
    return _game;
}




- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

+ (NSArray *)validShades
{
    return @[@"Solid", @"Striped", @"Outlined"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (SetCardView *meh in self.setCardViews){
        [meh addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:meh action:@selector(tap)]];
    }
    
    
}

/*
- (void)tap:(UITapGestureRecognizer *)sender{
    NSLog(@"Tap that ass");
    for (SetCardView *meh in self.setCardViews){
    NSLog(@"Tapped was tapped %d in setCardView", meh.tag);
    }
    
    //
    NSUInteger cardIndex = [self.setCardViews indexOfObject:sender];
    NSLog(@"MatchCardViewController - touchCardButton - Card with index %ld has been pressed", (long) cardIndex);
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    
    
}
 */

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // this is a 3 card matching game
    [self.game matchThreeCards];
    
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchDealButton:(id)sender
{
    [super touchDealButton:sender];
    
    // this is a 3 card matching game
    [self.game matchThreeCards];
}

/*
//TODO This is calling the deal button, I need it to call the updateUI method? This has been linked to the actual card views.
- (IBAction)tap:(UITapGestureRecognizer *)sender
{
    //[super touchDealButton:sender];
    
    // this is a 3 card matching game
    //[self.game matchThreeCards];
    
    NSUInteger cardIndex = sender.view.tag; //[self.setCardViews indexOfObject:sender.view.tag];
    // Supposed to find th card in teh view that will give me the proper index for the card bit it's alwys 6....
    for (SetCardView *meh in self.setCardViews){
        if (meh == sender.view){
            cardIndex = meh.cardIndexForView;
        }
    }
    
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    NSLog(@"View TOuched");
    
}
*/

- (void)hereIsTheCard:(NSInteger)para{
    NSLog(@"Here's the card");
    
    NSUInteger cardIndex = para; //sender.view.tag; //[self.setCardViews indexOfObject:sender.view.tag];
    // Supposed to find th card in teh view that will give me the proper index for the card bit it's alwys 6....
    
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    NSLog(@"View TOuched");
    [self updateUI];
}




- (void)updateUI
{
    //TODO: CARD ARE NIL. NEED TO SEE WHY THAT IS. CHECK THE POSSIBLITY OF IT BEING BECAUSE OF NON INSTANTIATING SOMETHING OR ANOTHER....
    for (SetCardView *setViews in self.setCardViews){
        NSUInteger cardIndex = [self.setCardViews indexOfObject:setViews];

    /*
    NSMutableArray *tempView = [self.setCardViews copy];
        for (SetCardView *setViews in tempView){
            NSUInteger cardIndex = [tempView indexOfObject:setViews];
      */
        Card *card = [self.game cardAtIndex:cardIndex];
        SetCard *setCard = (SetCard *)card;
        
        setViews.color = [setCard color];
        setViews.count = [setCard count];
        setViews.symbol = [setCard symbol];
        //"▲", @"◼︎", @"●"
        
        if ([setCard shade] == 1) {
            setViews.shade = @"Solid";
        }else
            if ([setCard shade] > 0 && [setCard shade] < 1){
            setViews.shade = @"Striped";
        }else
            if ([setCard shade] == 0){
            setViews.shade = @"Outlined";
        }
        
        setViews.cardIndexForView = cardIndex;
        setViews.tag = cardIndex;
        setViews.isChosen = card.isChosen;
        setViews.myViewController = self;
        
        //Sets background color for being chosen
        if (setViews.isChosen){
        setViews.backgroundColor = [UIColor blueColor];
            
        } else if (!setViews.isChosen){
            //setViews.backgroundColor = [UIColor whiteColor];
            setViews.backgroundColor = [UIColor whiteColor];
        }
        
        //Disables if matched
        if (card.isMatched){
            setViews.Hidden = YES;
            //[setViews removeMe];
            //[self.setCardViews removeObjectAtIndex:cardIndex];
            //[self.setCardViews removeObject:setViews];
            //[tempView removeObject:setViews];
            [self.game removeCardAtIndex:cardIndex];
        } else if(!card.isMatched){
            //put card back?
            setViews.hidden = NO;
        }
        
        
    }
    
    //self.setCardViews = [tempView copy];
    

    
    
    
    
    //"Solid", @"Striped", @"Outlined"
    /*
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
*/
     }

@end
