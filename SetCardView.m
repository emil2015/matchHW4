//
//  SetCardView.m
//  Drawing
//
//  Created by Sameh Fakhouri on 10/29/14.
//  Copyright (c) 2014 Lehman College. All rights reserved.
//

#import "SetCardView.h"
#import "ViewController.h"

@implementation SetCardView

#pragma mark - Gesture stuff


- (void)tap{
    NSLog(@"Tapped was tapped %d in setCardView", self.tag);
    //ViewController *meh = self.superview;
    //[meh hereIsTheCard:1];
    
    [self.myViewController hereIsTheCard:self.tag];

}

- (void)removeMe{
    [self removeFromSuperview];
}

/*
- (void)IsHidden:(BOOL)isHidden{
    
    if (!self.isHidden){
        self.Hidden = NO;
    }
    
    self.Hidden = isHidden;
}
*/

/*
@property (nonatomic) iewDidLoad{
    
    //I don't know if this is supposed to be here. 
    //[self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
@property (nonatomic) @"View Did Load for setCardView");
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(tap:)];
    
    // Specify that the gesture must be a single tap
    tapRecognizer.numberOfTapsRequired = 1;
    
    // Add the tap gesture recognizer to the view
    [self addGestureRecognizer:tapRecognizer];
    
}
*/



#pragma mark - Properties

- (void)setSymbol:(NSString *)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}

- (void)setCount:(NSUInteger)count
{
    _count = count;
    [self setNeedsDisplay];
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setShade:(NSString *)shade
{
    _shade = shade;
    [self setNeedsDisplay];
}

#pragma mark - Set Card Methods


 + (NSArray *)validSymbols
 {
 return @[@"▲", @"◼︎", @"●"];
 }
 /*
 + (NSArray *)validShades
 {
      //1 = Solid .1 = Striped 0 = Outlined

 return @[@1.0,@0.1,@0.0];
 }
*/
+ (NSArray *)validShades
{
    return @[@"Solid", @"Striped", @"Outlined"];
}
 
 + (NSArray *)validColors
 {
 return @[[UIColor greenColor], [UIColor purpleColor], [UIColor redColor]];
 }
 
/*
+ (NSArray *)validSymbols
{
    return @[@"Oval", @"Diamond", @"Squiggle"];
}

+ (NSArray *)validShades
{
    return @[@"Solid", @"Striped", @"Outlined"];
}

+ (NSArray *)validColors
{
    return @[[UIColor greenColor], [UIColor purpleColor], [UIColor redColor]];
}
*/
+ (NSUInteger)maxCount
{
    return 3;
}

#pragma mark - DrawRect

#define CORNER_FONT_STANDARD_HEIGHT 80.0
#define CORNER_RADIUS 20.0

- (CGFloat)cornerScaleFactor
{
    return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRadius
{
    return CORNER_RADIUS * [self cornerScaleFactor];
}


- (void)drawRect:(CGRect)rect
{
    //Rounds edges of view
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    
    //Background of the whole viwe color
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    //OUtliine of the whole view color
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    //3 different types of shapes. Diamond, Oval, Squiggle
    
    
    if ([self.symbol isEqualToString:@"▲"]){
        [self drawDiamond];
    }
    else if ([self.symbol isEqualToString:@"●"]){
        [self drawOval];
    }
    else if ([self.symbol isEqualToString:@"◼︎"]){
        [self drawSquiggle];
    }
    
    
    
    
}

#pragma mark - Draw Diamond

#define DIAMOND_UPPER_VERTEX_OFFSET 0.10
#define DIAMOND_LOWER_VERTEX_OFFSET 0.10
#define DIAMOND_WIDTH 0.20

- (CGPoint)upperVertex
{
    CGPoint upper = CGPointMake(self.bounds.size.width/2.0,
                                self.bounds.size.height * DIAMOND_UPPER_VERTEX_OFFSET);
    return upper;
}

- (CGPoint)lowerVertex
{
    CGPoint lower = CGPointMake(self.bounds.size.width/2.0,
                                self.bounds.size.height - (self.bounds.size.height * DIAMOND_LOWER_VERTEX_OFFSET));
    return lower;
}

- (CGPoint)leftVertex
{
    CGPoint left = CGPointMake(self.bounds.size.width/2.0 - self.bounds.size.width * DIAMOND_WIDTH / 2.0,
                               self.bounds.size.height / 2.0);
    return left;
}

- (CGPoint)rightVertex
{
    CGPoint right = CGPointMake(self.bounds.size.width/2.0 + self.bounds.size.width * DIAMOND_WIDTH / 2.0,
                                self.bounds.size.height / 2.0);
    return right;
}


- (void)drawDiamond
{
    UIBezierPath *diamond = [[UIBezierPath alloc] init];
    diamond.lineWidth = 2;
    
    [diamond moveToPoint:[self upperVertex]];
    [diamond addLineToPoint:[self rightVertex]];
    [diamond addLineToPoint:[self lowerVertex]];
    [diamond addLineToPoint:[self leftVertex]];
    [diamond addLineToPoint:[self upperVertex]];
    
    // set the color of the diamond
    [self.color setStroke];
    
    if (self.count == 1) {
        // count = 1
        // nothing to add to the drawing
    } else if (self.count == 2) {
        // count = 2
        // you need to make another diamond and position
        // the two of them to be centered
        
        //Makes a copy of the current one
        UIBezierPath *rightCopy = [diamond copy];
        
        //Moves current one to the left
        CGAffineTransform leftTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.15 * -1.0, 0.0};
        [diamond applyTransform:leftTransform];
        
        //Moves copy to the right.
        CGAffineTransform rightTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.15, 0.0};
        [rightCopy applyTransform:rightTransform];
        [diamond appendPath:rightCopy];
        
    } else {
        // count = 3
        UIBezierPath *leftDiamond = [diamond copy];
        CGAffineTransform leftTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.30 * -1.0, 0.0};
        [leftDiamond applyTransform:leftTransform];
        
        UIBezierPath *rightDiamond = [diamond copy];
        CGAffineTransform rightTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.30 , 0.0};
        [rightDiamond applyTransform:rightTransform];
        
        [diamond appendPath:leftDiamond];
        [diamond appendPath:rightDiamond];
    }
    
    if ([self.shade isEqualToString:[SetCardView validShades][0]]) {
        // It is colored solid
        [self.color setFill];
    } else if ([self.shade isEqualToString:[SetCardView validShades][1]]) {
        // It is stripped
        [[UIColor clearColor] setFill];
        CGPoint start = CGPointMake(0.0, 0.0);
        CGPoint end = CGPointMake(self.bounds.size.width, 0.0);
        CGFloat dy = self.bounds.size.height / 15.0;
        [diamond addClip];
        while (start.y <= self.bounds.size.height) {
            [diamond moveToPoint:start];
            [diamond addLineToPoint:end];
            start.y += dy;
            end.y += dy;
        }
    } else {
        // It must be outlined
        [[UIColor clearColor] setFill];
    }
    
    [diamond fill];
    [diamond stroke];
}

#pragma mark - draw Oval

#define OVAL_WIDTH 0.20
#define OVAL_TOP_OFFSET 0.20
#define OVAL_BOTTOM_OFFSET 0.80

- (CGPoint)topLeft
{
    CGPoint upper = CGPointMake(self.bounds.size.width/2.0 - (self.bounds.size.width * OVAL_WIDTH/2.0),
                                self.bounds.size.height * OVAL_TOP_OFFSET);
    return upper;
}

- (CGPoint)topRight
{
    CGPoint lower = CGPointMake(self.bounds.size.width/2.0 + (self.bounds.size.width * OVAL_WIDTH/2.0),
                                self.bounds.size.height * OVAL_TOP_OFFSET);
    return lower;
}

- (CGPoint)bottomRight
{
    CGPoint left = CGPointMake(self.bounds.size.width/2.0 + self.bounds.size.width * OVAL_WIDTH / 2.0,
                               self.bounds.size.height * OVAL_BOTTOM_OFFSET);
    return left;
}

- (CGPoint)bottomeLeft
{
    CGPoint right = CGPointMake(self.bounds.size.width/2.0 - self.bounds.size.width * OVAL_WIDTH / 2.0,
                                self.bounds.size.height * OVAL_BOTTOM_OFFSET);
    return right;
}

- (CGPoint)topOfCurve{
    CGPoint top = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height * OVAL_TOP_OFFSET / 8);
    return top;
}

- (CGPoint)bottomOfCurve{
    CGPoint top = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height * (1 - OVAL_TOP_OFFSET / 8));
    return top;
}

- (CGPoint)centerOfCircle{
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height * OVAL_TOP_OFFSET);
    return center;
}

- (void)drawOval
{
    UIBezierPath *oval = [[UIBezierPath alloc] init];
    oval.lineWidth = 2;
    
    [oval moveToPoint:   [self topLeft]];
    
    //[oval addLineToPoint:[self topRight]];
    //[oval addCurveToPoint:[self topOfCurve] controlPoint1:[self topLeft] controlPoint2:[self topRight]];
    //[oval addArcWithCenter:[self topOfCurve] radius:OVAL_TOP_OFFSET/2.0 startAngle:M_PI/2 endAngle:-M_PI/2 clockwise:true];
    //[oval addCurveToPoint:[self topOfCurve] controlPoint1:[self topLeft] controlPoint2:[self topRight]];
    //[oval addArcWithCenter:[self centerOfCircle] radius:OVAL_WIDTH startAngle:M_PI endAngle:2 * M_PI clockwise:true];
    [oval addCurveToPoint:[self topRight] controlPoint1:[self topOfCurve] controlPoint2:[self topRight]];
    
    [oval addLineToPoint:[self bottomRight]];
    //[oval addLineToPoint:[self bottomeLeft]];
    [oval addCurveToPoint:[self bottomeLeft] controlPoint1:[self bottomOfCurve] controlPoint2:[self bottomeLeft]];
    
    
    [oval addLineToPoint:[self topLeft]];
    
    // set the color of the diamond
    [self.color setStroke];
    
    if (self.count == 1) {
        // count = 1
        // nothing to add to the drawing
    } else if (self.count == 2) {
        // count = 2
        // you need to make another diamond and position
        // the two of them to be centered
        
        //Makes a copy of the current one
        UIBezierPath *rightCopy = [oval copy];
        
        //Moves current one to the left
        CGAffineTransform leftTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.15 * -1.0, 0.0};
        [oval applyTransform:leftTransform];
        
        //Moves copy to the right.
        CGAffineTransform rightTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.15, 0.0};
        [rightCopy applyTransform:rightTransform];
        [oval appendPath:rightCopy];
        
        
    } else {
        // count = 3
        UIBezierPath *leftDiamond = [oval copy];
        CGAffineTransform leftTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.30 * -1.0, 0.0};
        [leftDiamond applyTransform:leftTransform];
        
        UIBezierPath *rightDiamond = [oval copy];
        CGAffineTransform rightTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.30 , 0.0};
        [rightDiamond applyTransform:rightTransform];
        
        [oval appendPath:leftDiamond];
        [oval appendPath:rightDiamond];
    }
    
    if ([self.shade isEqualToString:[SetCardView validShades][0]]) {
        // It is colored solid
        [self.color setFill];
    } else if ([self.shade isEqualToString:[SetCardView validShades][1]]) {
        // It is stripped
        [[UIColor clearColor] setFill];
        CGPoint start = CGPointMake(0.0, 0.0);
        CGPoint end = CGPointMake(self.bounds.size.width, 0.0);
        CGFloat dy = self.bounds.size.height / 15.0;
        [oval addClip];
        while (start.y <= self.bounds.size.height) {
            [oval moveToPoint:start];
            [oval addLineToPoint:end];
            start.y += dy;
            end.y += dy;
        }
    } else {
        // It must be outlined
        [[UIColor clearColor] setFill];
    }
    
    [oval fill];
    [oval stroke];
}

#pragma mark - draw Squiggle

#define SQUIGGLE_WIDTH 0.20
#define SQUIGGLE_TOP_OFFSET 0.20
#define SQUIGGLE_BOTTOM_OFFSET 0.80



- (CGPoint)rightSquiggleTopPoint{
    CGPoint side = CGPointMake(self.bounds.size.width / 2 + self.bounds.size.width * SQUIGGLE_WIDTH, self.bounds.size.height * .35);
    return side;
}

- (CGPoint)rightSquiggleBottomPoint{
    CGPoint side = CGPointMake(self.bounds.size.width / 2 + SQUIGGLE_WIDTH, self.bounds.size.height * .65);
    return side;
}

- (CGPoint)leftSquiggleTopPoint{
    CGPoint side = CGPointMake(self.bounds.size.width / 2 - SQUIGGLE_WIDTH, self.bounds.size.height * .35);
    return side;
}

- (CGPoint)leftSquiggleBottomPoint{
    CGPoint side = CGPointMake(self.bounds.size.width / 2 - self.bounds.size.width * SQUIGGLE_WIDTH, self.bounds.size.height * .65);
    return side;
}

- (void)drawSquiggle
{
    UIBezierPath *Squiggle = [[UIBezierPath alloc] init];
    Squiggle.lineWidth = 2;
    
    [Squiggle moveToPoint:   [self topLeft]];
    
    //[oval addLineToPoint:[self topRight]];
    [Squiggle addCurveToPoint:[self topRight] controlPoint1:[self topOfCurve] controlPoint2:[self topRight]];
    
    //[Squiggle addLineToPoint:[self bottomRight]];
    [Squiggle addCurveToPoint:[self bottomRight] controlPoint1:[self rightSquiggleTopPoint] controlPoint2:[self rightSquiggleBottomPoint]];
    
    //[Squiggle addLineToPoint:[self bottomeLeft]];
    [Squiggle addCurveToPoint:[self bottomeLeft] controlPoint1:[self bottomOfCurve] controlPoint2:[self bottomeLeft]];
    
    //[Squiggle addLineToPoint:[self topLeft]];
    
    [Squiggle addCurveToPoint:[self topLeft] controlPoint1:[self leftSquiggleBottomPoint] controlPoint2:[self leftSquiggleTopPoint]];
    
    
    // set the color of the diamond
    [self.color setStroke];
    
    if (self.count == 1) {
        // count = 1
        // nothing to add to the drawing
    } else if (self.count == 2) {
        // count = 2
        // you need to make another diamond and position
        // the two of them to be centered
        
        //Makes a copy of the current one
        UIBezierPath *rightCopy = [Squiggle copy];
        
        //Moves current one to the left
        CGAffineTransform leftTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.15 * -1.0, 0.0};
        [Squiggle applyTransform:leftTransform];
        
        //Moves copy to the right.
        CGAffineTransform rightTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.15, 0.0};
        [rightCopy applyTransform:rightTransform];
        [Squiggle appendPath:rightCopy];
        
    } else {
        // count = 3
        UIBezierPath *leftDiamond = [Squiggle copy];
        CGAffineTransform leftTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.30 * -1.0, 0.0};
        [leftDiamond applyTransform:leftTransform];
        
        UIBezierPath *rightDiamond = [Squiggle copy];
        CGAffineTransform rightTransform = {1.0, 0.0, 0.0, 1.0, self.bounds.size.width * 0.30 , 0.0};
        [rightDiamond applyTransform:rightTransform];
        
        [Squiggle appendPath:leftDiamond];
        [Squiggle appendPath:rightDiamond];
    }
    
    if ([self.shade isEqualToString:[SetCardView validShades][0]]) {
        // It is colored solid
        [self.color setFill];
    } else if ([self.shade isEqualToString:[SetCardView validShades][1]]) {
        // It is stripped
        [[UIColor clearColor] setFill];
        CGPoint start = CGPointMake(0.0, 0.0);
        CGPoint end = CGPointMake(self.bounds.size.width, 0.0);
        CGFloat dy = self.bounds.size.height / 15.0;
        [Squiggle addClip];
        while (start.y <= self.bounds.size.height) {
            [Squiggle moveToPoint:start];
            [Squiggle addLineToPoint:end];
            start.y += dy;
            end.y += dy;
        }
    } else {
        // It must be outlined
        [[UIColor clearColor] setFill];
    }
    
    [Squiggle fill];
    [Squiggle stroke];
}


#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
