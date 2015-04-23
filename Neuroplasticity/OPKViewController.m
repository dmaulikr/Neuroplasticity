//
//  OPKViewController.m
//  Neuroplasticity
//
//  Created by David Monson on 4/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "OPKViewController.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

typedef NS_ENUM(NSUInteger, StripeSize) {
    StripeSizeSmallest,
    StripeSizeSmall,
    StripeSizeMedium,
    StripeSizeLarge,
    StripeSizeLargest,
};

typedef NS_ENUM(NSUInteger, StripeColor) {
    StripeColorRed,
    StripeColorBlue,
    StripeColorGreen,
    StripeColorOrange,
    StripeColorPurple,
};

typedef NS_ENUM(NSUInteger, MovementDirection) {
    MovementDirectionRight,
    MovementDirectionLeft,
    MovementDirectionDown,
    MovementDirectionUp,
    MovementDirectionUpRight,
    MovementDirectionUpLeft,
    MovementDirectionDownRight,
    MovementDirectionDownLeft,
};

static NSString * const nameKey = @"name";
static NSString * const identifierKey = @"identifier";
static NSString * const movementDirectionKey = @"movementDirection";
static NSString * const targetTypeKey = @"targetType";
static NSString * const dotColorKey = @"dotColor";
static NSString * const dotSizeKey = @"dotSize";
static NSString * const speedKey = @"speed";
static NSString * const sinusoidalKey = @"sinusoidal";
static NSString * const repetitionsKey = @"repetitions";
static NSString * const initialPauseKey = @"initialPause";
static NSString * const finalPauseKey = @"finalPause";
static NSString * const startPositionKey = @"startPosition";
static NSString * const endPositionKey = @"endPosition";

@interface OPKViewController ()

@end

@implementation OPKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self performActivityWithDictionary:self.activity];

}

- (void) performActivityWithDictionary:(NSDictionary *)dictionary {
    
    UIView *giantView = [[UIView alloc] initWithFrame:CGRectMake(- self.view.frame.size.width, - self.view.frame.size.height, self.view.frame.size.width * 3, self.view.frame.size.height * 3)];
    [giantView setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat rectangleWidth;
    
    StripeSize chosenStripeSize = [dictionary[dotSizeKey] integerValue];
    
    switch (chosenStripeSize) {
        case StripeSizeSmallest:
            rectangleWidth = giantView.bounds.size.width / 50;
            break;
        case StripeSizeSmall:
            rectangleWidth = giantView.bounds.size.width / 40;
            break;
        case StripeSizeMedium:
            rectangleWidth = giantView.bounds.size.width / 30;
            break;
        case StripeSizeLarge:
            rectangleWidth = giantView.bounds.size.width / 20;
            break;
        case StripeSizeLargest:
            rectangleWidth = giantView.bounds.size.width / 10;
            break;
    }
    
    //insert width code here
    
    UIColor *backgroundColor;
    
    StripeColor chosenStripeColor = [dictionary[dotColorKey] integerValue];
    
    switch (chosenStripeColor) {
        case StripeColorBlue:
            backgroundColor = [UIColor blueColor];
            break;
        case StripeColorGreen:
            backgroundColor = [UIColor greenColor];
            break;
        case StripeColorOrange:
            backgroundColor = [UIColor orangeColor];
            break;
        case StripeColorPurple:
            backgroundColor = [UIColor purpleColor];
            break;
        case StripeColorRed:
            backgroundColor = [UIColor redColor];
            break;
    }
    
    //insert color code here
    
    double rads;
    
    MovementDirection chosenMoveDirection = [dictionary[movementDirectionKey] integerValue];
    
    switch (chosenMoveDirection) {
        case MovementDirectionDown:
            rads = DEGREES_TO_RADIANS(90);
            break;
        case MovementDirectionDownLeft:
            rads = DEGREES_TO_RADIANS(135);
            break;
        case MovementDirectionDownRight:
            rads = DEGREES_TO_RADIANS(45);
            break;
        case MovementDirectionLeft:
            rads = DEGREES_TO_RADIANS(180);
            break;
        case MovementDirectionRight:
            rads = DEGREES_TO_RADIANS(0);
            break;
        case MovementDirectionUp:
            rads = DEGREES_TO_RADIANS(-90);
            break;
        case MovementDirectionUpLeft:
            rads = DEGREES_TO_RADIANS(-135);
            break;
        case MovementDirectionUpRight:
            rads = DEGREES_TO_RADIANS(-45);
            break;
    }
    giantView.transform = CGAffineTransformMakeRotation(rads);
    
    [self.view addSubview:giantView];
    
    int duration = 5;
    int totalRepeats = 10;

    
    for (int rectangleStartingPoint = 0; rectangleStartingPoint < giantView.bounds.size.width; (rectangleStartingPoint += rectangleWidth * 2)) {
        UIView *rectangleView = [[UIView alloc] initWithFrame:CGRectMake(giantView.bounds.origin.x, giantView.bounds.origin.y, rectangleWidth, giantView.bounds.size.height)];
        rectangleView.backgroundColor = backgroundColor;
        
//        [self.view addSubview:giantView];
        [giantView addSubview:rectangleView];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(giantView.bounds.origin.x + rectangleStartingPoint, giantView.bounds.size.height/2)]];
        [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(giantView.bounds.origin.x + rectangleStartingPoint + rectangleWidth * 2, giantView.bounds.size.height/2)]];
        CGFloat animationDuration = duration; // 11 based on 1-10 inverted scale
        [animation setDuration:animationDuration];
        animation.repeatCount = totalRepeats;
        [rectangleView.layer addAnimation:animation forKey:@"position"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
