//
//  Status.h
//  Project1
//
//  Table view for char stats and items
//

#import <UIKit/UIKit.h>
#import "MainScreen.h"
#import "LocalChar.h"
#import "Items.h"
#import "Stats.h"
#import "gameStatsViewController.h"

@interface Status : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray * choices;        //fills table cell names with array

@property LocalChar *tableChar;     //creates new localChar instance for this screen to get character info from previous screen, and pass it forward

@end
