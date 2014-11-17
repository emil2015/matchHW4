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
#import "Grid.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SetCardView *singleSolidGreen;
@property (weak, nonatomic) IBOutlet SetCardView *singleOutlinedPurple;
@property (weak, nonatomic) IBOutlet SetCardView *tripleStrippedRed;
@property (weak, nonatomic) IBOutlet SetCardView *dsdd;
@property (strong, nonatomic) IBOutlet UIView *gridView;

//@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) CardMatchingGame *game;

//@property (strong, nonatomic) IBOutletCollection(SetCardView) NSMutableArray *setCardViews;

@property (strong, nonatomic) NSMutableArray *setCardViews;

@end

@implementation ViewController

- (NSMutableArray *)setCardViews{
    if (!_setCardViews){
        _setCardViews = [[NSMutableArray alloc] initWithCapacity:100];
    }
    return _setCardViews;
}

- (IBAction)add3:(id)sender {
    for (SetCardView *setViews in self.setCardViews){
        //if (setViews.hidden){
            setViews.hidden = NO;
        //}
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
    
    //Grid stuff
    Grid *griddy = [[Grid alloc] init];
    //griddy.size = [self.mainView bounds].size;
    griddy.size = [self.gridView bounds].size;//CGSizeMake(150, 150);
    griddy.cellAspectRatio = 1;
    griddy.minimumNumberOfCells = 12;
    
    griddy.minCellWidth = 4;
    griddy.minCellHeight = 4;
    griddy.maxCellHeight = 60;
    griddy.maxCellWidth = 60;
    
    //UIView *theView = [[UIView alloc] initWithFrame:[griddy frameOfCellAtRow:5 inColumn:5]];
    
    for (int x = 0; x < 3; x++){
        for (int y = 0; y < 4; y++){
            
            [self.setCardViews addObject:[[SetCardView alloc] initWithFrame:[griddy frameOfCellAtRow:x inColumn:y]]];
        }
    }
    
    /*
    for (int x = 0; x < 12; x++){
        [self.setCardViews addObject:[[SetCardView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)]];
    }
    */
    for (SetCardView *meh in self.setCardViews){
        [meh addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:meh action:@selector(tap)]];
    }
    
    //[self.gridView addSubview:self.setCardViews.firstObject];
    
    for (SetCardView *meh in self.setCardViews){
        [self.gridView addSubview:meh];
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
    //TODO: CARD ARE NIL. NEED TO SEE WHY THAT IS. CHECK THE POSSIBLITY OF IT BEING BECAUSE OF NOT INSTANTIATING SOMETHING OR ANOTHER....
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
        

        
        
    }
    //TODO Need to make it so the cards are removed and stuff properly. At the moment the view once they are hidden do not become unhidden. 
    NSMutableArray *cardsToBeRemoved = [[NSMutableArray alloc] initWithCapacity:4];
    
    for (SetCardView *setViews in self.setCardViews){
        NSUInteger cardIndex = [self.setCardViews indexOfObject:setViews];
        Card *card = [self.game cardAtIndex:cardIndex];
        setViews.hidden = card.isMatched;
        
        if(card.isMatched){
            [cardsToBeRemoved addObject:card];
        }
        
        /*
    //Disables if matched
    if (card.isMatched){
        setViews.Hidden = YES;
        //[setViews removeMe];
        //[self.setCardViews removeObjectAtIndex:cardIndex];
        //[self.setCardViews removeObject:setViews];
        //[tempView removeObject:setViews];
        //[self.game removeCardAtIndex:cardIndex];
        [cardsToBeRemoved addObject:card];
    } else if(!card.isMatched){
        //put card back?
        //setViews.hidden = NO;
    }
        */
        
    }
    
    [self.game removeCardsObject:cardsToBeRemoved];
    

     }


@end
