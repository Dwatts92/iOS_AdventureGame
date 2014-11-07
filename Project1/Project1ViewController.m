//
//  Project1ViewController.m
//  Project1
//
// First view.
//

#import "Project1ViewController.h"

@interface Project1ViewController ()

- (IBAction)startButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cont;

@property LocalChar *loadChar;


@end

@implementation Project1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cont.hidden = NO;
    
     self.loadChar = [[LocalChar alloc] initWithName:@"NOLOAD"initWithType:@"NOTYPE"];
    
    [self loadItems];
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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
        Character *persistantChar = [[Character alloc] init];
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        persistantChar = [unarchiver decodeObjectForKey:@"dataChar"];
        [unarchiver finishDecoding];
        
        NSLog(@"Contents: %@",[persistantChar description]);
    
        self.loadChar.charName = persistantChar.charName;
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
    
    if ([segue.identifier isEqualToString:@"contSegue"]) {
        MainScreen *dest = segue.destinationViewController;
        dest.mainChar = self.loadChar;
    }
}



@end
