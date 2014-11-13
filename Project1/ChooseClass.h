//
//  ChooseClass.h
//  Project1
//
//  Where you pick you character class.
//

#import <UIKit/UIKit.h>
#import "Character.h"
#import "LocalChar.h"
#import "IntroStory.h"
#import "FunStats.h"

@interface ChooseClass : UIViewController <UITextFieldDelegate>
@property FunStats *globalStats;


@end
