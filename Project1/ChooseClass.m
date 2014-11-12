//
//  ChooseClass.m
//  Project1
//
// Where you pick you character class.
//
#import "ChooseClass.h"
@import AudioToolbox;
@import AVFoundation;

@interface ChooseClass ()

@property NSString *type;

- (IBAction)warrior:(id)sender;     //different character types
- (IBAction)archer:(id)sender;
- (IBAction)mage:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *error;    //error text that gets displayed on view


- (IBAction)beginButton:(id)sender;     //button to begin game with selected char


@property LocalChar* character;     //object of character

@property (weak, nonatomic) IBOutlet UITextField *characterName;    //name input to enter for char
@property AVAudioPlayer *warrior, *mage, *archer, *begin;

@end

//@synthesize beginButton = _beginButton;
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
    
    NSString *path = @"";
    NSURL *soundUrl;
    NSError *error;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    path = [[NSBundle mainBundle] pathForResource:@"warrior" ofType:@"mp3"];
    soundUrl = [NSURL fileURLWithPath:path];
    self.warrior = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:&error];
    
    path = [[NSBundle mainBundle] pathForResource:@"archer" ofType:@"mp3"];
    soundUrl = [NSURL fileURLWithPath:path];
    self.archer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:&error];
    
    path = [[NSBundle mainBundle] pathForResource:@"mage" ofType:@"mp3"];
    soundUrl = [NSURL fileURLWithPath:path];
    self.mage = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:&error];
    
    path = [[NSBundle mainBundle] pathForResource:@"begin" ofType:@"mp3"];
    soundUrl = [NSURL fileURLWithPath:path];
    self.begin = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:&error];
    
    // Do any additional setup after loading the view.
    _characterName.delegate = self; //delegate set here so I can hide the keyboard upon enter or clicking out
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


- (IBAction)warrior:(id)sender {  //changes the type based on what avatar you click on
    
    self.type = @"Warrior";
    [self.warrior play];
}

- (IBAction)archer:(id)sender {
    
    self.type = @"Archer";
    [self.archer play];
}

- (IBAction)mage:(id)sender {
    
    self.type = @"Mage";
    [self.mage play];
    
}



- (IBAction)beginButton:(id)sender {        //shows error button and prevents segue if a char type or name weren't chosen.
    
    if ([self shouldPerformSegueWithIdentifier:@"toMain" sender:(id)sender] == NO)
    {
        self.error.text = @"Please enter a name and pick a character.";
    }
    else{
        
        self.character = [[LocalChar alloc] initWithName:self.characterName.text initWithType:self.type]; //creats an object of the character, this is passed through almost every segue in the applcation.
        self.character.gridProgress = 0;        //starting gridprogress at 0
        [self.begin play];
    }
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender   //method for if segue should be performed or not.
{
    if ([self.characterName.text  isEqual: @"" ] || self.type==NULL)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    IntroStory *dest = segue.destinationViewController;    //send character to next view, the IntroStory
    NSLog(@"Name: %@",self.character.charName);
    NSLog(@"Type: %@",self.character.charType);
    dest.chosenChar = self.character;
    // Pass the selected object to the new view controller.
}

@end
