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

@interface IntroStory : UIViewController

@property LocalChar* chosenChar;        //get local char from segue

@end
