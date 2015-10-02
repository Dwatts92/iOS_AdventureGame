//
//  CharListViewController.m
//  Project1
//
//  Created by ddwatts on 12/6/14.
//  Copyright (c) 2014 Dylan. All rights reserved.
//

#import "CharListViewController.h"

@interface CharListViewController ()
@property NSString* playerName;
@property NSString* playerType;
@property int gridProg;
@property int health;
@property int strength;
@property int agility;
@property int intellect;
@property int itemProg;

@property NSString* type;
@property NSString* lvl;
@property NSString* time;






@end

@implementation CharListViewController

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"Character";
        self.type = @"charType";
        self.time= @"createdAt";
        
        
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];


    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.loadChar = [[LocalChar alloc] initWithName:@"NOLOAD"initWithType:@"NOTYPE"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"CharCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    
   /* @"Name:%@ Type:%@",object[@"charName"];   //load storage stats into local character
          object[@"charType"]); */
    self.playerName = object[@"charName"];

    //itemprogress
    
    NSString *playerInfo = self.playerName;
    
    cell.textLabel.text = playerInfo;
    
     cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  %@", [object objectForKey:self.textKey], [object objectForKey:self.time]];
    cell.detailTextLabel.text = playerInfo;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor blackColor];

   // cell.detailTextLabel.text = [NSString stringWithFormat:@"Posted by: %@", [object objectForKey:self.textKey]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = selectCell.textLabel.text;
    self.playerName = cellText;
    [self loadParse];
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    MainScreen *dest = segue.destinationViewController;
    NSLog(@"OBJECT LOADED!!!");
    dest.mainChar = self.loadChar;
    
}

-(void)loadParse
{
    NSLog(@"\n%@\n", self.playerName);
    PFQuery *query = [PFQuery queryWithClassName:@"Character"];
    [query whereKey:@"charName" equalTo:self.playerName];
    PFObject *parseChar =[query getFirstObject];
        if (!parseChar) {
            NSLog(@"The getFirstObject request failed.");
        } else {
            // The find succeeded.
            NSLog(@"Successfully retrieved the object.");
            NSLog(@"%@",parseChar[@"charName"]);
            NSLog(@"%@",parseChar[@"charType"]);
            NSLog(@"%@",parseChar[@"gridProgress"]);
            NSLog(@"%@",parseChar[@"health"]);
            NSLog(@"%@",parseChar[@"strength"]);
            NSLog(@"%@",parseChar[@"agility"]);
            NSLog(@"%@",parseChar[@"gridProgress"]);
            NSLog(@"%@",parseChar[@"gridProgress"]);
            NSLog(@"%@",parseChar[@"gridProgress"]);
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
            
            NSLog(@"Name:%@ Type:%@ Grid Progress:%d/21 Health: %d Strength: %d Agility: %d Intellect: %d Item Progress: %d Exp: %d Lvl: %d Rank: %d Battles: %d Deaths: %d Blocks: %d Attacks: %d",self.loadChar.charName, self.loadChar.charType,self.loadChar.gridProgress,self.loadChar.health, self.loadChar.strength,self.loadChar.agility,self.loadChar.intellect,self.loadChar.itemCount, self.loadChar.exp, self.loadChar.lvl, self.loadChar.rank, self.loadChar.battles, self.loadChar.deaths, self.loadChar.blocks, self.loadChar.attacks);
            
        }
   
}







@end
