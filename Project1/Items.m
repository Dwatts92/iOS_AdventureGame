//
//  Items.m
//  Project1
//
//  Created by Dylan on 11/5/14.
//  Copyright (c) 2014 Dylan. All rights reserved.
//

#import "Items.h"

@interface Items ()

@property (weak, nonatomic) IBOutlet UILabel *item1;
@property (weak, nonatomic) IBOutlet UILabel *desc1;
@property (weak, nonatomic) IBOutlet UILabel *item2;
@property (weak, nonatomic) IBOutlet UILabel *desc2;
@property (weak, nonatomic) IBOutlet UILabel *item3;
@property (weak, nonatomic) IBOutlet UILabel *desc3;
@property (weak, nonatomic) IBOutlet UILabel *desc4;
@property (weak, nonatomic) IBOutlet UILabel *item4;

@end

@implementation Items

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
    
    if (self.itemsChar.itemCount ==1) {
        self.item1.text = @"Necklace of Valor";
        self.desc1.text = @"+3 to Agility, Strength and Intellect. +10 to Health.";
    }
        if (self.itemsChar.itemCount == 2)
        {
            self.item1.text = @"Necklace of Valor";
            self.desc1.text = @"+3 to Agility, Strength and Intellect. +10 to Health.";
            
            self.item2.text = @"Chainmail of Martyrs";
            self.desc2.text = @"+15 to Health, +8 to Strength";
        }
    if (self.itemsChar.itemCount == 3)
    {
        self.item1.text = @"Necklace of Valor";
        self.desc1.text = @"+3 to Agility, Strength and Intellect. +10 to Health.";
        
        self.item2.text = @"Chainmail of Martyrs";
        self.desc2.text = @"+15 to Health, +8 to Strength";
        
        self.item3.text = @"Cloak of Daunting";
        self.desc3.text = @"+5 to Agility";
        
    }
    
    if (self.itemsChar.itemCount == 4)
    {
        self.item1.text = @"Necklace of Valor";
        self.desc1.text = @"+3 to Agility, Strength and Intellect. +10 to Health.";
        
        self.item2.text = @"Chainmail of Martyrs";
        self.desc2.text = @"+15 to Health, +8 to Strength";
        
        self.item4.text = @"Ring of Dardos";
        self.desc4.text = @"+20 Health, +10 to Strength";
    }
    
    if (self.itemsChar.itemCount == 5)
    {
        self.item1.text = @"Necklace of Valor";
        self.desc1.text = @"+3 to Agility, Strength and Intellect. +10 to Health.";
        
        self.item2.text = @"Chainmail of Martyrs";
        self.desc2.text = @"+15 to Health, +8 to Strength";
        
        self.item3.text = @"Cloak of Daunting";
        self.desc3.text = @"+5 to Agility";
        
    
        self.item4.text = @"Ring of Dardos";
        self.desc4.text = @"+20 Health, +10 to Strength";
    }
    
    // Do any additional setup after loading the view.
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
