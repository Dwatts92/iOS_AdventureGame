//
//  Stats.h
//  Project1
//
//  Stats header.
//

#import <UIKit/UIKit.h>
#import "Status.h"
#import "LocalChar.h"
#import "FunStats.h"
#import "FunStatsViewController.h"

@interface Stats : UIViewController
@property FunStats *globalStats;
@property LocalChar *statsChar;  //new instance of LocalChar that you get from segue.

@end
