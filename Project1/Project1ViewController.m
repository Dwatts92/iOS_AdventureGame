//
//  Project1ViewController.m
//  Project1
//
//  Created by Dylan on 11/3/14.
//  Copyright (c) 2014 Dylan. All rights reserved.
//

#import "Project1ViewController.h"

@interface Project1ViewController ()

- (IBAction)startButton:(id)sender;
- (IBAction)howToPlay:(id)sender;

@end

@implementation Project1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // hide navigation bar 
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (IBAction)startButton:(id)sender {
}

- (IBAction)howToPlay:(id)sender {
}
@end
