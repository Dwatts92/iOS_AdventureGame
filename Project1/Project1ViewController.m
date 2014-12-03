//
//  Project1ViewController.m
//  Project1
//
// First view.
//

#import "Project1ViewController.h"

@interface Project1ViewController ()

- (IBAction)startButton:(id)sender;         //new game button

@property (weak, nonatomic) IBOutlet UIButton *cont;        //continue button. only appears if there is character data in storage.

@property LocalChar *loadChar;      //new LocalChar just for quick load to make continue button appear
@property FunStats *globalStats;  //stats object to be intialized in the case of no data

@end

@implementation Project1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cont.hidden = NO;      //continue button starts unhidden
    
     self.loadChar = [[LocalChar alloc] initWithName:@"NOLOAD"initWithType:@"NOTYPE"]; //creates dummy local character to test if theres data or not
    
    
    [self loadItems];   //loads Character from storage
    
    // if dummy local character is unmodified, that means there was no character stored and the user hasn't played
    // a game yet. So hide the continue button because of this.
    
    if ([self.loadChar.charName  isEqual: @"NOLOAD"] || [self.loadChar.charType  isEqual: @"NOTYPE"]) {
        self.cont.hidden = YES;
        self.globalStats=[[FunStats alloc] init];
    }
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
    [self.navigationController setNavigationBarHidden:YES animated:YES]; //hides navigation bar, don't want it until status screen.
}

- (IBAction)startButton:(id)sender {
}



//NSCoding

- (NSString *)documentsDirectory
{
    
    return [@"~/Documents" stringByExpandingTildeInPath];
}
- (NSString *)dataFilePath
{
    //COMMENT IN FOR DIRECTORY VIEW
    
   /* NSLog(@"%@",[self documentsDirectory]); */
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Character.plist"];
    
}


- (void)loadItems
{
    // get our data file path
    NSString *path = [self dataFilePath];
    
    //do we have anything in our documents directory?  If we have anything then load it up
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        Character *persistantChar = [[Character alloc] init];   //create NSCoding object Character to get data from localChar
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        persistantChar = [unarchiver decodeObjectForKey:@"dataChar"];
        self.globalStats = [unarchiver decodeObjectForKey:@"globalStats"];
        [unarchiver finishDecoding];    //get NSCoding Character from storage
        
        NSLog(@"Contents: %@",[persistantChar description]);
    
        self.loadChar.charName = persistantChar.charName;   //store values from Character into LocalChar
        self.loadChar.charType = persistantChar.charType;
        self.loadChar.gridProgress = persistantChar.gridProgress;
        self.loadChar.health = persistantChar.health;
        self.loadChar.strength = persistantChar.strength;
        self.loadChar.agility = persistantChar.agility;
        self.loadChar.intellect = persistantChar.intellect;
        self.loadChar.itemCount = persistantChar.itemCount;
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"contSegue"]) {  //segue for continue button, passes on user's character to next view if it was loaded.
        
        MainScreen *dest = segue.destinationViewController;
        dest.mainChar = self.loadChar;
        dest.globalStats=self.globalStats;
    }
    else{//else segue is new game so pass global stats pointer
        ChooseClass *dest=segue.destinationViewController;
        dest.globalStats=self.globalStats;
    }
}



@end
