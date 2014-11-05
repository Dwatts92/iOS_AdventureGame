//
//  MainScreen.h
//  Project1
//
//  Created by Dylan on 11/3/14.
//  Copyright (c) 2014 Dylan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"
#import "LocalChar.h"
#import "IntroStory.h"

@interface MainScreen : UIViewController

@property LocalChar* mainChar;

-(void)gridStart:(int)progress;

@end
