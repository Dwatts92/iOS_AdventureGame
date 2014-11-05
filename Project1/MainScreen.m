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

@property (weak, nonatomic) IBOutlet UIImageView *gridPicture;

@property BOOL leftPress;
@property BOOL rightPress;
@property BOOL investPress;
@property BOOL greenPress;
@property BOOL redPress;
@property int buttonProg;

@property int enemy1_health;
@property int enemy2_health;
@property int enemy3_health;
@property int enemy4_health;
@property int tempHealth;

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
    
    self.enemy1_health = 30;
    self.enemy2_health = 40;
    self.enemy3_health = 50;
    self.enemy4_health = 60;
    
    self.mainChar.health = 300;
    self.mainChar.strength = 10;
    
    self.tempHealth = self.mainChar.health;
    
    self.mainText.text = @"Welcome to the main view of the grid. Press INVESTIGATE to begin the area you are starting in or left off in. Press LEFT and RIGHT buttons to explore the area.";

    self.nameDisplay.text = self.mainChar.charName;
    self.typeDisplay.text = self.mainChar.charType;
    
   //[self gridStart:0];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
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
*/
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
    
    if (self.mainChar.gridProgress == 0)    //SQUARE 1
    {
        //self.buttonProg = 0;
        self.mainText.text = @"You've stepped into the cottage and see the stranger awaiting you.\n\n'Hello there. Turns out I coincidentally have a quest for you, should you choose to accept it. At the end of the zigzagged path of Yondolore, there lies King Bazul. Last year, the King acquired this region's most powerful artifact, The Yondolorian crown. Since then, people have been slowly corrupted in Yondolore and attacking others at random. Please trek through Yondolore to its end, destroy the evil king, and claim the crown to use it for good. \n\nClick the GREEN button to accept my quest, and I shall grant you an item to help your travels.'";
        //self.buttonProg = 1;
        self.mainChar.gridProgress = 1;
    }
    else if (self.mainChar.gridProgress == 3) //SQ 2
    {
        self.mainText.text= @"The troll looks up and speaks: \n\n'Before I let you pass, I will ask you question. What is the name of the evil king? Is it A: Bazul or B: Gannon? \n\n Click the GREEN button to answer A, RED button to answer B.";
        self.mainChar.gridProgress = 4;
    }
    
}

- (IBAction)left:(id)sender {
    
    self.leftPress = YES;
    if (self.mainChar.gridProgress == 0) //SQUARE 1
    {
        self.mainText.text = @"You see a table covered in dust to your left with nothing on it. This cottage has been here for a long time.";
    }

    else if (self.mainChar.gridProgress == 3) //SQUARE 2
    {
        self.mainText.text= @"To the left of the bridge is just...well, water. Deep water. You could walk around, but the steep river seems to go on for miles.";
    }
}

- (IBAction)right:(id)sender {
    
    self.rightPress = YES;
    
    if (self.mainChar.gridProgress == 0) //SQUARE 1
    {
        self.mainText.text = @"Strange idols and trinkets adorn the walls to your right. Weird.";
    }
    else if (self.mainChar.gridProgress == 2) //SQ 2
    {
        self.mainText.text = @"You come to a bridge guarded by a slimey troll. His face is stoic and body unmoving. \n\nLike before, hit INVESTIGATE to check him out, or LEFT or RIGHT to move around and inspect the area.";
        self.mainChar.gridProgress = 3;
        
        //SAVE HERE
    }
    else if (self.mainChar.gridProgress == 3)
    {
        self.mainText.text= @"You walk to the right of the bridge, the water looks surprisingly steep. No way you're getting across that.";
    }
    else if (self.mainChar.gridProgress == 5)
    {
        self.mainText.text= @"After going across the bridge, you come across two bandits guarding gates. Before you have a chance to think, they engage you in combat.\n\nCombat has begun. Attack with the GREEN button, or block and heal with the RED button.";
        self.mainChar.gridProgress = 6;
    }
    
    
}

- (IBAction)green:(id)sender {
    self.greenPress = YES;
    
    if (self.mainChar.gridProgress == 1) {  //SQ 1!!!!!
        self.mainText.text = @"'Excellent! Take this Necklace of Valor, and I bid you farewell. Good luck hero! Remember to check out the Status screen and instructions if you're confused.'\n\nYou gain the Necklace of Valor! +3 to Agility, Strength and Intellect. +10 to Health.\n\nYou exit the room, and close the door to the cottage.\n\nClick the RIGHT button to carry on west to your quest.";
        self.mainChar.agility =+3;
        self.mainChar.strength =+3;
        self.mainChar.intellect =+3;
        self.mainChar.health=+10;
        self.mainChar.itemCount = 1;
        
        self.mainChar.gridProgress = 2;
        
       // self.buttonProg = 2;
    }
    else if(self.mainChar.gridProgress == 4)  //SQ 2
    {
        self.mainText.text = @"Correct! Have a delicious stat bonus, hero. Carry on.\n\nYou gain +5 to Intellect!\n\nPress RIGHT to push on.";
        self.mainChar.gridProgress = 5;
        self.mainChar.intellect =+5;
       // self.buttonProg =5;
    }
    else if(self.mainChar.gridProgress == 6)
    {
        int enemy_attack = 5 + arc4random_uniform(4);
        int attack = 0;
        int r = arc4random_uniform(5);
        attack = self.mainChar.strength + r;
        
        int newHealth = self.tempHealth - enemy_attack;
        self.enemy1_health = self.enemy1_health - attack;
        
        if (self.tempHealth > 0 && self.enemy1_health > 0) {
            self.mainText.text = [NSString stringWithFormat: @"Your Current Health: %d\n\nYou attack first for %d damage.\n\nEnemy swings back for %d damage.\n\nYour resulting health is %d\n\nClick GREEN to attack again, or RED to block and heal.",self.tempHealth,attack,enemy_attack, newHealth];
            self.tempHealth = newHealth;
        }
        else if (self.tempHealth <= 0)
        {
            self.mainText.text = @"You took fatal damage from the enemy on the last attack. You have died! Click GREEN button to attack and try again. You will be reborn with extra health for replaying the battle.";
            self.tempHealth = self.mainChar.health + 20;
            self.enemy1_health = 30;
        }
        else if (self.enemy1_health <= 0)
        {
            self.mainText.text = @"You destroy the bandits with a final attack. You find an item amongst their corpses, Chainmail of Martyrs.\n\nYou gain +15 Health from the chainmail, and +8 to Strength!\n\nPress the right button to continue through the gates on your quest.";
            self.mainChar.gridProgress = 7;
            self.tempHealth = self.mainChar.health;
            self.enemy1_health = 30;
        }
        
    } //end first battle
    
}

- (IBAction)red:(id)sender {
    self.redPress = YES;
    if (self.mainChar.gridProgress == 1) {  //SQ 1
       self.mainText.text = @"'Very well then. But you'll have to start eventually.'";
    }
    
    if(self.mainChar.gridProgress == 4)  //SQ 2
    {
        self.mainText.text = @"Wrong. Gannon is name from a different place. You may pass, but you shall lose wisdom for this.\n\n You lose 3 Intellect\n\nPRESS RIGHT to push on.";
        self.mainChar.intellect =-3;
        self.mainChar.gridProgress = 5;
       // self.buttonProg =5;
    }

}
@end
