//
//  ChooseClass.m
//  Project1
//
//  Created by Dylan on 11/3/14.
//  Copyright (c) 2014 Dylan. All rights reserved.
//

#import "ChooseClass.h"

@interface ChooseClass ()

@property NSString *type;

- (IBAction)warrior:(id)sender;
- (IBAction)archer:(id)sender;
- (IBAction)mage:(id)sender;

@property NSObject * thisChar;

- (IBAction)beginButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *characterName;



@end


@implementation ChooseClass

@synthesize characterName = _characterName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _characterName.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField { //close keyboard on return
    [textField resignFirstResponder];
    return NO;
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event   //this method minimizes the keypad if touched outside of the keyboard in a non-functional area.
{
    [_characterName resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)warrior:(id)sender {
    
    self.type = @"Warrior";
}

- (IBAction)archer:(id)sender {
    
    self.type = @"Archer";
}

- (IBAction)mage:(id)sender {
    
    self.type = @"Mage";

}

- (IBAction)beginButton:(id)sender {

    
}



@end
