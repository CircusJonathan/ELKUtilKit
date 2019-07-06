//
//  ELKStarView.h
//  ELKUtilKit
//
//  Created by Jonathan on 16/1/13.
//  Copyright © 2016年 wing. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 The degree of atomization of the number of stars, accuracy in representing the number of stars
 */
typedef NS_OPTIONS(NSUInteger, ELKStarAtomicity) {
    ELKAtomicityTiny   = 1 << 0,// Tiny calculation, default tiny
    ELKAtomicityHalf   = 1 << 1,// Half calculation
    ELKAtomicityRound  = 1 << 2,// Integer calculation
};


@class ELKStarView;

@protocol ELKStarRatingViewDelegate <NSObject>

@optional

/**
 Feedback the current score

 @param starView  the view of star
 @param score     current score
 */
- (void)starRatingView:(ELKStarView *)starView score:(CGFloat)score;

@end

@interface ELKStarView : UIView

/**
 Total number of star
 */
@property (nonatomic, assign, readonly) NSInteger numberOfStar;
/**
 Current number(score) of star
 */
@property (nonatomic, assign, readonly) CGFloat currentStarNum;
/**
 Whether the view can modify the number of stars by touch.
 Default is NO
 */
@property (nonatomic, assign) BOOL touchEnable;
/**
 Accuracy of Star Number Calculations, default is ELKAtomicityTiny
 */
@property (nonatomic, assign) ELKStarAtomicity starAtomicity;

@property (nonatomic, weak) id<ELKStarRatingViewDelegate> delegate;


/**
 Initializes and returns a newly allocated view object with the specified frame rectangle, and specified total number of stars.

 @param frame  frame rectangle
 @param number total number of stars
 @return       ELKStarView object
 */
- (instancetype)initWithFrame:(CGRect)frame numberOfStar:(NSInteger)number;


/**
 Initializes and returns a newly allocated view object with the specified frame rectangle, specified total number of stars, specified background image name of star, and specified foreground image name of star.

 @param frame    frame rectangle
 @param number   total number of stars
 @param backStar background image name of star
 @param foreStar foreground image name of star
 @return         ELKStarView object
 */
- (instancetype)initWithFrame:(CGRect)frame numberOfStar:(NSInteger)number backStar:(NSString *)backStar andForeStar:(NSString *)foreStar;


/**
 Initializes and returns a newly allocated view object with the specified frame rectangle, specified space between two neighboring stars, and specified total number of stars.

 @param frame  frame rectangle
 @param space  the space between two neighboring stars
 @param number total number of stars
 @return       ELKStarView object
 */
- (instancetype)initWithFrame:(CGRect)frame space:(CGFloat)space numberOfStar:(NSInteger)number;


/**
 Initializes and returns a newly allocated view object with the specified frame rectangle, specified space between two neighboring stars, specified total number of stars, specified background image name of star, and specified foreground image name of star.

 @param frame    frame rectangle
 @param space    the space between two neighboring stars
 @param number   total number of stars
 @param backStar background image name of star
 @param foreStar foreground image name of star
 @return         ELKStarView object
 */
- (instancetype)initWithFrame:(CGRect)frame space:(CGFloat)space numberOfStar:(NSInteger)number backStar:(NSString *)backStar andForeStar:(NSString *)foreStar;


/**
 Set the space between two neighboring stars, star width, total number of stars, background image name of star, and foreground image name of star

 @param space     the space between two neighboring stars
 @param starWidth the width of each star
 @param starNum   total number of stars
 @param backStr   background image name of star
 @param foreStar  foreground image name of star
 */
- (void)setStarSpace:(CGFloat)space starWidth:(CGFloat)starWidth starNumber:(NSInteger)starNum backStar:(NSString *)backStr foreStar:(NSString *)foreStar;


/**
 Set star score (between maximum and minimum of stars)

 @param score   score of star
 @param animate animate
 */
- (void)setScore:(CGFloat)score withAnimation:(BOOL)animate;


/**
 Set star score (between maximum and minimum of stars)

 @param score      score of star
 @param animate    animate
 @param completion finished callback
 */
- (void)setScore:(CGFloat)score withAnimation:(BOOL)animate completion:(void (^)(BOOL finished))completion;



@end
