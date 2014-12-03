//
//  IntroStory.h
//  Project1
//
// Introduction story based on what character you choose.
//

#import <UIKit/UIKit.h>

#import "LocalChar.h"
#import "ChooseClass.h"
#import "MainScreen.h"
#import "FunStats.h"

@interface IntroStory : UIViewController
@property FunStats *globalStats;
@property LocalChar* chosenChar;        //get local char from segue

@end
