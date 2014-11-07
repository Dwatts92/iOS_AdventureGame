//
//  Stats.m
//  Project1
//
//  Created by Dylan on 11/5/14.
//  Copyright (c) 2014 Dylan. All rights reserved.
//

#import "Stats.h"

@interface Stats ()
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *Class;
@property (weak, nonatomic) IBOutlet UILabel *health;
@property (weak, nonatomic) IBOutlet UILabel *strength;
@property (weak, nonatomic) IBOutlet UILabel *agility;
@property (weak, nonatomic) IBOutlet UILabel *intellect;
@property (weak, nonatomic) IBOutlet UILabel *progress;
@property (weak, nonatomic) IBOutlet UIImageView *classImg;

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
    if ([self.statsChar.charType isEqualToString:@"Warrior"]) {
            self.classImg.image = [UIImage imageNamed:@"warrior.png"];
    }
    else if([self.statsChar.charType isEqualToString:@"Archer"]) {
        self.classImg.image = [UIImage imageNamed:@"archer.png"];
    }
    else {
        self.classImg.image = [UIImage imageNamed:@"mage.png"];
    }
    NSLog(@"Game progress: %d",self.statsChar.gridProgress);
    
    double percent = self.statsChar.gridProgress/21;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.Name.text=self.statsChar.charName;
    self.Class.text=self.statsChar.charType;
    self.health.text=[NSString stringWithFormat:@"%d", self.statsChar.health];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
