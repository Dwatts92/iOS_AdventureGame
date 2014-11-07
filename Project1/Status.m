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
    self.choices = [NSArray arrayWithObjects: @"Items",@"Character Stats", nil];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
    
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
    return [self.choices count];
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
    cell.backgroundColor = [UIColor brownColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self performSegueWithIdentifier:@"itemSegue" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"statSegue" sender:self];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"itemSegue"]) {
        Items *dest = segue.destinationViewController;
         dest.itemsChar = self.tableChar;
    } else if ([segue.identifier isEqualToString:@"statSegue"]) {
        Stats *dest2 = segue.destinationViewController;
        dest2.statsChar = self.tableChar;
    }
}


@end
