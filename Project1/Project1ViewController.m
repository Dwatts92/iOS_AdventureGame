//
//  Project1ViewController.m
//  Project1
//
// First view.
//

#import "Project1ViewController.h"

@interface Project1ViewController ()

- (IBAction)startButton:(id)sender;         //new game button
- (IBAction)instructions:(id)sender;
- (IBAction)loadGame:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *cont;        //continue button. only appears if there is character data in storage.

@property LocalChar *loadChar;      //new LocalChar just for quick load to make continue button appear


@end

@implementation Project1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"brown texture copy.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
     //^^^Awesome method for resizing image and putting it on a background I got from stackexchange here:http://stackoverflow.com/questions/8077740/how-to-fill-background-image-of-an-uiview. Reused in the other pages as well.
    
    self.cont.hidden = NO;      //continue button starts unhidden
    
     self.loadChar = [[LocalChar alloc] initWithName:@"NOLOAD"initWithType:@"NOTYPE"]; //creates dummy local character to test if theres data or not

        NSLog(@"Before Parse %@", self.loadChar.charName);
   // [self loadItems];   //ADD BACK IN FOR LOCAL STORAGE
    [self loadParse];
    
    NSLog(@"After Parse");
    NSLog(@"Name:%@ Type:%@", self.loadChar.charName, self.loadChar.charType);
    
    // if dummy local character is unmodified, that means there was no character stored and the user hasn't played
    // a game yet. So hide the continue button because of this.
    
    
    if ([self.loadChar.charName  isEqual: @"NOLOAD"] || [self.loadChar.charType  isEqual: @"NOTYPE"]) {
        self.cont.hidden = YES;
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

-(void)loadParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"Character"];
    [query addDescendingOrder:@"createdAt"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *parseChar, NSError *error) {
        if (!parseChar) {
            NSLog(@"The getFirstObject request failed.");
        } else {
            // The find succeeded.
            NSLog(@"Successfully retrieved the object.");
            
            self.loadChar.charName = parseChar[@"charName"];   //load storage stats into local character
            self.loadChar.charType = parseChar[@"charType"];
            self.loadChar.gridProgress = [[parseChar objectForKey:@"gridProgress"] intValue];
            self.loadChar.health = [[parseChar objectForKey:@"health"] intValue];
            self.loadChar.strength = [[parseChar objectForKey:@"strength"] intValue];
            self.loadChar.agility = [[parseChar objectForKey:@"agility"] intValue];
            self.loadChar.intellect = [[parseChar objectForKey:@"intellect"] intValue];
            self.loadChar.itemCount = [[parseChar objectForKey:@"itemCount"] intValue];
            
            self.loadChar.exp = [[parseChar objectForKey:@"exp"] intValue];
            self.loadChar.lvl = [[parseChar objectForKey:@"lvl"] intValue];
            self.loadChar.rank = [[parseChar objectForKey:@"rank"] intValue];
            self.loadChar.battles = [[parseChar objectForKey:@"battles"] intValue];
            self.loadChar.deaths = [[parseChar objectForKey:@"deaths"] intValue];
            self.loadChar.blocks = [[parseChar objectForKey:@"blocks"] intValue];
            self.loadChar.attacks = [[parseChar objectForKey:@"attacks"] intValue];
            
            NSLog(@"Name:%@ Type:%@ Grid Progress:%d/21 Health: %d Strength: %d Agility: %d Intellect: %d Item Progress: %d",self.loadChar.charName, self.loadChar.charType,self.loadChar.gridProgress,self.loadChar.health, self.loadChar.strength,self.loadChar.agility,self.loadChar.intellect,self.loadChar.itemCount);
            
            self.cont.hidden = NO;
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"contSegue"]) {  //segue for continue button, passes on user's character to next view if it was loaded.
        
        MainScreen *dest = segue.destinationViewController;
        dest.mainChar = self.loadChar;
    }
    /*
    if ([segue.identifier isEqualToString:@"loadSegue"])
    {
        CharListViewController *dest = segue.destinationViewController;
        dest.loadChar = self.loadChar;
    }*/
}





- (IBAction)instructions:(id)sender {
}

- (IBAction)loadGame:(id)sender {
}
@end
