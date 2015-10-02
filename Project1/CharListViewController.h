//
//  CharListViewController.h
//  Project1
//
//  Created by ddwatts on 12/6/14.
//  Copyright (c) 2014 Dylan. All rights reserved.
//

#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import "MainScreen.h"
#import "Project1ViewController.h"
#import "LocalChar.h"

@interface CharListViewController : PFQueryTableViewController

@property LocalChar *loadChar;

@end
