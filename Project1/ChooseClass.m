//
//  ChooseClass.m
//  Project1
//
// Where you pick you character class.
//

#import "ChooseClass.h"

@interface ChooseClass ()

@property NSString *type;

- (IBAction)warrior:(id)sender;
- (IBAction)archer:(id)sender;
- (IBAction)mage:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *error;


- (IBAction)beginButton:(id)sender;


@property LocalChar* character;

@property (weak, nonatomic) IBOutlet UITextField *characterName;

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


- (IBAction)warrior:(id)sender {
    
    self.type = @"Warrior";
   // self.character.charType = self.type;
}

- (IBAction)archer:(id)sender {
    
    self.type = @"Archer";
   // self.character.charType = self.type;
}

- (IBAction)mage:(id)sender {
    
    self.type = @"Mage";
   // self.character.charType = self.type;

}



- (IBAction)beginButton:(id)sender {
    //self.character.charName = self.characterName.text;
    if ([self shouldPerformSegueWithIdentifier:@"toMain" sender:(id)sender] == NO)
    {
        self.error.text = @"Please enter a name and pick a character.";
    }
    else{
        
        self.character = [[LocalChar alloc] initWithName:self.characterName.text initWithType:self.type];
        self.character.gridProgress = 0;
    }
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
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


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     IntroStory *dest = segue.destinationViewController;
     NSLog(@"Name: %@",self.character.charName);
     NSLog(@"Type: %@",self.character.charType);
     dest.chosenChar = self.character;
 // Pass the selected object to the new view controller.
 }





@end
