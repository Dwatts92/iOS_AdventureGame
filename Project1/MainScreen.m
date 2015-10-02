//
//  MainScreen.m
//  Project1
//
// Main screen of the game. View about file if need more info.
// I have explained everything through playing the game.

#import "MainScreen.h"
@import AudioToolbox;
@import AVFoundation;

@interface MainScreen ()

@property (weak, nonatomic) IBOutlet UILabel *nameDisplay; //displays name and type for testing, hidden
@property (weak, nonatomic) IBOutlet UILabel *typeDisplay;

- (IBAction)statusButton:(id)sender;    //button actions
- (IBAction)investigate:(id)sender;
- (IBAction)left:(id)sender;
- (IBAction)right:(id)sender;
- (IBAction)green:(id)sender;
- (IBAction)red:(id)sender;
- (IBAction)mapSwitch:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *switcher;

@property (weak, nonatomic) IBOutlet UIImageView *gridPicture;  //picture in grid, changes everytime a scenario is finished
@property AVAudioPlayer *attack, *block, *investigate, *walk;

@property BOOL daunting;    //check if optional item is aquired.


@property int enemy1_health;    //health values for each of the 3 enemies/battles
@property int enemy2_health;
@property int enemy3_health;
@property int tempHealth;       //temp health

@property int viewSwitch;

@property BOOL viewLock;

@property (weak, nonatomic) IBOutlet UITextView *mainText;  //The scrolling view with text, all game text goes in here. Changes with button hits. User plays the game by reading this and reacting with buttons.



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
    self.viewLock = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.mainText.layer.cornerRadius = 1;
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"light brown.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"deep_brown.jpg"] drawInRect:self.view.bounds];
    UIImage *image2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.mainText.backgroundColor = [UIColor blackColor];
    
    self.mainText.backgroundColor = [UIColor colorWithPatternImage:image2];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    //[self loadItems]; ADD BACK IN FOR LOCAL STORAGE
    [self loadParse];
    
    NSString *path;
    NSURL *soundUrl;
    NSError *error;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    path = [[NSBundle mainBundle] pathForResource:@"attack" ofType:@"mp3"];
    soundUrl = [NSURL fileURLWithPath:path];
    self.attack = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:&error];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    path = [[NSBundle mainBundle] pathForResource:@"block" ofType:@"mp3"];
    soundUrl = [NSURL fileURLWithPath:path];
    self.block = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:&error];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    path = [[NSBundle mainBundle] pathForResource:@"investigate" ofType:@"mp3"];
    soundUrl = [NSURL fileURLWithPath:path];
    self.investigate = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:&error];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    path = [[NSBundle mainBundle] pathForResource:@"walk" ofType:@"mp3"];
    soundUrl = [NSURL fileURLWithPath:path];
    self.walk = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:&error];
    
    self.enemy1_health = 90;        //health for enemies
    self.enemy2_health = 150;
    self.enemy3_health = 200;
    
    self.viewSwitch = 0;
    
    
    self.tempHealth = self.mainChar.health;     //temp health;
    
    //health in battles uses your base damage value, but from there your health will increase and decrease do to attacking and blocking, has no affect on actual health value held in character stats (which is the base health).
    

    
    self.mainText.text = @"Welcome to the main view of the grid/map. Press INVESTIGATE to begin the event, LEFT or RIGHT arrows to move and explore the area. Press STATUS for stats and to exit to main menu. \n\n Or If you're continuing from a previous adventure, press the RIGHT arrow to start right after where you left off. Click the small image in the top left to switch from scenario view to map view once you've started the game.\n\n If you have beaten the game and are fighting in the arena, hit the GREEN or RED buttons to begin fighting. \n\n The game will auto save after each square/scenario beaten. \n\nYou will be represented by a purple avatar on the grid when you start.";   //opening text. user presses RIGHT to continue right where they left off if loading a character form storage
    if (self.mainChar.gridProgress > 1)
    {
        self.mainText.text=@"Welcome back. Press the RIGHT button to continue just after you left off.";
    }
    if (self.mainChar.gridProgress > 22)
    {
        self.mainText.text=@"Welcome back to the arena. Press GREEN or RED to start fighting.";
    }
    
    self.nameDisplay.text = self.mainChar.charName;     //display for error checking and testing, hidden.
    self.typeDisplay.text = self.mainChar.charType;
    
    //self.switcher = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//NSCoding

- (NSString *)documentsDirectory
{
    
    return [@"~/Documents" stringByExpandingTildeInPath];
}
- (NSString *)dataFilePath
{
    //COMMENT IN FOR DIRECTORY VIEW
    
    //  NSLog(@"%@",[self documentsDirectory]);
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Character.plist"];
    
}





- (void)saveItems
{
    
    //create a generic data storage object
    
    Character *persistantChar = [[Character alloc] init]; //allocates data for NSCoding object, Character
    
    
    persistantChar.charName = self.mainChar.charName; //fills up Character with LocalCharacter stats
    persistantChar.charType = self.mainChar.charType;
    persistantChar.gridProgress= self.mainChar.gridProgress;
    persistantChar.health = self.mainChar.health;
    persistantChar.strength = self.mainChar.strength;
    persistantChar.agility = self.mainChar.agility;
    persistantChar.intellect = self.mainChar.intellect;
    persistantChar.itemCount = self.mainChar.itemCount;
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:persistantChar forKey:@"dataChar"];   //stores Character to file
    
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    
}

- (void)loadItems
{
    // get our data file path
    NSString *path = [self dataFilePath];
    
    //do we have anything in our documents directory?  If we have anything then load it up
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        Character *persistantChar = [[Character alloc] init];   //create NSCoding object, Character
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        persistantChar = [unarchiver decodeObjectForKey:@"dataChar"];
        [unarchiver finishDecoding];
        
        //  NSLog(@"Contents: %@",[persistantChar description]);  //shown to make sure its loading correctly
        /*
        
        self.mainChar.charName = persistantChar.charName;   //load storage stats into local character
        self.mainChar.charType = persistantChar.charType;
        self.mainChar.gridProgress = persistantChar.gridProgress;
        self.mainChar.health = persistantChar.health;
        self.mainChar.strength = persistantChar.strength;
        self.mainChar.agility = persistantChar.agility;
        self.mainChar.intellect = persistantChar.intellect;
        self.mainChar.itemCount = persistantChar.itemCount; */
        
        
    }
}

-(void)loadParse
{
    NSLog(@"LOOK HERE: %@",self.mainChar.charName);
    PFQuery *query = [PFQuery queryWithClassName:@"Character"];
    [query whereKey:@"charName" equalTo:self.mainChar.charName];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *parseChar, NSError *error) {
        if (!parseChar) {
            NSLog(@"The getFirstObject request failed.");
        } else {
            // The find succeeded.
            NSLog(@"Successfully retrieved the object.");
            
            self.mainChar.charName = parseChar[@"charName"];   //load storage stats into local character
            self.mainChar.charType = parseChar[@"charType"];
            self.mainChar.gridProgress = [[parseChar objectForKey:@"gridProgress"] intValue];
            self.mainChar.health = [[parseChar objectForKey:@"health"] intValue];
            self.mainChar.strength = [[parseChar objectForKey:@"strength"] intValue];
            self.mainChar.agility = [[parseChar objectForKey:@"agility"] intValue];
            self.mainChar.intellect = [[parseChar objectForKey:@"intellect"] intValue];
            self.mainChar.itemCount = [[parseChar objectForKey:@"itemCount"] intValue];
            
            self.mainChar.exp = [[parseChar objectForKey:@"exp"] intValue];
            self.mainChar.lvl = [[parseChar objectForKey:@"lvl"] intValue];
            self.mainChar.rank = [[parseChar objectForKey:@"rank"] intValue];
            self.mainChar.battles = [[parseChar objectForKey:@"battles"] intValue];
            self.mainChar.deaths = [[parseChar objectForKey:@"deaths"] intValue];
            self.mainChar.blocks = [[parseChar objectForKey:@"blocks"] intValue];
            self.mainChar.attacks = [[parseChar objectForKey:@"attacks"] intValue];
            
            NSLog(@"Name:%@ Type:%@ Grid Progress:%d/21 Health: %d Strength: %d Agility: %d Intellect: %d Item Progress: %d Exp: %d Lvl: %d Rank: %d Battles: %d Deaths: %d Blocks: %d Attacks: %d",self.mainChar.charName, self.mainChar.charType,self.mainChar.gridProgress,self.mainChar.health, self.mainChar.strength,self.mainChar.agility,self.mainChar.intellect,self.mainChar.itemCount, self.mainChar.exp, self.mainChar.lvl, self.mainChar.rank, self.mainChar.battles, self.mainChar.deaths, self.mainChar.blocks, self.mainChar.attacks);
        }
    }];
}

-(void)saveParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"Character"];
    [query whereKey:@"charName" equalTo:self.mainChar.charName];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *parseChar, NSError *error) {
    
    
    if (!parseChar) {  //change to !error?
        NSLog(@"The getFirstObject request failed.");
    } else {
        // The find succeeded.
        NSLog(@"SetStats save.");
        
        parseChar[@"charName"] = self.mainChar.charName;
        parseChar[@"charType"] = self.mainChar.charType;
        parseChar[@"gridProgress"] = @(self.mainChar.gridProgress);
        parseChar[@"health"] = @(self.mainChar.health);
        parseChar[@"strength"] = @(self.mainChar.strength);
        parseChar[@"agility"] = @(self.mainChar.agility);
        parseChar[@"intellect"] = @(self.mainChar.intellect);
        parseChar[@"itemCount"] = @(self.mainChar.itemCount);
        
        parseChar[@"exp"] = @(self.mainChar.exp);
        self.mainChar.lvl = 1 + (self.mainChar.exp/50);
        parseChar[@"lvl"] = @(self.mainChar.lvl);
        parseChar[@"rank"] = @(self.mainChar.rank);
        parseChar[@"battles"] = @(self.mainChar.battles);
        parseChar[@"deaths"] = @(self.mainChar.deaths);
        parseChar[@"blocks"] = @(self.mainChar.blocks);
        parseChar[@"attacks"] = @(self.mainChar.attacks);
        
        [parseChar saveInBackground];
        
    }
    }];
    
}






- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Status *dest = segue.destinationViewController;
    
    dest.tableChar = self.mainChar;         //sends character stats to status screen for usage
}


- (IBAction)statusButton:(id)sender {
}


/*
 Below is the logic for the game. The user presses a button, is shown text, and then presses a new button based on that text.
 The gridProgress is changed when ever I want to change states to make it so pushing the same button again can produce different results. For example, you start at gridProgress 0.
 If you explore by hitting the left or right buttons, the text will change, but the progress won't. The first square requires you to hit investigate button to advance, so when you do the gridProgress changes to 1 in the investigate IBAction method.
 Now since there's no if condition for gridProgress 1 in the other buttons, the user won't back track or loop progression.
 Then the user could get asked to press a green button to accept something in the text or deny it, and progress from there, the gridProgress would be updated in the green and red button IBAction method.
 At the end of each scenario or square on the grid, the user is asked to press the right button to move their character and continue. The game saves at this point, so when loaded up, the user just hits the right button and they start off right on the next square.
 The picture on the screen is changed at this point to reflect movement and where you are on the grid.
 There are different text branches and rewards given to user depending on what class they choose and what stats they have.
 
 
 Each row of the grid has a combat scenario at the end which is done by attacking with the green button and blocking with the red button. To understand combat, scroll down to those button methods.
 
 Project 2:
 */


- (IBAction)investigate:(id)sender {
    
    self.viewLock = NO;
    
    [self.mainText flashScrollIndicators];  //flashes scroll indicators to let user know you can scroll
    [self.investigate play];
    if (self.mainChar.gridProgress == 0)    //SQUARE 1
    {
        self.gridPicture.image = [UIImage imageNamed:@"room1.png"];  //update picture, user avatar appears at first square.
        
        //text shown at first square after hitting investigate
        self.mainText.text = @"You've stepped into the cottage and see the stranger awaiting you.\n\n'Hello there. Turns out I coincidentally have a quest for you, should you choose to accept it. At the end of the strangely linear path of Yondolore, there lies King Bazul. Last year, the King acquired this region's most powerful artifact, The Yondolorian crown. Since then, people have been slowly corrupted in Yondolore and attacking others at random. Please trek through Yondolore to its end, destroy the evil king, and claim the crown to use it for good. \n\nClick the GREEN button to accept my quest, and I shall grant you an item to help your travels.'";
        
        self.mainChar.gridProgress = 1; //progress increases
        
        //repeat for other methods.
    }
    else if (self.mainChar.gridProgress == 3) //SQ 2
    {
        self.mainText.text= @"The troll looks up and speaks: \n\n'Before I let you pass, I will ask you question. What is the name of the evil king? Is it A: Bazul or B: Gannon? \n\n Click the GREEN button to answer A, RED button to answer B.";
        self.mainChar.gridProgress = 4;
    }
    else if (self.mainChar.gridProgress ==8)
    {
        self.mainText.text=@"Tired from your journey, you fall atop your bed and quickly drift off to sleep. 8 hours of sleeping like a baby later, you awake and continue to the Mystic Meadows. \n\n Hit RIGHT to move East and continue.";
        self.mainChar.gridProgress = 9;
       // [self saveItems]; ADD BACK IN FOR LOCAL STORAGE
        [self saveParse];
        
    }
    else if (self.mainChar.gridProgress == 10)
    {
        self.mainText.text=@"'I would like to challenge you to a race!' Goph says. 'If you've got high enough agility...you may just beat me.'\n\nPress GREEN button to challenge Goph.";
        self.mainChar.gridProgress = 11;
    }
    else if (self.mainChar.gridProgress == 15)
    {
        self.mainText.text=@"You take the wizard up on his offer.'Normally it would cost you, but you and me share a common enemy. Bazul murdered my family.' Stoic and silent after that, the wizard led you to a shoddy looking boat right by the river. It was no ordinary old boat though, it was embued with magic strong enough to break the spell. You got on the boat with the wizard and sailed East towards Bazul. \n\nPress RIGHT to continue, you're almost there.";
        self.mainChar.gridProgress = 16;
    
        //[self saveItems]; // scenario/square finished, saves before hitting right
        [self saveParse];
    }
    
}

- (IBAction)left:(id)sender {
    
    self.viewLock = NO;
    
    [self.mainText flashScrollIndicators];
    [self.walk play];
    
    if (self.mainChar.gridProgress == 0) //SQUARE 1
        
    {
        self.gridPicture.image = [UIImage imageNamed:@"room0.png"];
        self.mainText.text = @"You see a table covered in dust to your left with nothing on it. This cottage has been here for a long time.";
    }
    
    else if (self.mainChar.gridProgress == 3) //SQUARE 2
    {
        self.mainText.text= @"To the left of the bridge is just...well, water. Deep water. You could walk around, but the steep river seems to go on for miles.";
    }
    else if (self.mainChar.gridProgress == 8)
    {
        self.mainText.text = @"You see your bed adorned with silk, scarlet sheets to the left. You notice something underneath it...it's the Cloak of Daunting! You found an optional item!\n\nYou get + 5 to Agility. You also gain 50 exp for your discovery!\n\nTired from your journey, you fall atop your bed and quickly drift off to sleep. 8 hours of sleeping like a baby later, you awake and continue to the Mystic Meadows. Hit RIGHT to move East and continue.";
        self.daunting = YES;    //optional item required, will be added to items
        self.mainChar.agility += 5;     //stats increase from item
        self.mainChar.gridProgress = 9;
        self.mainChar.itemCount = 3;
        self.mainChar.exp += 25;
        
       // [self saveItems];  // scenario/square finished, saves before hitting right
        [self saveParse];
    }
    else if (self.mainChar.gridProgress == 10)
    {
        self.mainText.text=@"You wonder over to the left and see nothing. Wait...there's something at your feet, could it be the Stone of Tartarous!!?...Oh nevermind, it's just a rock.";
    }
    else if (self.mainChar.gridProgress == 15)
    {
        self.mainText.text=@"Nothing of a note to your left, just some young Mages playing Harry Potter.";
    }
}

- (IBAction)right:(id)sender {
    /* NSLog(@"Max Health: %d \n\n Strength: %d \n\n Intellect %d \n\n Agility %d",self.mainChar.health, self.mainChar.strength,self.mainChar.intellect, self.mainChar.agility); */
    
    self.viewLock = NO;
    
    [self.mainText flashScrollIndicators];
    [self.walk play];
    
    if (self.mainChar.gridProgress == 0) //SQUARE 1
    {
        self.gridPicture.image = [UIImage imageNamed:@"room0.png"];
        self.mainText.text = @"Strange idols and trinkets adorn the walls to your right. Weird.";
    }
    else if (self.mainChar.gridProgress == 2) //SQ 2
    {
        self.gridPicture.image = [UIImage imageNamed:@"room2.png"]; //the beginning of each square/scenario
        self.mainText.text = @"You come to a bridge guarded by a slimey troll. His face is stoic and body unmoving. \n\nLike before, hit INVESTIGATE to check him out, or LEFT or RIGHT to move around and inspect the area.";
        self.mainChar.gridProgress = 3;
        
    }
    else if (self.mainChar.gridProgress == 3)
    {
        
        self.mainText.text= @"You walk to the right of the bridge, the water looks surprisingly steep. No way you're getting across that.";
    }
    else if (self.mainChar.gridProgress == 5)
    {
        self.gridPicture.image = [UIImage imageNamed:@"room3.png"];
        self.mainText.text= @"After going across the bridge, you come across two bandits guarding gates. Before you have a chance to think, they engage you in combat.\n\nCombat has begun. Attack with the GREEN button, or block and heal with the RED button.\n\nPro tip: you can heal above your base health with the RED button just for kicks. Health resets to base health at the end of combat.";
        self.mainChar.gridProgress = 6;
    }
    
    else if (self.mainChar.gridProgress == 7)
    {
        self.gridPicture.image = [UIImage imageNamed:@"room4.png"];
        self.mainText.text= @"It turns out the bandits were ambushing Delphim city goers at the city gates. For defeating them, the city mayor offers you hospitality. Giving you little time to explore the city, he forces you into your free Inn room where you can get a much needed rest. \n\nUse RIGHT and LEFT to move and explore your room, INVESTIGATE when you wish to sleep and move on to the next day.";
        self.mainChar.gridProgress = 8;
    }
    else if (self.mainChar.gridProgress == 8)
    {
        self.mainText.text = @"To the right you see a candle alit atop a small table. Nothing unusual here, but you put the light out in preparation for shut eye.";
    }
    else if (self.mainChar.gridProgress == 9)
    {
        self.gridPicture.image = [UIImage imageNamed:@"room5.png"];
        self.mainText.text = @"You start walking through the Mystic Meadows. Not far in front of you, you spot Goph, the fabled spirit of the Meadows. He playfully waves you over. Hit INVESTIGATE to speak with Goph, or RIGHT or LEFT to move and explore the Meadows.";
        self.mainChar.gridProgress = 10;
    }
    else if (self.mainChar.gridProgress == 10)
    {
        self.mainText.text=@"You wonder over to the right. Nothing but tan fields lie before you, bristling in the wind.";
    }
    else if (self.mainChar.gridProgress ==12)
    {
        self.gridPicture.image = [UIImage imageNamed:@"room6.png"];
        self.mainText.text = @"As you continue East through the Meadows...a Dark Hooded Figure Approaches.'I am King Bazul's most adept servant. For coming on this quest...you shall pay! You quickly ready for combat. Press GREEN to attack and RED to heal and block.";
        self.mainChar.gridProgress = 13;
    }
    else if (self.mainChar.gridProgress ==14)
    {
        self.gridPicture.image = [UIImage imageNamed:@"room7.png"];
        self.mainText.text = @"You make your way down to Villandra. Mages have gathered here after hearing your good deeds across Yondolore. Bazul's lair is not much further to the West now, but lies across an enchanted river. The river is under a spell so that none may use it. If only an experienced Mage could break the spell, you could cross.\n\n'I can break the spell. Says a striking, powerful Wizard behind you, will telepathic abilities. Hit INVESTIGATE to take the wizard up on his offer, or RIGHT or LEFT to explore Villandra more.";
        self.mainChar.gridProgress = 15;
    }
    else if (self.mainChar.gridProgress == 15)
    {
        self.mainText.text=@"To your right you see an alley filled with trashed old spellbooks. What a shame.";
    }
    else if (self.mainChar.gridProgress == 16)
    {
        self.gridPicture.image = [UIImage imageNamed:@"room8.png"];
        self.mainText.text=@"You sail along the river with the powerful wizard, who is completely covered in a thick, blue, presumably magic cloak. 'Before you take on Bazul, I'll also offer you some power. I will only give you a lot if I can tell you are wise beyond your years. Let me bring my hand to your forehead to see your knowledge.'\n\nSomething feels off about it, but why not. Press GREEN to allow the Wizard to touch your forehead.";
        self.mainChar.gridProgress = 17;
    }
    else if (self.mainChar.gridProgress == 18)
    {
        self.gridPicture.image = [UIImage imageNamed:@"room9.png"];
        self.mainText.text=@"King Bazul, now 3 demonized copies of himself, laughs. 'JUST TRY AND TAKE THE CROWN FROM ME!'. The final batlle begins, you know what to do. Press GREEN button to attack, RED to block and heal.";
        self.mainChar.gridProgress = 19;
    }
    else if (self.mainChar.gridProgress == 20)
    {
        self.gridPicture.image = [UIImage imageNamed:@"end.png"];
        self.mainText.text=@"You pick up the crown. Use it for good? No, not this wretched artifact. No good will come of this. You throw the crown to the bottom of the nameless river, and slowly row your way back to civilization. You smile as you hope to see the fear wiped from Yondolorian faces. Your quest is over, your purpose furfilled.\n\nYou gain 85exp!\n\nCONGRATULATIONS! YOU HAVE BEATEN THE GAME!.\n\nThank you for playing!\n\nArena Unlocked. Click on RIGHT arrow for Info and to begin.";
        self.mainChar.gridProgress = 21;
        self.mainChar.exp +=85;
       // [self saveItems]; ADD BACK IN FOR LOCAL STORAGE
        [self saveParse];
    }
    else if (self.mainChar.gridProgress == 21)  //finished game
    {
        self.gridPicture.image = [UIImage imageNamed:@"end.png"];
        self.mainText.text=@"You've completed the game! Exit out and start a New Game if wish to play again. OR click the RIGHT button again to fight in endless battles at the arena! You will level and rank up while your enemies get stronger. Stats will save after every battle finishes.";
        self.mainChar.gridProgress = 22;
    }
    else if (self.mainChar.gridProgress == 22)  //finished game
    {
        self.gridPicture.image = [UIImage imageNamed:@"arena.png"];
        self.mainText.text=@"WELCOME CHAMPION, TO THE ARENA! PRESS GREEN OR RED BUTTONS TO BEGIN FIGHTING.";
        self.mainChar.gridProgress = 23;
    }
    
    
    
}

- (IBAction)green:(id)sender {
    
    self.viewLock = NO;
    
    [self.mainText flashScrollIndicators];
    
    [self.attack play];
    
    if (self.mainChar.gridProgress == 1) {  //SQ 1
        self.mainText.text = @"'Excellent! Take this Necklace of Valor, and I bid you farewell. Good luck hero! Remember to check out the STATUS screen and the included 'About' text file if you're confused.'\n\nYou gain the Necklace of Valor! +3 to Agility, Strength and Intellect. +10 to Health.\n\nYou gain 25exp!\n\nYou exit the room, and close the door to the cottage.\n\nClick the RIGHT button to carry on west to your quest.";
        self.mainChar.agility +=3;  //stats update for getting item as described avoe
        self.mainChar.strength +=3;
        self.mainChar.intellect +=3;
        self.mainChar.health+=10;
        self.mainChar.itemCount = 1;
        self.mainChar.exp +=25;
        
        self.mainChar.gridProgress = 2;
        
       // [self saveItems]; ADD BACK IN FOR LOCAL STORAGE
        [self saveParse];
        
        // self.buttonProg = 2;
    }
    else if(self.mainChar.gridProgress == 4)  //SQ 2
    {
        self.mainText.text = @"Correct! Have a delicious stat bonus, hero. Carry on.\n\nYou gain +5 to Intellect!\n\nYou gain 15 exp!\n\nPress RIGHT to push on.";
        self.mainChar.gridProgress = 5;
        self.mainChar.intellect +=5;
        self.mainChar.exp +=15;
        
       // [self saveItems];
        [self saveParse];
        // self.buttonProg =5;
    }
    
    /*
     Combat code, attacking: These are run if user is attacking with the green button.
     */
    
    else if(self.mainChar.gridProgress == 6) //FIRST BATTLE
    {
        int enemy_attack = 15 + arc4random_uniform(4); //enemy attack value
        int attack = 0;   //your attack value
        int r = arc4random_uniform(5);  //your randomizer
        
        attack = self.mainChar.strength + r;    //add randomizer and your strength for calculation
        
        int newHealth = self.tempHealth - enemy_attack;  //health deducted for you
        self.enemy1_health = self.enemy1_health - attack;  //health deducted for enemy
        
        if (self.tempHealth > 0 && self.enemy1_health > 0) {  //if no one has died yet
            self.mainText.text = [NSString stringWithFormat: @"Your Current Health: %d\n\nYou attack first for %d damage.\n\nEnemy swings back for %d damage.\n\nYour resulting health is %d\n\nClick GREEN to attack again, or RED to block and heal.",self.tempHealth,attack,enemy_attack, newHealth];
            self.tempHealth = newHealth;  //stores newly deducted health
            self.mainChar.attacks += 1;
        }
        else if (self.tempHealth <= 0) //if you die
        {
            self.mainText.text = @"You took fatal damage from the enemy on the last attack. You have died! Click GREEN button to attack and try again. You will be reborn with extra health for replaying the battle.";
            self.tempHealth = self.mainChar.health + 20; //health increase
            self.enemy1_health = 70; //reset enemy health. had these lower for grading so if they died they could quickly get through the combat again. bumped them up again for fun. (combat is still easy as pie though)
            self.mainChar.deaths += 1;
        }
        else if (self.enemy1_health <= 0) //IF ENEMY DIES
        {
            self.mainText.text = @"You destroy the bandits with a final attack. You find an item amongst their corpses, Chainmail of Martyrs.\n\nYou gain +15 Health from the chainmail, and +8 to Strength!\n\nYou gain 40 exp!\n\nPress the RIGHT arrow button to continue through the gates on your quest.";
            self.mainChar.health += 15;
            self.mainChar.strength += 8;    //You win, gain item and stat additions
            self.mainChar.itemCount = 2;
            self.mainChar.gridProgress = 7;  //grid Progress increases so combat ends
            self.tempHealth = self.mainChar.health;
            self.enemy1_health = 70;        //reset health values
            self.mainChar.exp +=25;
            self.mainChar.battles += 1;
            
           // [self saveItems]; 
            [self saveParse];
            //works the same way for the other battles.
        }
        
    } //end first battle
    else if (self.mainChar.gridProgress == 11)
    {
        if (self.mainChar.agility > 17) {
            self.mainText.text = @"You accept Goph's challenge...and swiftly pass him winning the race!. 'Phew. You really are fast. I grant you stat bonuses!\n\nYou gain +5 Health, +3 Strength, and +3 Intellect\n\nYou gain 25exp!\n\nBefore you continue on your quest, Goph warns you of an evil ahead in the Meadows. \n\nPress RIGHT to continue through the Meadows.";
            self.mainChar.health += 5;
            self.mainChar.strength += 3;
            self.mainChar.intellect +=3;
            self.mainChar.gridProgress = 12;
            self.mainChar.exp +=25;
            
          //
          //  [self saveItems];
            [self saveParse];
        }
        else
        {
            self.mainText.text = @"You accept Goph's challenge...and he easily passes you by. 'Nice try', he says. 'Here's some pity health and exp.'\n\nYou gain +4 Health and 10exp.\n\nBefore you continue on your quest, Goph warns you of an evil ahead in the Meadows. \n\nPress RIGHT to continue through the Meadows.";
            self.mainChar.health += 4;
            self.mainChar.gridProgress = 12;
            self.mainChar.exp +=10;
            
           // [self saveItems];
            [self saveParse];
        }
    }
    
    else if(self.mainChar.gridProgress == 13)    //SECOND BATTLE
    {
        int enemy_attack = 20 + arc4random_uniform(4);
        int attack = 0;
        int r = arc4random_uniform(5);
        // NSLog(@"Strength during combat: %d",self.mainChar.strength);
        attack = self.mainChar.strength + r;
        
        int newHealth = self.tempHealth - enemy_attack;
        self.enemy2_health = self.enemy2_health - attack;
        
        if (self.tempHealth > 0 && self.enemy2_health > 0) {  //ATTACK CODE HERE
            self.mainText.text = [NSString stringWithFormat: @"Your Current Health: %d\n\nYou attack first for %d damage.\n\nEnemy swings back for %d damage.\n\nYour resulting health is %d\n\nClick GREEN to attack again, or RED to block and heal.",self.tempHealth,attack,enemy_attack, newHealth];
            self.tempHealth = newHealth;
            self.mainChar.attacks += 1;
        }
        else if (self.tempHealth <= 0)
        {
            self.mainText.text = @"You took fatal damage from the enemy on the last attack. You have died! Click GREEN button to attack and try again. You will be reborn with extra health for replaying the battle.";
            self.tempHealth = self.mainChar.health + 20;
            self.enemy2_health = 120;
            self.mainChar.deaths += 1;
        }
        else if (self.enemy2_health <= 0)
        {
            self.mainText.text = @"You destroy the King's evil servant with a final attack. You find an item in his bloodied black garb, Ring of Dardos.\n\nYou gain +20 Health from the ring, and +10 to Strength!\n\nYou gain 60exp!\n\nPress the right button to move South to the Mage town of Villandra. You are fully healed.";
            self.mainChar.health += 20;
            self.mainChar.strength += 10;
            if (self.daunting == YES)
                self.mainChar.itemCount = 5;
            else
                self.mainChar.itemCount = 4;
            self.mainChar.gridProgress = 14;
            self.tempHealth = self.mainChar.health;
            self.enemy2_health = 120;
            self.mainChar.exp +=60;
            self.mainChar.battles += 1;
            
           // [self saveItems];
            [self saveParse];
        }
        
    } //end second battle
    
    
    else if (self.mainChar.gridProgress == 17)
    {
        if (self.mainChar.intellect > 17) {
            self.mainText.text = @"The wizard puts his hand to your forehead, but your high intellect detects a magical attack incoming. You strike at wizard dealing an early 10 damage to him. The wizard dematerializes into 3, devilish copies of himself, one of which is wearing the Yondolorian crown. Before you lies King Bazul, terror of Yondolore.\n\nPress RIGHT and begin the final battle.";
            self.mainChar.gridProgress = 18;
            self.enemy3_health -= 10;
            
            //[self saveItems];
            [self saveParse];
        }
        else
        {
            self.mainText.text = @"The wizard puts his hand to your forehead, and shoots a magical attack to your forehead. Perhaps with higher intellect you could've seen it coming, but luckily it was a glancing blow and you only lose 5 health. The wizard dematerializes into 3, devilish copies of himself, one of which is wearing the Yondolorian crown. Before you lies King Bazul, terror of Yondolore.\n\nPress RIGHT and begin the final battle.";
            self.mainChar.health -= 5;
            self.mainChar.gridProgress = 18;
            
            //[self saveItems];
            [self saveParse];
        }
    }
    
    //start FINAL BATTLE
    
    
    else if(self.mainChar.gridProgress == 19)    //THIRD BATTLE
    {
        int enemy_attack = 25 + arc4random_uniform(4);
        int attack = 0;
        int r = arc4random_uniform(15);
        //NSLog(@"Strength during combat: %d",self.mainChar.strength);
        attack = self.mainChar.strength + r;
        
        int newHealth = self.tempHealth - enemy_attack;
        self.enemy3_health = self.enemy3_health - attack;
        
        if (self.tempHealth > 0 && self.enemy3_health > 0) {  //ATTACK CODE HERE
            self.mainText.text = [NSString stringWithFormat: @"Your Current Health: %d\n\nYou attack first for %d damage.\n\nEnemy swings back for %d damage.\n\nYour resulting health is %d\n\nClick GREEN to attack again, or RED to block and heal.",self.tempHealth,attack,enemy_attack, newHealth];
            self.tempHealth = newHealth;
            self.mainChar.attacks += 1;
        }
        else if (self.tempHealth <= 0)
        {
            self.mainText.text = @"You took fatal damage from the enemy on the last attack. You have died! Click GREEN button to attack and try again. You will be reborn with extra health for replaying the battle.";
            self.tempHealth = self.mainChar.health + 20;
            self.enemy3_health = 180;
            self.mainChar.deaths += 1;
        }
        else if (self.enemy3_health <= 0)
        {
            self.mainText.text = @"King Bazul's 3 forms collapse and form into Bazul himself. He bursts into ash, no last words, no final forms. Just a swift death. His crown drops to the ground.\n\nPress RIGHT arrow to pick up the crown...";
            self.mainChar.gridProgress = 20;
            self.tempHealth = self.mainChar.health;
            self.enemy3_health = 180;
            self.mainChar.battles += 1;
        }
        
    } //end FINAL BATTLE
    
    else if(self.mainChar.gridProgress == 23)    //ARENA
    {
        self.gridPicture.image = [UIImage imageNamed:@"arena.png"];
        int enemy_attack = 30 + arc4random_uniform(self.mainChar.rank * 3); //difficulty increase
        int attack = 0;
        int r = arc4random_uniform(15);
        //NSLog(@"Strength during combat: %d",self.mainChar.strength);
        attack = self.mainChar.strength + r;
        
        int newHealth = self.tempHealth - enemy_attack;
        self.enemy3_health += arc4random_uniform(self.mainChar.rank * 5);   //difficulty increase
        self.enemy3_health = self.enemy3_health - attack;
        
        if (self.tempHealth > 0 && self.enemy3_health > 0) {  //ATTACK CODE HERE
            self.mainText.text = [NSString stringWithFormat: @"Your Current Health: %d\n\nYou attack first for %d damage.\n\nEnemy swings back for %d damage.\n\nYour resulting health is %d\n\nClick GREEN to attack again, or RED to block and heal.",self.tempHealth,attack,enemy_attack, newHealth];
            self.tempHealth = newHealth;
            self.mainChar.attacks +=1;
        }
        else if (self.tempHealth <= 0)
        {
            self.mainText.text = @"You took fatal damage from the enemy on the last attack. You have died! Click GREEN button to attack and try again. You will be reborn with extra health for replaying the battle.";
            self.tempHealth = self.mainChar.health + 20;
            self.enemy3_health = 180;
            self.mainChar.deaths +=1;
        }
        else if (self.enemy3_health <= 0)
        {
            self.mainText.text = @"You strike down the enemy. You've gained 1 rank and 50exp!\n\nYou've gained 10 strength and 10 health!\n\n Press GREEN or RED buttons to fight a new enemy.";
            self.mainChar.gridProgress = 23;
            self.tempHealth = self.mainChar.health;
            self.enemy3_health = 180;
            
            self.mainChar.battles +=1;
            self.mainChar.rank +=1;
            self.mainChar.exp +=50;
            self.mainChar.strength +=10;
            self.mainChar.health +=10;
            
            [self saveParse];
        }
        
    } //end FINAL BATTLE
    
    
}


- (IBAction)red:(id)sender {
    
    self.viewLock = NO;
    [self.mainText flashScrollIndicators];
    
    [self.block play];
    
    if (self.mainChar.gridProgress == 1) {  //SQ 1
        self.mainText.text = @"'Very well then. But you'll have to start eventually.'";
    }
    
    else if(self.mainChar.gridProgress == 4)  //SQ 2
    {
        self.mainText.text = @"Wrong. Gannon is name from a different place. You may pass, but you shall lose wisdom for this.\n\n You lose 3 Intellect\n\nPress RIGHT to push on.";
        self.mainChar.intellect -=3;
        self.mainChar.gridProgress = 5;
        
       // [self saveItems];
        [self saveParse];
        // self.buttonProg =5;
    }
    
    /*
     Combat code, blocking: These are run if user is blocking and healing with red button. What I made
     interesting about blocking is that you or the enemy can bleed out from previous attack and die while you block.
     This is reflected in the text, and is why theres if statements for death conditions.
     */
    
    else if (self.mainChar.gridProgress == 6) {
        int healHealth = arc4random_uniform(15);     //heal small random amount
        int newHealth = self.tempHealth + healHealth;  //get new health with heal bonus
        
        if (self.tempHealth > 0 && self.enemy1_health > 0) {   //if you or enemy are alive, continue combat
            self.mainText.text = [NSString stringWithFormat: @"Your Current Health: %d\n\nYou block the enemy's strike and heal up %d health.\n\nYour resulting health is %d\n\nClick GREEN to attack, or RED to block and heal.",self.tempHealth,healHealth,newHealth];
            self.tempHealth = newHealth;  //new health
            
            self.mainChar.blocks+=1;
        }
        else if (self.tempHealth <= 0)   //if you die
        {
            self.mainText.text = @"You tried to block, but your wounds from the previous attack were too much to bear. You have died! Click GREEN button to attack or RED to block and try again. You will be reborn with extra health for replaying the battle.";
            self.tempHealth = self.mainChar.health + 20; //gain health for retry
            self.enemy1_health = 70;
            
            self.mainChar.blocks +=1;
            //reset enemy health. had these lower for grading so if they died they could quickly get through the combat again. bumped them up again for fun. (combat is still easy as pie though)
        }
        else if (self.enemy1_health <= 0) //IF ENEMY DIES
        {
            self.mainText.text = @"As you, block the bandits bleed out from wounds from the previous attack. You find an item amongst their corpses, Chainmail of Martyrs.\n\nYou gain +15 Health from the chainmail, and +8 to Strength!\n\n You gain 40exp!\n\nPress the RIGHT button to continue through the gates on your quest. All your wounds from combat are healed.";
            self.mainChar.health += 15;  //gain stats from item
            self.mainChar.strength += 8;
            self.mainChar.itemCount = 2;
            self.mainChar.gridProgress = 7;  //continue progress
            self.tempHealth = self.mainChar.health;  //reset health
            self.enemy1_health = 70;
            self.mainChar.exp +=40;
            
            self.mainChar.battles +=1;
            
            //[self saveItems]; //save before hitting right
            [self saveParse];
        }
        
    } //end first battle
    else if (self.mainChar.gridProgress == 11)
    {
        
        self.mainText.text = @"'Aw come on, race me'!";
        
    }
    
    
    else if (self.mainChar.gridProgress == 13) {      //BATTLE BLOCK CODE 2
        int healHealth = arc4random_uniform(15);
        int newHealth = self.tempHealth + healHealth;
        
        if (self.tempHealth > 0 && self.enemy2_health > 0) {
            self.mainText.text = [NSString stringWithFormat: @"Your Current Health: %d\n\nYou block the enemy's strike and heal up %d health.\n\nYour resulting health is %d\n\nClick GREEN to attack, or RED to block and heal.",self.tempHealth,healHealth,newHealth];
            self.tempHealth = newHealth;
            self.mainChar.blocks+=1;
        }
        else if (self.tempHealth <= 0)
        {
            self.mainText.text = @"You tried to block, but your wounds from the previous attack were too much to bear. You have died! Click GREEN button to attack or RED to block and try again. You will be reborn with extra health for replaying the battle.";
            self.tempHealth = self.mainChar.health + 20;
            self.enemy2_health = 120;
            self.mainChar.deaths+=1;
        }
        else if (self.enemy2_health <= 0)
        {
            self.mainText.text = @"Weary from battle, the King's servant collapses as you hold up your guard, and dies. You find an item in his bloodied black garb, Ring of Dardos.\n\nYou gain +20 Health from the ring, and +10 to Strength!\n\nYou gain 60exp!\n\nPress the right button to move South to the Mage town of Villandra. You are fully healed.";
            self.mainChar.health += 20;
            self.mainChar.strength += 10;
            if (self.daunting == YES)
                self.mainChar.itemCount = 5;
            else
                self.mainChar.itemCount = 4;
            
            self.mainChar.gridProgress = 14;
            
            self.tempHealth = self.mainChar.health;
            self.enemy2_health = 120;
            self.mainChar.exp += 60;
            self.mainChar.battles+=1;
            
            //[self saveItems];
            [self saveParse];
            
        }
        
    } //end second battle
    else if (self.mainChar.gridProgress == 17)
    {
        self.mainText.text = @"You try to resist his hand, but an unknown force dosen't let you.";
    }
    
    
    //FINAL BATTLE
    
    else if (self.mainChar.gridProgress == 19) {      //BATTLE BLOCK CODE 3
        int healHealth = arc4random_uniform(20);
        int newHealth = self.tempHealth + healHealth;
        
        if (self.tempHealth > 0 && self.enemy3_health > 0) {
            self.mainText.text = [NSString stringWithFormat: @"Your Current Health: %d\n\nYou block the enemy's strike and heal up %d health.\n\nYour resulting health is %d\n\nClick GREEN to attack, or RED to block and heal.",self.tempHealth,healHealth,newHealth];
            self.tempHealth = newHealth;
            self.mainChar.blocks+=1;
        }
        else if (self.tempHealth <= 0)
        {
            self.mainText.text = @"You tried to block, but your wounds from the previous attack were too much to bear. You have died! Click GREEN button to attack or RED to block and try again. You will be reborn with extra health for replaying the battle.";
            self.tempHealth = self.mainChar.health + 20;
            self.enemy3_health = 180;
            self.mainChar.deaths+=1;
        }
        else if (self.enemy3_health <= 0)
        {
            self.mainText.text = @"King Bazul's 3 forms collapse and form into Bazul himself. He bursts into ash, no last words, no final forms. Just a swift death. His crown drops to the ground. \n\nPress RIGHT arrow to pick up the crown...";
            self.mainChar.gridProgress = 20;
            self.tempHealth = self.mainChar.health;
            self.enemy3_health = 180;
            self.mainChar.battles+=1;
            
        }
        
    } //end last battle
    
    else if (self.mainChar.gridProgress == 23) {      //ARENA
        
        self.gridPicture.image = [UIImage imageNamed:@"arena.png"];
        int healHealth = arc4random_uniform(20);
        int newHealth = self.tempHealth + healHealth;
        
        self.enemy3_health += arc4random_uniform(self.mainChar.rank * 5);
        
        if (self.tempHealth > 0 && self.enemy3_health > 0) {
            self.mainText.text = [NSString stringWithFormat: @"Your Current Health: %d\n\nYou block the enemy's strike and heal up %d health.\n\nYour resulting health is %d\n\nClick GREEN to attack, or RED to block and heal.",self.tempHealth,healHealth,newHealth];
            self.tempHealth = newHealth;
            self.mainChar.blocks+=1;
        }
        else if (self.tempHealth <= 0)
        {
            self.mainText.text = @"You tried to block, but your wounds from the previous attack were too much to bear. You have died! Click GREEN button to attack or RED to block and try again. You will be reborn with extra health for replaying the battle.";
            self.tempHealth = self.mainChar.health + 20;
            self.enemy3_health = 180;
            self.mainChar.deaths+=1;
        }
        else if (self.enemy3_health <= 0)
        {
            self.mainText.text = @"You strike down the enemy. You've gained 1 rank and 50exp!\n\nYou've gained 10 strength and 10 health!\n\n Press GREEN or RED buttons to fight a new enemy.";
            self.mainChar.gridProgress = 23;
            self.tempHealth = self.mainChar.health;
            self.enemy3_health = 180;
            
            self.mainChar.battles +=1;
            self.mainChar.rank +=1;
            self.mainChar.exp +=50;
            self.mainChar.strength +=10;
            self.mainChar.health +=10;
            
            [self saveParse];
            
        }
        
    } //end last battle
    
    
    
}

- (IBAction)mapSwitch:(id)sender {
    
    if (self.viewLock == NO)
    {
    if (self.mainChar.gridProgress == 0) //SQUARE 1
    {
        if (self.viewSwitch == 0) //map
        {
            NSLog(@"View switch = 0 on map");
            UIImage * button = [UIImage imageNamed:@"room0.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"Grid1.png"];
            
            self.viewSwitch  = 1;
        }
        
        else if (self.viewSwitch == 1) //area/room
        {
            NSLog(@"View switch = 1, on room");
            UIImage * button = [UIImage imageNamed:@"Grid1.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"room0.png"];
            
            self.viewSwitch  = 0;
        }
        
    }
    else if (self.mainChar.gridProgress == 1) //SQ 2
    {
        if (self.viewSwitch == 0) //map
        {
            UIImage * button = [UIImage imageNamed:@"room1.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"Grid1.png"];
            
            self.viewSwitch  = 1;
        }
        
        else if (self.viewSwitch == 1) //area/room
        {
            UIImage * button = [UIImage imageNamed:@"Grid1.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"room1.png"];
            
            self.viewSwitch  = 0;
        }
        
    }
    else if (self.mainChar.gridProgress == 2 || self.mainChar.gridProgress == 3 || self.mainChar.gridProgress == 4) //SQ 2
    {
        if (self.viewSwitch == 0) //map
        {
            UIImage * button = [UIImage imageNamed:@"room2.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"Grid2.png"];
            
            self.viewSwitch  = 1;
        }
        
        else if (self.viewSwitch == 1) //area/room
        {
            UIImage * button = [UIImage imageNamed:@"Grid2.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"room2.png"];
            
            self.viewSwitch  = 0;
        }
        
    }
    else if (self.mainChar.gridProgress == 5 || self.mainChar.gridProgress == 6) //SQ 2
    {
        if (self.viewSwitch == 0) //map
        {
            UIImage * button = [UIImage imageNamed:@"room3.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"Grid3.png"];
            
            self.viewSwitch  = 1;
        }
        
        else if (self.viewSwitch == 1) //area/room
        {
            UIImage * button = [UIImage imageNamed:@"Grid3.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"room3.png"];
            
            self.viewSwitch  = 0;
        }
        
    }
    else if (self.mainChar.gridProgress == 7 || self.mainChar.gridProgress == 8) //SQ 2
    {
        if (self.viewSwitch == 0) //map
        {
            UIImage * button = [UIImage imageNamed:@"room4.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"Grid4.png"];
            
            self.viewSwitch  = 1;
        }
        
        else if (self.viewSwitch == 1) //area/room
        {
            UIImage * button = [UIImage imageNamed:@"Grid4.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"room4.png"];
            
            self.viewSwitch  = 0;
        }
        
    }
    else if (self.mainChar.gridProgress == 9 || self.mainChar.gridProgress == 10 || self.mainChar.gridProgress == 11) //SQ 2
    {
        if (self.viewSwitch == 0) //map
        {
            UIImage * button = [UIImage imageNamed:@"room5.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"Grid5.png"];
            
            self.viewSwitch  = 1;
        }
        
        else if (self.viewSwitch == 1) //area/room
        {
            UIImage * button = [UIImage imageNamed:@"Grid5.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"room5.png"];
            
            self.viewSwitch  = 0;
        }
        
    }
    else if (self.mainChar.gridProgress == 12|| self.mainChar.gridProgress == 13) //SQ 2
    {
        if (self.viewSwitch == 0) //map
        {
            UIImage * button = [UIImage imageNamed:@"room6.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"Grid6.png"];
            
            self.viewSwitch  = 1;
        }
        
        else if (self.viewSwitch == 1) //area/room
        {
            UIImage * button = [UIImage imageNamed:@"Grid6.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"room6.png"];
            
            self.viewSwitch  = 0;
        }
        
    }
    else if (self.mainChar.gridProgress == 14|| self.mainChar.gridProgress == 15) //SQ 2
    {
        if (self.viewSwitch == 0) //map
        {
            UIImage * button = [UIImage imageNamed:@"room7.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"Grid7.png"];
            
            self.viewSwitch  = 1;
        }
        
        else if (self.viewSwitch == 1) //area/room
        {
            UIImage * button = [UIImage imageNamed:@"Grid7.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"room7.png"];
            
            self.viewSwitch  = 0;
        }
        
    }
    
    else if (self.mainChar.gridProgress == 16 || self.mainChar.gridProgress == 17) //SQ 2
    {
        if (self.viewSwitch == 0) //map
        {
            UIImage * button = [UIImage imageNamed:@"room8.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"Grid8.png"];
            
            self.viewSwitch  = 1;
        }
        
        else if (self.viewSwitch == 1) //area/room
        {
            UIImage * button = [UIImage imageNamed:@"Grid8.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"room8.png"];
            
            self.viewSwitch  = 0;
        }
        
    }
    
    else if (self.mainChar.gridProgress == 18 || self.mainChar.gridProgress == 19) //SQ 2
    {
        if (self.viewSwitch == 0) //map
        {
            UIImage * button = [UIImage imageNamed:@"room9.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"Grid9.png"];
            
            self.viewSwitch  = 1;
        }
        
        else if (self.viewSwitch == 1) //area/room
        {
            UIImage * button = [UIImage imageNamed:@"Grid9.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"room9.png"];
            
            self.viewSwitch  = 0;
        }
        
    }
    
    else if (self.mainChar.gridProgress == 20 || self.mainChar.gridProgress == 21) //SQ 2
    {
        if (self.viewSwitch == 0) //map
        {
            UIImage * button = [UIImage imageNamed:@"end.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"Grid10.png"];
            
            self.viewSwitch  = 1;
        }
        
        else if (self.viewSwitch == 1) //area/room
        {
            UIImage * button = [UIImage imageNamed:@"Grid10.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"end.png"];
            
            self.viewSwitch  = 0;
        }
        
    }
    else
    {
        if (self.viewSwitch == 0) //map
        {
            UIImage * button = [UIImage imageNamed:@"arena.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"Grid10.png"];
            
            self.viewSwitch  = 1;
        }
        
        else if (self.viewSwitch == 1) //area/room
        {
            UIImage * button = [UIImage imageNamed:@"Grid10.png"];
            [self.switcher setImage:button forState:UIControlStateNormal];
            
            self.gridPicture.image = [UIImage imageNamed:@"arena.png"];
            
            self.viewSwitch  = 0;
        }

    }
    }

}
@end
