//
//  SetStats.m
//  Project1
//
//  Created by ddwatts on 12/3/14.
//  Copyright (c) 2014 Dylan. All rights reserved.
//

#import "SetStats.h"

@interface SetStats ()
- (IBAction)contButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *strDisplay;   //displays for each of the attributes
@property (weak, nonatomic) IBOutlet UILabel *aglDisplay;
@property (weak, nonatomic) IBOutlet UILabel *intelDisplay;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet UIStepper *strConnect;     //connecting steppers
@property (weak, nonatomic) IBOutlet UIStepper *aglConnect;
@property (weak, nonatomic) IBOutlet UIStepper *intelConnect;

- (IBAction)strStep:(id)sender;     //steppers for each attribute
- (IBAction)aglStep:(id)sender;
- (IBAction)intelStep:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *contButton;

@property int tempStr;      //temp values for stepper modification
@property int tempAgl;
@property int tempIntel;

@property int oldAgi;
@property int oldStr;
@property int oldIntel;

@property int points;
@property BOOL saved;

//@property int points;       //5 points that can be divied up


@end

@implementation SetStats

- (void)viewDidLoad {
    [super viewDidLoad];
    
           //self.contButton.hidden = YES;

    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"page2.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    self.tempStr = self.statChar.strength;  //intializes temp variables
    self.tempAgl = self.statChar.agility;
    self.tempIntel = self.statChar.intellect;
    
    self.strDisplay.text=[NSString stringWithFormat:@"%d", self.statChar.strength]; //shows attributes
    self.aglDisplay.text=[NSString stringWithFormat:@"%d", self.statChar.agility];
    self.intelDisplay.text=[NSString stringWithFormat:@"%d", self.statChar.intellect];
    
    
    /*
    self.oldStr= self.tempStr;    //set stepper value to attributes
    self.oldAgi= self.tempAgl;
    self.oldIntel= self.tempIntel; */
    
    self.oldStr = self.strConnect.value;    //stepper logic
    self.oldAgi = self.strConnect.value;
    self.oldIntel = self.strConnect.value;
    
    /*
    self.strConnect.minimumValue= self.tempStr;     //sets minimum value to beginning attriube values
    self.aglConnect.minimumValue= self.tempAgl;
    self.intelConnect.minimumValue= self.tempIntel;
    */
    self.points = 0;  //sets up points, goes to 5
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSString *)documentsDirectory
{
    
    return [@"~/Documents" stringByExpandingTildeInPath];
}
- (NSString *)dataFilePath
{
    //COMMENT IN FOR DIRECTORY VIEW
    
    //NSLog(@"%@",[self documentsDirectory]);
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Character.plist"];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender    //save Character, sends local character to next screen.
{
    MainScreen *dest = segue.destinationViewController;
    
    //[self saveItems]; ADD BACK IN FOR LOCAL DATA
    self.statChar.agility = self.tempAgl;
    self.statChar.intellect = self.tempIntel;
    self.statChar.strength = self.tempStr;
    
    
    dest.mainChar = self.statChar;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender   //method for if segue should be performed or not.
{
    if (self.points != 5)
    {
        return NO;
    }
    else
    {
        [self saveParse];
        return YES;
    }
}



- (void)saveItems
{
    
    //create a generic data storage object
    
    Character *persistantChar = [[Character alloc] init];   //allocates data for NSCoding object, Character
    
    
    persistantChar.charName = self.statChar.charName;     //fills Character up with local character stats.
    persistantChar.charType = self.statChar.charType;
    persistantChar.gridProgress= self.statChar.gridProgress;
    persistantChar.health = self.statChar.health;
    persistantChar.strength = self.statChar.strength;
    persistantChar.agility = self.statChar.agility;
    persistantChar.intellect = self.statChar.intellect;
    persistantChar.itemCount = self.statChar.itemCount;
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:persistantChar forKey:@"dataChar"];   //archives it for persistant storage
    
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    
}

- (IBAction)contButton:(id)sender {
    
    if ([self shouldPerformSegueWithIdentifier:@"goMain" sender:(id)sender] == NO)
    {
        self.errorLabel.text = @"Please add all 5 points.";
    }
    else{
        
        self.errorLabel.text = @"You've added all points! Begin your quest.";
    }
}

- (IBAction)strStep:(UIStepper *)sender {
    
    
    if(self.strConnect.value > self.oldStr && self.points <5)   //stepper up, points not all spent
    {
        self.oldStr = self.oldStr + 1;
        self.tempStr = self.tempStr + 1;
        self.points = self.points + 1;
        self.strDisplay.text=[NSString stringWithFormat:@"%d", self.tempStr];
       
    }
    else if(self.strConnect.value > self.oldStr && self.points >= 5)      //stepper up, all points spent
    {
        self.oldStr = self.oldStr + 1;
        self.strDisplay.text=[NSString stringWithFormat:@"%d", self.tempStr];
        
    }
    else if (self.strConnect.value < self.oldStr && self.points <5)
    {
        self.oldStr = self.oldStr - 1;
        if (self.tempStr > self.statChar.strength)
        {
            
            self.tempStr = self.tempStr - 1;
            self.points = self.points - 1;
            self.strDisplay.text=[NSString stringWithFormat:@"%d", self.tempStr];
        }
        else
        {
            
        }
    
    }
    else if (self.strConnect.value < self.oldStr && self.points >=5)
    {
        self.oldStr = self.oldStr - 1;
        if (self.tempStr > self.statChar.strength)
        {
            
            self.tempStr = self.tempStr - 1;
            self.points = self.points - 1;
            self.strDisplay.text=[NSString stringWithFormat:@"%d", self.tempStr];
        }
        else
        {
            
        }
    }
    
    
}

- (IBAction)aglStep:(UIStepper *)sender {
    
    if(self.aglConnect.value > self.oldAgi && self.points <5)   //stepper up, points not all spent
    {
        self.oldAgi = self.oldAgi + 1;
        self.tempAgl = self.tempAgl + 1;
        self.points = self.points + 1;
        self.aglDisplay.text=[NSString stringWithFormat:@"%d", self.tempAgl];
        
    }
    else if(self.aglConnect.value > self.oldAgi && self.points >= 5)      //stepper up, all points spent
    {
        self.oldAgi = self.oldAgi + 1;
        self.aglDisplay.text=[NSString stringWithFormat:@"%d", self.tempAgl];
        
    }
    else if (self.aglConnect.value < self.oldAgi && self.points <5)
    {
        self.oldAgi = self.oldAgi - 1;
        if (self.tempAgl > self.statChar.agility)
        {
            
            self.tempAgl = self.tempAgl - 1;
            self.points = self.points - 1;
            self.aglDisplay.text=[NSString stringWithFormat:@"%d", self.tempAgl];
        }
        else
        {
            
        }
        
    }
    else if (self.aglConnect.value < self.oldAgi && self.points >=5)
    {
        self.oldAgi = self.oldAgi - 1;
        if (self.tempAgl > self.statChar.agility)
        {
            
            self.tempAgl = self.tempAgl - 1;
            self.points = self.points - 1;
            self.aglDisplay.text=[NSString stringWithFormat:@"%d", self.tempAgl];
        }
        else
        {
            
        }
    }
}

- (IBAction)intelStep:(UIStepper *)sender {
    if(self.intelConnect.value > self.oldIntel && self.points <5)   //stepper up, points not all spent
    {
        self.oldIntel = self.oldIntel + 1;
        self.tempIntel = self.tempIntel + 1;
        self.points = self.points + 1;
        self.intelDisplay.text=[NSString stringWithFormat:@"%d", self.tempIntel];
        
    }
    else if(self.intelConnect.value > self.oldIntel && self.points >= 5)      //stepper up, all points spent
    {
        self.oldIntel = self.oldIntel + 1;
        self.intelDisplay.text=[NSString stringWithFormat:@"%d", self.tempIntel];
        
    }
    else if (self.intelConnect.value < self.oldIntel && self.points <5)
    {
        self.oldIntel = self.oldIntel - 1;
        if (self.tempIntel > self.statChar.intellect)
        {
            
            self.tempIntel = self.tempIntel - 1;
            self.points = self.points - 1;
            self.intelDisplay.text=[NSString stringWithFormat:@"%d", self.tempIntel];
        }
        else
        {
            
        }
        
    }
    else if (self.intelConnect.value < self.oldIntel && self.points >=5)
    {
        self.oldIntel = self.oldIntel - 1;
        if (self.tempIntel > self.statChar.intellect)
        {
            
            self.tempIntel = self.tempIntel - 1;
            self.points = self.points - 1;
            self.intelDisplay.text=[NSString stringWithFormat:@"%d", self.tempIntel];
        }
        else
        {
            
        }
    }
}

-(void)saveParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"Character"];
    [query whereKey:@"charName" equalTo:self.statChar.charName];
    PFObject *parseChar = [query getFirstObject];
        
    
    
        if (!parseChar) {  //change to !error?
            NSLog(@"The getFirstObject request failed.");
        } else {
            // The find succeeded.
            NSLog(@"HERE save.");
            
            
            
            self.statChar.agility = self.tempAgl;
            self.statChar.intellect = self.tempIntel;
            self.statChar.strength = self.tempStr;

            parseChar[@"strength"] = @(self.statChar.strength);
            parseChar[@"agility"] = @(self.statChar.agility);
            parseChar[@"intellect"] = @(self.statChar.intellect);
            
            [parseChar save];
            
            }
    

}
@end
