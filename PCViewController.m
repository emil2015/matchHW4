//
//  ViewController.m
//  Drawing
//
//  Created by Sameh Fakhouri on 10/29/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "PCViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"
#import "Grid.h"

@interface PCViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) IBOutlet UIView *gridView;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@property NSUInteger totalNumberOfCards;

//@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) CardMatchingGame *game;

//@property (strong, nonatomic) IBOutletCollection(PlayingCardView) NSMutableArray *PlayingCardViews;

@property (strong, nonatomic) NSMutableArray *PlayingCardViews;

@property int viewStopAmmount;

@end

@implementation PCViewController

- (IBAction)shuffle:(UIButton *)sender {
    [self doGridStuff];
    [self updateUI];
}

- (NSMutableArray *)PlayingCardViews{
    if (!_PlayingCardViews){
        _PlayingCardViews = [[NSMutableArray alloc] initWithCapacity:100];
    }
    return _PlayingCardViews;
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self doGridStuff];
    [self updateUI];
}

- (IBAction)add3:(id)sender {
    /*
     for (PlayingCardView *setViews in self.PlayingCardViews){
     //if (setViews.hidden){
     setViews.hidden = NO;
     //}
     }*/
    
    if (self.viewStopAmmount >= 0){
        NSLog(@"STAHP");
        self.totalNumberOfCards += 3;
        self.viewStopAmmount -= 3;
        //[self updateUI];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No More Cards" message:@"There are no more cards in the deck" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    [self doGridStuff];
    [self updateUI];
    
}

@synthesize game = _game;
-(CardMatchingGame *)game{
    if (!_game) { NSLog(@"Game nil");
        _game = [[CardMatchingGame alloc] initWithCardCount:52//[self.PlayingCardViews count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}




- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

+ (NSArray *)validShades
{
    return @[@"Solid", @"Striped", @"Outlined"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.totalNumberOfCards = 31;
    self.viewStopAmmount = 20;
    [self doGridStuff];
    [self updateUI];
    
}

- (void)doGridStuff{
    
    /*
     for (PlayingCardView *meh in self.PlayingCardViews){
     //add thing for if it's matched to animate the removal of it.
     
     if (meh.isMatched){
     [self animateRemovingDrops:[[NSArray alloc] initWithObjects:meh, nil]];
     }else {
     [meh removeFromSuperview];
     }
     
     }*/
    
    NSMutableArray *cardsToAnimate = [[NSMutableArray alloc] init];
    //NSMutableArray *cardsToRemove = [[NSMutableArray alloc] init];
    
    for (PlayingCardView *meh in self.PlayingCardViews){
        if (meh.isMatched){
            [cardsToAnimate addObject:meh];
        } else {
            //[cardsToRemove addObject:meh];
            [meh removeFromSuperview];
        }
    }
    
    [self animateRemovingDrops:cardsToAnimate];
    
    
    //[self animateRemovingDrops:self.PlayingCardViews];
    
    
    /*
     for (PlayingCardView *meh in self.PlayingCardViews){
     [meh removeFromSuperview];
     //[self animateRemovingDrops:[[NSArray alloc] initWithObjects:meh, nil]];
     }*/
    //[self animateRemovingDrops:self.PlayingCardViews];
    
    
    [self.PlayingCardViews removeAllObjects];
    
    //Grid stuff
    Grid *griddy = [[Grid alloc] init];
    //griddy.size = [self.mainView bounds].size;
    griddy.size = [self.gridView bounds].size;//CGSizeMake(150, 150);
    griddy.cellAspectRatio = .7;
    griddy.minimumNumberOfCells = self.totalNumberOfCards;
    
    griddy.minCellWidth = 4;
    griddy.minCellHeight = 6;
    //griddy.maxCellHeight = 70;
    //griddy.maxCellWidth = 50;
    
    //UIView *theView = [[UIView alloc] initWithFrame:[griddy frameOfCellAtRow:5 inColumn:5]];
    
    //if (self.totalNumberOfCards % 3 == 0){
    NSLog(@"%d", (int)self.totalNumberOfCards); //  12 21
    NSLog(@"%d", (int)griddy.columnCount); //       4  5
    NSLog(@"%d", (int)griddy.rowCount); //          5  6
    
    //These 3 loops I am going to try and make into 1.
    for (int x = 0; x < self.totalNumberOfCards; x ++){
        [self.PlayingCardViews addObject:[[PlayingCardView alloc] initWithFrame:
                                      [griddy frameOfCellAtRow:x / griddy.columnCount
                                                      inColumn:x % griddy.columnCount
                                       ]]];
    }
    
    for (PlayingCardView *meh in self.PlayingCardViews){
        //[self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView
        //                                                                                     action:@selector(pinch:)]];
        
        //[meh addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:meh action:@selector(tap)]];
        
        [meh addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:meh action:@selector(tap)]];
        
        
        
        
        
        //[self.gridView addSubview:meh];
        
    }
    [self animatedAddCardsToView:self.PlayingCardViews];
    //[self updateUI];
    
    
    
    //[self.gridView addSubview:self.PlayingCardViews.firstObject];
    
    //for (PlayingCardView *meh in self.PlayingCardViews){
    //    [self.gridView addSubview:meh];
    //}
}

/*
 - (void)tap:(UITapGestureRecognizer *)sender{
 NSLog(@"Tap that ass");
 for (PlayingCardView *meh in self.PlayingCardViews){
 NSLog(@"Tapped was tapped %d in PlayingCardView", meh.tag);
 }
 
 //
 NSUInteger cardIndex = [self.PlayingCardViews indexOfObject:sender];
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
    
    for (PlayingCardView *meh in self.PlayingCardViews){
        [self animateRemovingDrops:[[NSArray alloc] initWithObjects:meh, nil]];
    }
    //[self animateRemovingDrops:self.PlayingCardViews];
    
    [super touchDealButton:sender];
    self.totalNumberOfCards = 31;
    self.viewStopAmmount = 21;
    
    // this is a 3 card matching game
    [self.game matchThreeCards];
    
    [self doGridStuff];
    [self updateUI];
}

/*
 //TODO This is calling the deal button, I need it to call the updateUI method? This has been linked to the actual card views.
 - (IBAction)tap:(UITapGestureRecognizer *)sender
 {
 //[super touchDealButton:sender];
 
 // this is a 3 card matching game
 //[self.game matchThreeCards];
 
 NSUInteger cardIndex = sender.view.tag; //[self.PlayingCardViews indexOfObject:sender.view.tag];
 // Supposed to find th card in teh view that will give me the proper index for the card bit it's alwys 6....
 for (PlayingCardView *meh in self.PlayingCardViews){
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
    
    NSUInteger cardIndex = para; //sender.view.tag; //[self.PlayingCardViews indexOfObject:sender.view.tag];
    // Supposed to find th card in teh view that will give me the proper index for the card bit it's alwys 6....
    
    [self.game chooseCardAtIndex:cardIndex];
    
    
    
    [self updateUI];
    NSLog(@"View TOuched");
    [self updateUI];
}


- (void)animateRemovingDrops:(NSArray *)dropsToRemove
{
    
    NSLog(@"Animation thing called");
    [PlayingCardView animateWithDuration:1.0
                          animations:^{
                              for (PlayingCardView *drop in dropsToRemove) {
                                  /*
                                   int x = (arc4random() % (int)(self.gridView.bounds.size.width*5) - (int)self.gridView.bounds.size.width*2);
                                   int y = (int)self.gridView.bounds.size.height;
                                   drop.center = CGPointMake(x,-y);
                                   
                                   drop.center = CGPointMake(self.gridView.bounds.size.width, self.gridView.bounds.size.height);
                                   
                                   //drop.frame = CGRectOffset(drop.frame, 0, 0);
                                   */
                                  drop.center = CGPointZero;
                              }
                          }
                          completion:^(BOOL finished){
                              if (finished){
                                  [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                              }
                          }
     ];
    
    
}


- (void)updateUI
{
    BOOL temp = NO;
    
    //[self doGridStuff];
    //TODO: CARD ARE NIL. NEED TO SEE WHY THAT IS. CHECK THE POSSIBLITY OF IT BEING BECAUSE OF NOT INSTANTIATING SOMETHING OR ANOTHER....
    for (PlayingCardView *setViews in self.PlayingCardViews){
        NSUInteger cardIndex = [self.PlayingCardViews indexOfObject:setViews];
        
        /*
         NSMutableArray *tempView = [self.PlayingCardViews copy];
         for (PlayingCardView *setViews in tempView){
         NSUInteger cardIndex = [tempView indexOfObject:setViews];
         */
        Card *card = [self.game cardAtIndex:cardIndex];
        PlayingCard *setCard = (PlayingCard *)card;
        
        
        setViews.rank = [setCard rank];
        setViews.suit = [setCard suit];
        
        setViews.cardIndexForView = cardIndex;
        setViews.tag = cardIndex;
        setViews.isChosen = card.isChosen;
        setViews.faceUp = card.isChosen;
        setViews.isMatched = card.isMatched;
        setViews.myViewController = self;
        
        //Sets background color for being chosen
        if (setViews.isChosen){
            /*
             CAGradientLayer *gradiant = [CAGradientLayer layer];
             gradiant.frame = setViews.bounds;
             gradiant.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor],(id)[[UIColor blackColor] CGColor], nil];
             [setViews.layer insertSublayer:gradiant above:0];
             */
            //setViews.backgroundColor = [UIColor redColor];
            //[setViews.backgroundColor getRed:(CGFloat *)10 green:(CGFloat *)20 blue:(CGFloat *)20 alpha:(CGFloat *)1];
            
        } else if (!setViews.isChosen){
            //setViews.backgroundColor = [UIColor whiteColor];
            setViews.backgroundColor = [UIColor clearColor];
        }
        
        //TODO Need to make it so the cards are removed and stuff properly. At the moment the view once they are hidden do not become unhidden.
        NSMutableArray *cardsToBeRemoved = [[NSMutableArray alloc] initWithCapacity:4];
        NSMutableArray *dropsToRemove = [[NSMutableArray alloc] init];
        
        for (PlayingCardView *setViews in self.PlayingCardViews){
            NSUInteger cardIndex = [self.PlayingCardViews indexOfObject:setViews];
            Card *card = [self.game cardAtIndex:cardIndex];
            //setViews.hidden = card.isMatched;
            
            if (card.isMatched){
                //[setViews removeFromSuperview];
                self.totalNumberOfCards -= 1;
                temp = YES;
            }
            
            if(card.isMatched){
                [cardsToBeRemoved addObject:card];
                [dropsToRemove addObject:setViews];
            }
            
        }
        
        if ([dropsToRemove count] != 0){
            [self animateRemovingDrops:dropsToRemove];
        }
        
        [self.game removeCardsObject:cardsToBeRemoved];
        //Have to make it wait until animations are finished.
        
        
        if (temp){
            [self doGridStuff];
            break;
            
        }
        
        
    }
    
    
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long) self.game.score];
    
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    [self doGridStuff];
}

- (void)animatedAddCardsToView:(NSArray *)dropsToRemove{
    [PlayingCardView animateWithDuration: 1.0
                          animations:^{
                              for (PlayingCardView *drop in dropsToRemove){
                                  CGPoint temp = drop.center; //CGPointMake(10, 20);  //CGPointMake(drop.center.x, drop.center.y);
                                  drop.center = self.gridView.center;//CGPointZero;
                                  [self.gridView addSubview:drop];
                                  drop.center = temp;
                                  
                              }
                          }
                          completion:^(BOOL finished){
                              //[dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                          }
     ];
}


@end
