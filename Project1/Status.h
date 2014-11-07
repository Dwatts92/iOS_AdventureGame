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

@interface Status : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray * choices;

@property LocalChar *tableChar;

@end
