//
//  MainScreen.m
//  Project1
//
// Main screen of the game. View about file if need more info.
// I have explained everything through playing the game.

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


@property BOOL daunting;
@property int buttonProg;

@property int enemy1_health;
@property int enemy2_health;
@property int enemy3_health;
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
    //Character *persistantChar = [[Character alloc] init];
    [super viewDidLoad];
    [self loadItems];
    
    
    self.enemy1_health = 70;
    self.enemy2_health = 120;
    self.enemy3_health = 180;

    
    self.tempHealth = self.mainChar.health;
    
    self.mainText.text = @"Welcome to the main view of the grid/map. Press INVESTIGATE to begin the event, LEFT or RIGHT arrows to move and explore the area.\n\n Or If you're continuing from a previous adventure, press the RIGHT arrow to start right after where you left off. The game will auto save after each square/scenario beaten. \n\nYou will be represented by a purple avatar on the grid when you start.";

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
    
    Character *persistantChar = [[Character alloc] init];
    
    
    persistantChar.charName = self.mainChar.charName;
    persistantChar.charType = self.mainChar.charType;
    persistantChar.gridProgress= self.mainChar.gridProgress;
    persistantChar.health = self.mainChar.health;
    persistantChar.strength = self.mainChar.strength;
    persistantChar.agility = self.mainChar.agility;
    persistantChar.intellect = self.mainChar.intellect;
    persistantChar.itemCount = self.mainChar.itemCount;
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:persistantChar forKey:@"dataChar"];   //saves our objects to file.
    
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    
}

- (void)loadItems
{
    // get our data file path
    NSString *path = [self dataFilePath];
    
    //do we have anything in our documents directory?  If we have anything then load it up
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        Character *persistantChar = [[Character alloc] init];
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        persistantChar = [unarchiver decodeObjectForKey:@"dataChar"];
        [unarchiver finishDecoding];
        
                NSLog(@"Contents: %@",[persistantChar description]);
        
        self.mainChar.charName = persistantChar.charName;
        self.mainChar.charType = persistantChar.charType;
        self.mainChar.gridProgress = persistantChar.gridProgress;
        self.mainChar.health = persistantChar.health;
        self.mainChar.strength = persistantChar.strength;
        self.mainChar.agility = persistantChar.agility;
        self.mainChar.intellect = persistantChar.intellect;
        self.mainChar.itemCount = persistantChar.itemCount;
        
    }
}






- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Status *dest = segue.destinationViewController;
    
    dest.tableChar = self.mainChar;
}


- (IBAction)statusButton:(id)sender {
}

- (IBAction)investigate:(id)sender {
    
    [self.mainText flashScrollIndicators];
    
    if (self.mainChar.gridProgress == 0)    //SQUARE 1
    {
        self.gridPicture.image = [UIImage imageNamed:@"Grid1.png"];
        
        //self.buttonProg = 0;
        self.mainText.text = @"You've stepped into the cottage and see the stranger awaiting you.\n\n'Hello there. Turns out I coincidentally have a quest for you, should you choose to accept it. At the end of the strangely linear path of Yondolore, there lies King Bazul. Last year, the King acquired this region's most powerful artifact, The Yondolorian crown. Since then, people have been slowly corrupted in Yondolore and attacking others at random. Please trek through Yondolore to its end, destroy the evil king, and claim the crown to use it for good. \n\nClick the GREEN button to accept my quest, and I shall grant you an item to help your travels.'";
        //self.buttonProg = 1;
        self.mainChar.gridProgress = 1;
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
          [self saveItems];

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
          [self saveItems];
    }
    
}

- (IBAction)left:(id)sender {
    
        [self.mainText flashScrollIndicators];
    
    if (self.mainChar.gridProgress == 0) //SQUARE 1
    {
        self.gridPicture.image = [UIImage imageNamed:@"Grid1.png"];
        self.mainText.text = @"You see a table covered in dust to your left with nothing on it. This cottage has been here for a long time.";
    }

    else if (self.mainChar.gridProgress == 3) //SQUARE 2
    {
        self.mainText.text= @"To the left of the bridge is just...well, water. Deep water. You could walk around, but the steep river seems to go on for miles.";
    }
    else if (self.mainChar.gridProgress == 8)
    {
        self.mainText.text = @"You see your bed adorned with silk, scarlet sheets to the left. You notice something underneath it...it's the Cloak of Daunting! You found an optional item!\n\nYou get + 5 to Agility.\n\nTired from your journey, you fall atop your bed and quickly drift off to sleep. 8 hours of sleeping like a baby later, you awake and continue to the Mystic Meadows. Hit RIGHT to move East and continue.";
        self.daunting = YES;
        self.mainChar.agility += 5;
        self.mainChar.gridProgress = 9;
        self.mainChar.itemCount = 3;
        
        [self saveItems];
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
    
        [self.mainText flashScrollIndicators];
    
    
    if (self.mainChar.gridProgress == 0) //SQUARE 1
    {
        self.gridPicture.image = [UIImage imageNamed:@"Grid1.png"];
        self.mainText.text = @"Strange idols and trinkets adorn the walls to your right. Weird.";
    }
    else if (self.mainChar.gridProgress == 2) //SQ 2
    {
        self.gridPicture.image = [UIImage imageNamed:@"Grid2.png"];
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
        self.gridPicture.image = [UIImage imageNamed:@"Grid3.png"];
        self.mainText.text= @"After going across the bridge, you come across two bandits guarding gates. Before you have a chance to think, they engage you in combat.\n\nCombat has begun. Attack with the GREEN button, or block and heal with the RED button.\n\nPro tip: you can heal above your base health with the RED button just for kicks. Health resets to base health at the end of combat.";
        self.mainChar.gridProgress = 6;
    }
    
    else if (self.mainChar.gridProgress == 7)
    {
        self.gridPicture.image = [UIImage imageNamed:@"Grid4.png"];
        self.mainText.text= @"It turns out the bandits were ambushing Delphim city goers at the city gates. For defeating them, the city mayor offers you hospitality. Giving you little time to explore the city, he forces you into your free Inn room where you can get a much needed rest. \n\nUse RIGHT and LEFT to move and explore your room, INVESTIGATE when you wish to sleep and move on to the next day.";
        self.mainChar.gridProgress = 8;
    }
    else if (self.mainChar.gridProgress == 8)
    {
        self.mainText.text = @"To the right you see a candle alit atop a small table. Nothing unusual here, but you put the light out in preparation for shut eye.";
    }
    else if (self.mainChar.gridProgress == 9)
    {
        self.gridPicture.image = [UIImage imageNamed:@"Grid5.png"];
       self.mainText.text = @"You start walking through the Mystic Meadows. Not far in front of you, you spot Goph, the fabled spirit of the Meadows. He playfully waves you over. Hit INVESTIGATE to speak with Goph, or RIGHT or LEFT to move and explore the Meadows.";
        self.mainChar.gridProgress = 10;
    }
    else if (self.mainChar.gridProgress == 10)
    {
        self.mainText.text=@"You wonder over to the right. Nothing but tan fields lie before you, bristling in the wind.";
    }
    else if (self.mainChar.gridProgress ==12)
    {
        self.gridPicture.image = [UIImage imageNamed:@"Grid6.png"];
        self.mainText.text = @"As you continue East through the Meadows...a Dark Hooded Figure Approaches.'I am King Bazul's most adept servant. For coming on this quest...you shall pay! You quickly ready for combat. Press GREEN to attack and RED to heal and block.";
        self.mainChar.gridProgress = 13;
    }
    else if (self.mainChar.gridProgress ==14)
    {
        self.gridPicture.image = [UIImage imageNamed:@"Grid7.png"];
        self.mainText.text = @"You make your way down to Villandra. Mages have gathered here after hearing your good deeds across Yondolore. Bazul's lair is not much further to the West now, but lies across an enchanted river. The river is under a spell so that none may use it. If only an experienced Mage could break the spell, you could cross.\n\n'I can break the spell. Says a striking, powerful Wizard behind you, will telepathic abilities. Hit INVESTIGATE to take the wizard up on his offer, or RIGHT or LEFT to explore Villandra more.";
        self.mainChar.gridProgress = 15;
    }
    else if (self.mainChar.gridProgress == 15)
    {
        self.mainText.text=@"To your right you see an alley filled with trashed old spellbooks. What a shame.";
    }
    else if (self.mainChar.gridProgress == 16)
    {
        self.gridPicture.image = [UIImage imageNamed:@"Grid8.png"];
        self.mainText.text=@"You sail along the river with the powerful wizard, who is completely covered in a thick, blue, presumably magic cloak. 'Before you take on Bazul, I'll also offer you some power. I will only give you a lot if I can tell you are wise beyond your years. Let me bring my hand to your forehead to see your knowledge.'\n\nSomething feels off about it, but why not. Press GREEN to allow the Wizard to touch your forehead.";
        self.mainChar.gridProgress = 17;
    }
    else if (self.mainChar.gridProgress == 18)
    {
        self.gridPicture.image = [UIImage imageNamed:@"Grid9.png"];
        self.mainText.text=@"King Bazul, now 3 demonized copies of himself, laughs. 'JUST TRY AND TAKE THE CROWN FROM ME!'. The final batlle begins, you know what to do. Press GREEN button to attack, RED to block and heal.";
        self.mainChar.gridProgress = 19;
    }
    else if (self.mainChar.gridProgress == 20)
    {
        self.gridPicture.image = [UIImage imageNamed:@"Grid10.png"];
        self.mainText.text=@"You pick up the crown. Use it for good? No, not this wretched artifact. No good will come of this. You throw the crown to the bottom of the nameless river, and slowly row your way back to civilization. You smile as you hope to see the fear wiped from Yondolorian faces. Your quest is over, your purpose furfilled.\n\nCONGRATULATIONS! YOU HAVE BEATEN THE GAME!.\n\nThank you for playing!";
        self.mainChar.gridProgress = 21;
        [self saveItems];
    }
    else if (self.mainChar.gridProgress == 21)
    {
        self.gridPicture.image = [UIImage imageNamed:@"Grid10.png"];
        self.mainText.text=@"You've completed the game! Exit out and start a New Game if wish to play again.";
    }

    
}

- (IBAction)green:(id)sender {
    
        [self.mainText flashScrollIndicators];
    
    if (self.mainChar.gridProgress == 1) {  //SQ 1!!!!!
        self.mainText.text = @"'Excellent! Take this Necklace of Valor, and I bid you farewell. Good luck hero! Remember to check out the STATUS screen and the included 'About' text file if you're confused.'\n\nYou gain the Necklace of Valor! +3 to Agility, Strength and Intellect. +10 to Health.\n\nYou exit the room, and close the door to the cottage.\n\nClick the RIGHT button to carry on west to your quest.";
        self.mainChar.agility +=3;
        self.mainChar.strength +=3;
        self.mainChar.intellect +=3;
        self.mainChar.health+=10;
        self.mainChar.itemCount = 1;
        
        self.mainChar.gridProgress = 2;
        
        [self saveItems];
        
       // self.buttonProg = 2;
    }
    else if(self.mainChar.gridProgress == 4)  //SQ 2
    {
        self.mainText.text = @"Correct! Have a delicious stat bonus, hero. Carry on.\n\nYou gain +5 to Intellect!\n\nPress RIGHT to push on.";
        self.mainChar.gridProgress = 5;
        self.mainChar.intellect +=5;
        
        [self saveItems];
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
        
        if (self.tempHealth > 0 && self.enemy1_health > 0) {  //ATTACK CODE HERE
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
            self.mainText.text = @"You destroy the bandits with a final attack. You find an item amongst their corpses, Chainmail of Martyrs.\n\nYou gain +15 Health from the chainmail, and +8 to Strength!\n\nPress the RIGHT arrow button to continue through the gates on your quest.";
            self.mainChar.health += 15;
            self.mainChar.strength += 8;
            self.mainChar.itemCount = 2;
            self.mainChar.gridProgress = 7;
            self.tempHealth = self.mainChar.health;
            self.enemy1_health = 30;
            
            [self saveItems];
        }
        
    } //end first battle
    else if (self.mainChar.gridProgress == 11)
    {
        if (self.mainChar.agility > 17) {
            self.mainText.text = @"You accept Goph's challenge...and swiftly pass him winning the race!. 'Phew. You really are fast. I grant you stat bonuses!\n\nYou gain +5 Health, +3 Strength, and +3 Intellect\n\nBefore you continue on your quest, Goph warns you of an evil ahead in the Meadows. \n\nPress RIGHT to continue through the Meadows.";
            self.mainChar.health += 5;
            self.mainChar.strength += 3;
            self.mainChar.intellect +=3;
            self.mainChar.gridProgress = 12;
            
            [self saveItems];
        }
        else
        {
            self.mainText.text = @"You accept Goph's challenge...and he easily passes you by. 'Nice try', he says. 'Here's some pity health.'\n\nYou gain +4 Health.\n\nBefore you continue on your quest, Goph warns you of an evil ahead in the Meadows. \n\nPress RIGHT to continue through the Meadows.";
            self.mainChar.health += 4;
            self.mainChar.gridProgress = 12;
            
            [self saveItems];
        }
    }
    
    else if(self.mainChar.gridProgress == 13)    //SECOND BATTLE
    {
        int enemy_attack = 7 + arc4random_uniform(4);
        int attack = 0;
        int r = arc4random_uniform(5);
       // NSLog(@"Strength during combat: %d",self.mainChar.strength);
        attack = self.mainChar.strength + r;
        
        int newHealth = self.tempHealth - enemy_attack;
        self.enemy2_health = self.enemy2_health - attack;
        
        if (self.tempHealth > 0 && self.enemy2_health > 0) {  //ATTACK CODE HERE
            self.mainText.text = [NSString stringWithFormat: @"Your Current Health: %d\n\nYou attack first for %d damage.\n\nEnemy swings back for %d damage.\n\nYour resulting health is %d\n\nClick GREEN to attack again, or RED to block and heal.",self.tempHealth,attack,enemy_attack, newHealth];
            self.tempHealth = newHealth;
        }
        else if (self.tempHealth <= 0)
        {
            self.mainText.text = @"You took fatal damage from the enemy on the last attack. You have died! Click GREEN button to attack and try again. You will be reborn with extra health for replaying the battle.";
            self.tempHealth = self.mainChar.health + 20;
            self.enemy2_health = 40;
        }
        else if (self.enemy2_health <= 0)
        {
            self.mainText.text = @"You destroy the King's evil servant with a final attack. You find an item in his bloodied black garb, Ring of Dardos.\n\nYou gain +20 Health from the ring, and +10 to Strength!\n\nPress the right button to move South to the Mage town of Villandra. You are fully healed.";
            self.mainChar.health += 20;
            self.mainChar.strength += 10;
            if (self.daunting == YES)
                self.mainChar.itemCount = 5;
            else
                self.mainChar.itemCount = 4;
            self.mainChar.gridProgress = 14;
            self.tempHealth = self.mainChar.health;
            self.enemy2_health = 40;
            
            [self saveItems];
        }
        
    } //end second battle
    
    
    else if (self.mainChar.gridProgress == 17)
    {
        if (self.mainChar.intellect > 17) {
            self.mainText.text = @"The wizard puts his hand to your forehead, but your high intellect detects a magical attack incoming. You strike at wizard dealing an early 10 damage to him. The wizard dematerializes into 3, devilish copies of himself, one of which is wearing the Yondolorian crown. Before you lies King Bazul, terror of Yondolore.\n\nPress RIGHT and begin the final battle.";
            self.mainChar.gridProgress = 18;
            self.enemy3_health -= 10;
            
            [self saveItems];
        }
        else
        {
            self.mainText.text = @"The wizard puts his hand to your forehead, and shoots a magical attack to your forehead. Perhaps with higher intellect you could've seen it coming, but luckily it was a glancing blow and you only lose 5 health. The wizard dematerializes into 3, devilish copies of himself, one of which is wearing the Yondolorian crown. Before you lies King Bazul, terror of Yondolore.\n\nPress RIGHT and begin the final battle.";
            self.mainChar.health -= 5;
            self.mainChar.gridProgress = 18;
            
            [self saveItems];
        }
    }
    
    //FINAL BATTLE
    
    
    else if(self.mainChar.gridProgress == 19)    //SECOND BATTLE
    {
        int enemy_attack = 10 + arc4random_uniform(4);
        int attack = 0;
        int r = arc4random_uniform(15);
        //NSLog(@"Strength during combat: %d",self.mainChar.strength);
        attack = self.mainChar.strength + r;
        
        int newHealth = self.tempHealth - enemy_attack;
        self.enemy3_health = self.enemy3_health - attack;
        
        if (self.tempHealth > 0 && self.enemy3_health > 0) {  //ATTACK CODE HERE
            self.mainText.text = [NSString stringWithFormat: @"Your Current Health: %d\n\nYou attack first for %d damage.\n\nEnemy swings back for %d damage.\n\nYour resulting health is %d\n\nClick GREEN to attack again, or RED to block and heal.",self.tempHealth,attack,enemy_attack, newHealth];
            self.tempHealth = newHealth;
        }
        else if (self.tempHealth <= 0)
        {
            self.mainText.text = @"You took fatal damage from the enemy on the last attack. You have died! Click GREEN button to attack and try again. You will be reborn with extra health for replaying the battle.";
            self.tempHealth = self.mainChar.health + 20;
            self.enemy3_health = 50;
        }
        else if (self.enemy3_health <= 0)
        {
            self.mainText.text = @"You strike down King Bazul's 3 forms. He bursts into ash, no last words, no final forms. Just a swift death. His crown drops to the ground. \n\nPress RIGHT arrow to pick up the crown...";
            self.mainChar.gridProgress = 20;
            self.tempHealth = self.mainChar.health;
            self.enemy3_health = 50;
        }
        
    } //end FINAL BATTLE

}


- (IBAction)red:(id)sender {
    
        [self.mainText flashScrollIndicators];

    if (self.mainChar.gridProgress == 1) {  //SQ 1
       self.mainText.text = @"'Very well then. But you'll have to start eventually.'";
    }
    
    else if(self.mainChar.gridProgress == 4)  //SQ 2
    {
        self.mainText.text = @"Wrong. Gannon is name from a different place. You may pass, but you shall lose wisdom for this.\n\n You lose 3 Intellect\n\nPress RIGHT to push on.";
        self.mainChar.intellect -=3;
        self.mainChar.gridProgress = 5;
        
        [self saveItems];
       // self.buttonProg =5;
    }
    else if (self.mainChar.gridProgress == 6) {      //BATTLE BLOCK CODE
        int healHealth = arc4random_uniform(15);
        int newHealth = self.tempHealth + healHealth;
        
        if (self.tempHealth > 0 && self.enemy1_health > 0) {
            self.mainText.text = [NSString stringWithFormat: @"Your Current Health: %d\n\nYou block the enemy's strike and heal up %d health.\n\nYour resulting health is %d\n\nClick GREEN to attack, or RED to block and heal.",self.tempHealth,healHealth,newHealth];
            self.tempHealth = newHealth;
        }
        else if (self.tempHealth <= 0)
        {
            self.mainText.text = @"You tried to block, but your wounds from the previous attack were too much to bear. You have died! Click GREEN button to attack or RED to block and try again. You will be reborn with extra health for replaying the battle.";
            self.tempHealth = self.mainChar.health + 20;
            self.enemy1_health = 30;
        }
        else if (self.enemy1_health <= 0)
        {
            self.mainText.text = @"As you, block the bandits bleed out from wounds from the previous attack. You find an item amongst their corpses, Chainmail of Martyrs.\n\nYou gain +15 Health from the chainmail, and +8 to Strength!\n\nPress the RIGHT button to continue through the gates on your quest. All your wounds from combat are healed.";
            self.mainChar.health += 15;
            self.mainChar.strength += 8;
            self.mainChar.itemCount = 2;
            self.mainChar.gridProgress = 7;
            self.tempHealth = self.mainChar.health;
            self.enemy1_health = 30;
            
            [self saveItems];
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
        }
        else if (self.tempHealth <= 0)
        {
            self.mainText.text = @"You tried to block, but your wounds from the previous attack were too much to bear. You have died! Click GREEN button to attack or RED to block and try again. You will be reborn with extra health for replaying the battle.";
            self.tempHealth = self.mainChar.health + 20;
            self.enemy2_health = 40;
        }
        else if (self.enemy2_health <= 0)
        {
            self.mainText.text = @"Weary from battle, the King's servant collapses as you hold up your guard, and dies. You find an item in his bloodied black garb, Ring of Dardos.\n\nYou gain +20 Health from the ring, and +10 to Strength!\n\nPress the right button to move South to the Mage town of Villandra. You are fully healed.";
            self.mainChar.health += 20;
            self.mainChar.strength += 10;
            if (self.daunting == YES)
                self.mainChar.itemCount = 5;
            else
                self.mainChar.itemCount = 4;
            
            self.mainChar.gridProgress = 14;
            
            self.tempHealth = self.mainChar.health;
            self.enemy2_health = 40;
            
            [self saveItems];

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
        }
        else if (self.tempHealth <= 0)
        {
            self.mainText.text = @"You tried to block, but your wounds from the previous attack were too much to bear. You have died! Click GREEN button to attack or RED to block and try again. You will be reborn with extra health for replaying the battle.";
            self.tempHealth = self.mainChar.health + 20;
            self.enemy3_health = 50;
        }
        else if (self.enemy3_health <= 0)
        {
            self.mainText.text = @"You strike down King Bazul's 3 forms. He bursts into ash, no last words, no final forms. Just a swift death. His crown drops to the ground. \n\nPress RIGHT arrow to pick up the crown...";
            self.mainChar.gridProgress = 20;
            self.tempHealth = self.mainChar.health;
            self.enemy3_health = 50;
            
        }
        
    } //end last battle

    
    
}
@end
