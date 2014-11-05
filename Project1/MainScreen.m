//
//  MainScreen.m
//  Project1
//
//  Created by Dylan on 11/3/14.
//  Copyright (c) 2014 Dylan. All rights reserved.
//

#import "MainScreen.h"


@interface MainScreen ()

@property (weak, nonatomic) IBOutlet UILabel *nameDisplay;
@property (weak, nonatomic) IBOutlet UILabel *typeDisplay;
- (IBAction)statusButton:(id)sender;
- (IBAction)investigate:(id)sender;
- (IBAction)left:(id)sender;
- (IBAction)right:(id)sender;
- (IBAction)green:(id)sender;
- (IBAction)red:(id)sender;

@property BOOL leftPress;
@property BOOL rightPress;
@property BOOL investPress;
@property BOOL greenPress;
@property BOOL redPress;

@property (weak, nonatomic) IBOutlet UITextView *mainText;


@end

@implementation MainScreen

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
    self.nameDisplay.text = self.mainChar.charName;
    self.typeDisplay.text = self.mainChar.charType;
    
   [self gridStart:0];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gridStart:(int)progress
{
    if (progress == 0) {
        self.mainText.text = @"You've entered the cottage and see an old mysterious man waiting there, grinning. Press INVESTIGATE to speak with him.";
        while (progress == 0) {
            
            if(self.leftPress == YES)
            {
                self.mainText.text = @"You see a table covered in dust to your left with nothing on it.";
                self.leftPress = NO;
            }
            
            if(self.rightPress == YES)
            {
                self.mainText.text = @"Strange idols and trinkets adorn the walls to your right.";
                self.rightPress = NO;
            }
            
            if(self.investPress == YES)
            {
                self.mainText.text = @"'Hello there. Turns out I coincidentally have a quest for you, should you choose to accept it. At the end of the zigzagged path of Yondolore, there lies King Bazul. Last year, the King acquired this region's most powerful artifact, The Yondolorian crown. Since then, people have been slowly corrupted in Yondolore and attacking others at random. Please trek through Yondolore to its end, destroy the evil king, and claim the crown to use it for good. Click the right green arrow to accept my quest, and I shall grant you an item to help your travels.'";
                if(self.greenPress == YES)
                {
                    self.mainText.text = @"'Excellent! Take this Necklace of Valor, and I bid you farewell. Good luck hero! Remember to check out the Status screen and instructions if you're confused.'\n\nYou gain the Necklace of Valor! +3 to Agility, Strength and Intellect. +10 to Health.\nYou exit the room, and venture off to the west to continue your journey.";
                    self.investPress = NO;
                    progress = 1;
                }
                else
                    self.mainText.text = @"'Very well then. But you'll have to start eventually.'";
                
            }  //while loop end
            
            self.mainText.text = @"First screen passed.";
        }
        
    }
    else
        self.mainText.text = @"Did not recieve progress";
    
}

/*

- (NSString *)documentsDirectory
{
    
    return [@"~/Documents" stringByExpandingTildeInPath];
}
- (NSString *)dataFilePath
{
    //COMMENT IN FOR DIRECTORY VIEW
    
    NSLog(@"%@",[self documentsDirectory]);
    return [[self documentsDirectory] stringByAppendingPathComponent:@"practiceChar.plist"];
    
}


- (void)saveItems
{
    
    // create a generic data storage object
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:self.thisChar forKey:@"dataChar"];   //saves our objects to file.
    
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    
}

- (void)loadItems
{
    // get our data file path
    NSString *path = [self dataFilePath];
    
    //do we have anything in our documents directory?  If we have anything then load it up
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        self.thisChar = [unarchiver decodeObjectForKey:@"dataChar"];
        [unarchiver finishDecoding];
    }
} */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)statusButton:(id)sender {
}

- (IBAction)investigate:(id)sender {
    self.investPress = YES;
}

- (IBAction)left:(id)sender {
    
    self.leftPress = YES;
}

- (IBAction)right:(id)sender {
    
    self.rightPress = YES;
}

- (IBAction)green:(id)sender {
    self.greenPress = YES;
    
}

- (IBAction)red:(id)sender {
    self.redPress = YES;
}
@end
