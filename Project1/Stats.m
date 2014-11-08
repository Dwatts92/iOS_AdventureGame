//
//  Stats.m
//  Project1
//
// Lists stats and game progress of character.
//

#import "Stats.h"

@interface Stats ()
@property (weak, nonatomic) IBOutlet UILabel *Name;     //character stats
@property (weak, nonatomic) IBOutlet UILabel *Class;
@property (weak, nonatomic) IBOutlet UILabel *health;
@property (weak, nonatomic) IBOutlet UILabel *strength;
@property (weak, nonatomic) IBOutlet UILabel *agility;
@property (weak, nonatomic) IBOutlet UILabel *intellect;
@property (weak, nonatomic) IBOutlet UILabel *progress;
@property (weak, nonatomic) IBOutlet UIImageView *classImg;     //image on view

@end

@implementation Stats

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
    if ([self.statsChar.charType isEqualToString:@"Warrior"]) {         //changes the image to your character if you chose them.
            self.classImg.image = [UIImage imageNamed:@"warrior.png"];
    }
    else if([self.statsChar.charType isEqualToString:@"Archer"]) {
        self.classImg.image = [UIImage imageNamed:@"archer.png"];
    }
    else {
        self.classImg.image = [UIImage imageNamed:@"mage.png"];
    }
    
    double percent = 100 * self.statsChar.gridProgress/21;      //calculates game progress as a percent.
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.Name.text=self.statsChar.charName;
    self.Class.text=self.statsChar.charType;
    self.health.text=[NSString stringWithFormat:@"%d", self.statsChar.health];      //puts stats in to labels
    self.strength.text=[NSString stringWithFormat:@"%d", self.statsChar.strength];
    self.agility.text=[NSString stringWithFormat:@"%d", self.statsChar.agility];
    self.intellect.text=[NSString stringWithFormat:@"%d", self.statsChar.intellect];
    self.progress.text=[NSString stringWithFormat:@"%.02f", percent];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
