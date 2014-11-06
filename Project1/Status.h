//
//  Status.h
//  Project1
//
//  Created by Dylan on 11/5/14.
//  Copyright (c) 2014 Dylan. All rights reserved.
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
