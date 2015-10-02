//
//  Items.m
//  Project1
//
// Lists items you have collected.
//

#import "Items.h"

@interface Items ()

@property (weak, nonatomic) IBOutlet UILabel *item1;        //descriptions and item names for each item
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
    [super viewDidLoad];        //there are 5 possible item combinations you can get...
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"page2.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    if (self.itemsChar.itemCount ==1) {                 //character got item 1, Necklace of Valor
        self.item1.text = @"Necklace of Valor";
        self.desc1.text = @"+3 to Agility, Strength and Intellect. +10 to Health.";
    }
        if (self.itemsChar.itemCount == 2)          //character got both items 1 and 2
        {
            self.item1.text = @"Necklace of Valor";
            self.desc1.text = @"+3 to Agility, Strength and Intellect. +10 to Health.";
            
            self.item2.text = @"Chainmail of Martyrs";
            self.desc2.text = @"+15 to Health, +8 to Strength";
        }
    if (self.itemsChar.itemCount == 3)      //character got 1 and 2, and an optional item
    {
        self.item1.text = @"Necklace of Valor";
        self.desc1.text = @"+3 to Agility, Strength and Intellect. +10 to Health.";
        
        self.item2.text = @"Chainmail of Martyrs";
        self.desc2.text = @"+15 to Health, +8 to Strength";
        
        self.item3.text = @"Cloak of Daunting";
        self.desc3.text = @"+5 to Agility";
        
    }
    
    if (self.itemsChar.itemCount == 4)      //character got 1 and 2, missed the optional item, got the last item
    {
        self.item1.text = @"Necklace of Valor";
        self.desc1.text = @"+3 to Agility, Strength and Intellect. +10 to Health.";
        
        self.item2.text = @"Chainmail of Martyrs";
        self.desc2.text = @"+15 to Health, +8 to Strength";
        
        self.item4.text = @"Ring of Dardos";
        self.desc4.text = @"+20 Health, +10 to Strength";
    }
    
    if (self.itemsChar.itemCount == 5)      //character got all items
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
    
    // Not the best way of doing this, but it works and appears how I want it to. Items that haven't been collected show up as ??? marks on the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
