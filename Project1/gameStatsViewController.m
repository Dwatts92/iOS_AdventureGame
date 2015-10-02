//
//  gameStatsViewController.m
//  Project1
//
//  Created by ddwatts on 12/7/14.
//  Copyright (c) 2014 Dylan. All rights reserved.
//

#import "gameStatsViewController.h"

@interface gameStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *progress;
@property (weak, nonatomic) IBOutlet UILabel *exp;
@property (weak, nonatomic) IBOutlet UILabel *attacks;
@property (weak, nonatomic) IBOutlet UILabel *battles;
@property (weak, nonatomic) IBOutlet UILabel *levels;
@property (weak, nonatomic) IBOutlet UILabel *rank;
@property (weak, nonatomic) IBOutlet UILabel *deaths;

@end

@implementation gameStatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"darkbrowncurls.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    // Do any additional setup after loading the view.
    
    double percent = 100 * self.gameChar.gridProgress/21;      //calculates game progress as a percent.
    if (percent > 100)
    {
        percent = 100;
    }
    
    
    self.progress.text=[NSString stringWithFormat:@"%.02f", percent];
    self.exp.text=[NSString stringWithFormat:@"%d", self.gameChar.exp];
    self.attacks.text=[NSString stringWithFormat:@"%d", self.gameChar.attacks];
    self.battles.text=[NSString stringWithFormat:@"%d", self.gameChar.battles];
    self.levels.text=[NSString stringWithFormat:@"%d", (self.gameChar.lvl)-1];
    self.rank.text=[NSString stringWithFormat:@"%d", self.gameChar.rank];
    self.deaths.text = [NSString stringWithFormat:@"%d", self.gameChar.deaths];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
