//
//  PlayingCardView.m
//  SuperCard
//
//  Created by sameh on 10/15/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView

- (void)tap{
    //self.faceUp = !self.faceUp;
    self.touched = YES;
    [self.myViewController hereIsTheCard:self.tag];
}

- (void)animatedAddCardsToFlip:(NSArray *)dropsToFlip{
    
    [PlayingCardView transitionWithView:self
                               duration:.2
                                options:UIViewAnimationOptionTransitionFlipFromLeft
                             animations:^{
                                 for (PlayingCardView *drop in dropsToFlip){
                                     //[drop.backView removeFromSuperView];
                                     //[self addSubview:drop.frontView];
                                 }
                             }
                             completion:NULL
     ];
    
    
    /*
    [PlayingCardView animateWithDuration: 1.0
                          animations:^{
                              for (PlayingCardView *drop in dropsToFlip){
                                  
                                  
                              }
                          }
                          completion:^(BOOL finished){
                              //[dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                          }
     ];*/
}



#pragma mark - Properties

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.95

- (CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor) {
        _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    }
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

- (void) setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

- (void) setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

- (void) setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

#pragma mark - Gestures Recognizers

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    NSLog(@"Pinch was pinched");
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        self.faceCardScaleFactor *= gesture.scale;
        gesture.scale = 1.0;
    }
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor
{
    return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRadius
{
    return CORNER_RADIUS * [self cornerScaleFactor];
}

- (CGFloat)cornerOffset
{
    return [self cornerRadius] / 3.0;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    // Make this view into a rounded rectangle
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    
    // set the background color
    [[UIColor whiteColor] setFill];
    
    // fill the rounded rectangle with the back background color
    UIRectFill(self.bounds);
    
    // set the stroke color (outer edge of the rounded rectangle)
    [[UIColor blackColor] setStroke];
    
    // stroke the outer edge of the rounded rectangle
    [roundedRect stroke];
    
    /*
    [PlayingCardView transitionWithView:self
                               duration:.2
                                options:UIViewAnimationOptionTransitionFlipFromLeft
                             animations:^{
                             }
                             completion:NULL
     ];
     */
    // is the card face up?
    if (self.faceUp) {

        // yes it is face up.
        // look for an image for the card, this will work for J, Q, K only
        NSString *imageName = [NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit];
        NSLog(@"Looking for image with name %@", imageName);
        UIImage *faceImage = [UIImage imageNamed:imageName];
        

        // did we find an image?
        if (faceImage) {
            // yes we found an image, so it must be a J, Q or K
            // define the space in which the image will be drawn
            if (self.touched) {
            [PlayingCardView transitionWithView:self
                                       duration:.2
                                        options:UIViewAnimationOptionTransitionFlipFromLeft
                                     animations:^{
                                         
            CGRect imageRect = CGRectInset(self.bounds,
                                           self.bounds.size.width * (1.0 - self.faceCardScaleFactor),
                                           self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
            
            // draw the image in the space we made for it
            [faceImage drawInRect:imageRect];
                                     }
                                     completion:NULL
             ];
            } else {
                CGRect imageRect = CGRectInset(self.bounds,
                                               self.bounds.size.width * (1.0 - self.faceCardScaleFactor),
                                               self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
                
                // draw the image in the space we made for it
                [faceImage drawInRect:imageRect];

            }
        } else {
            if (self.touched){
            [PlayingCardView transitionWithView:self
                                       duration:.2
                                        options:UIViewAnimationOptionTransitionFlipFromLeft
                                     animations:^{
            // No we did not find an image, it must be a numbered card
            NSLog(@"Did not find the image with name %@", imageName);
            
            // draw the pips for the numbered card
            [self drawPips];
                                     }
                                     completion:NULL
             ];
            }else {
                // No we did not find an image, it must be a numbered card
                NSLog(@"Did not find the image with name %@", imageName);
                
                // draw the pips for the numbered card
                [self drawPips];
            }
        
        }
        
        // draw the card rank and suit in upper left corner and lower right corner
        [self drawCorners];
    } else {
        // no the card is not face up. Set the image to be the card back
        if (!self.touched){
        [[UIImage imageNamed:@"cardBack"] drawInRect:self.bounds];
        } else {
            [PlayingCardView transitionWithView:self
                                       duration:.2
                                        options:UIViewAnimationOptionTransitionFlipFromLeft
                                     animations:^{
                                            [[UIImage imageNamed:@"cardBack"] drawInRect:self.bounds];
                                     }
                                     completion:NULL
             ];
        
        }
    
    }
                                 
    self.touched = NO;
}

- (NSString *)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

- (void)drawCorners
{
    // we want the text in the corners to be centered
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    // select the font and the scale its size
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
    
    // get a string with the rank and suit on seperate lines
    NSString *cornerTextString = [NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit];
    
    // create an attributed string with the rank and suit using the font and paragraph style and color
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:cornerTextString
                                                                     attributes:@{NSFontAttributeName : cornerFont,
                                                                                  NSParagraphStyleAttributeName : paragraphStyle}];
    
    // setup the rectangle where the text needs to be placed and draw it
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];
    
    // get the current context and rotate it 180 degrees or PI radians
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    
    // draw the same text in the other corner
    [cornerText drawInRect:textBounds];
    
}

#pragma mark - Pips

#define PIP_HOFFSET_PERCENTAGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.090
#define PIP_VOFFSET2_PERCENTAGE 0.175
#define PIP_VOFFSET3_PERCENTAGE 0.270


- (void)drawPips
{
    if ((self.rank == 1) ||
        (self.rank == 3) ||
        (self.rank == 5) ||
        (self.rank == 9)) {
        
        [self drawPipsWithHorizontalOffset:0
                            verticalOffset:0
                        mirroredVertically:NO];
        
    }
    
    if ((self.rank == 6) ||
        (self.rank == 7) ||
        (self.rank == 8)) {
        
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:0
                        mirroredVertically:NO];
        
    }
    
    if ((self.rank == 2) ||
        (self.rank == 3) ||
        (self.rank == 7) ||
        (self.rank == 8) ||
        (self.rank == 10)) {
        
        [self drawPipsWithHorizontalOffset:0
                            verticalOffset:PIP_VOFFSET2_PERCENTAGE
                        mirroredVertically:(self.rank != 7)];
        
    }
    
    if ((self.rank == 4) ||
        (self.rank == 5) ||
        (self.rank == 6) ||
        (self.rank == 7) ||
        (self.rank == 8) ||
        (self.rank == 9) ||
        (self.rank == 10)) {
        
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:PIP_VOFFSET3_PERCENTAGE
                        mirroredVertically:YES];
        
    }
    
    if ((self.rank == 9) ||
        (self.rank == 10)) {
        
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:PIP_VOFFSET1_PERCENTAGE
                        mirroredVertically:YES];
        
    }
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                  mirroredVertically:(BOOL)mirroredVertically
{
    [self drawPipsWithHorizontalOffset:hoffset
                        verticalOffset:voffset
                            upsideDown:NO];
    
    if (mirroredVertically) {
        [self drawPipsWithHorizontalOffset:hoffset
                            verticalOffset:voffset
                                upsideDown:YES];
    }
}

#define PIP_FONT_SCALE_FACTOR 0.012

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                          upsideDown:(BOOL)upsideDown
{
    if (upsideDown) {
        [self pushContextAndRotateUpsideDown];
    }

    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIFont *pipFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    pipFont = [pipFont fontWithSize:[pipFont pointSize] * self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
    NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suit
                                                                         attributes:@{NSFontAttributeName : pipFont}];
    CGSize pipSize = [attributedSuit size];
    CGPoint pipOrigin = CGPointMake(middle.x - pipSize.width/2.0  - hoffset*self.bounds.size.width,
                                    middle.y - pipSize.height/2.0 - voffset*self.bounds.size.height);
    [attributedSuit drawAtPoint:pipOrigin];
    
    if (hoffset) {
        pipOrigin.x += hoffset * 2.0 * self.bounds.size.width;
        [attributedSuit drawAtPoint:pipOrigin];
    }
    
    if (upsideDown) {
        [self popContext];
    }
}

- (void)pushContextAndRotateUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw; // if my bounds change, I want to get my drawRect called
}

- (void)awakeFromNib
{
    [self setup];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end

