//
//  Status.m
//  Project1
//
//  Table view for char stats and items
//

#import "Status.h"

@interface Status ()
@property (weak, nonatomic) IBOutlet UITableView *statusTable;


@end

@implementation Status

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
    self.choices = [NSArray arrayWithObjects: @"Items",@"Character Stats", nil];  //set cell titles
      [self.navigationController setNavigationBarHidden:NO animated:YES];  //re-instate navigation bar for use of back button in this screen, as well as items and stats.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.choices count];        //rows = array, 2 titles
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"choiceCell";
    
    UITableViewCell *cell = [self.statusTable
                             dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.choices
                           objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor brownColor];        //change cell appearance
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) //stats up segues for each cell depending on what you click.
    {
        [self performSegueWithIdentifier:@"itemSegue" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"statSegue" sender:self];
    }
}

- (void)viewWillDisappear:(BOOL)animated {      //
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];    //if view is going back to MainScreen, rehide the navigation bar.
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"itemSegue"]) {  //if user clicks on items, go to item screen, transfer character stats over there.
        Items *dest = segue.destinationViewController;
         dest.itemsChar = self.tableChar;
        
    } else if ([segue.identifier isEqualToString:@"statSegue"]) {
        //if user clicks on stats, go to stats screen, transfer character stats over there.
        Stats *dest2 = segue.destinationViewController;
        dest2.statsChar = self.tableChar;
        dest2.globalStats=self.globalStats;
    }
}


@end
