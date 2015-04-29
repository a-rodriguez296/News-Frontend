//
// This is the template PFQueryTableViewController subclass file. Use it to customize your own subclass.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import <ParseUI/ParseUI.h>
#import "ARFConstants.h"
#import "ARFNewsEntity.h"
#import "ARFCreateNewsViewController.h"
#import "ARFViewNewsViewController.h"
#import "ARFDisplayNewViewController.h"

@interface ARFNewsViewController : PFQueryTableViewController <PFLogInViewControllerDelegate>

@property (nonatomic, strong) PFUser *user;

@end

@implementation ARFNewsViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = kNewsEntityName;
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = kNewsEntityTitle;
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.user = [PFUser currentUser];
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];
    self.navigationItem.leftBarButtonItem = logoutButton;
    
    
    UIBarButtonItem *addNewsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNews:)];
    self.navigationItem.rightBarButtonItem = addNewsButton;
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //    PFUser *user = [PFUser currentUser];
    
    
    //    [PFCloud callFunctionInBackground:@"hello" withParameters:nil block:^(id result, NSError *error){
    //
    //        NSDictionary * dict = result;
    //        NSLog(@"%@",dict);
    //
    //    }];
    
    
    //    [PFFacebookUtils logInInBackgroundWithReadPermissions:@[@"public_profile",@"email",@"user_friends"] block:^(PFUser *user, NSError *error) {
    //        if (!user) {
    //            NSLog(@"Uh oh. The user cancelled the Facebook login.");
    //        } else if (user.isNew) {
    //            NSLog(@"User signed up and logged in through Facebook!");
    //        } else {
    //            NSLog(@"User logged in through Facebook!");
    //        }
    //    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - PFQueryTableViewController

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If Pull To Refresh is enabled, query against the network by default.
    if (self.pullToRefreshEnabled) {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    return query;
}


/*
 // Override to customize the look of a cell representing an object. The default is to display
 // a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
 // and the imageView being the imageKey in the object.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
 static NSString *CellIdentifier = @"Cell";
 
 PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 if (cell == nil) {
 cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 // Configure the cell
 cell.textLabel.text = [object objectForKey:self.textKey];
 cell.imageView.file = [object objectForKey:self.imageKey];
 
 return cell;
 }
 */


/*
 //////Celda Loading more cells !!!!!!!!!!!!!!!!!!!!
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"NextPage";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.textLabel.text = @"Load more...";
 
 return cell;
 }
 */

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    ARFNewsEntity * newEntity =(ARFNewsEntity *) [self objectAtIndexPath:indexPath];
    ARFDisplayNewViewController *displayNewVC = [[ARFDisplayNewViewController alloc] initWithNibName:NSStringFromClass([ARFBaseNewsEntityViewController class]) bundle:nil newsEntity:newEntity];
    [self.navigationController pushViewController:displayNewVC animated:YES];
}

#pragma mark IBActions
-(void) addNews:(id) sender{
    
    ARFBaseNewsEntityViewController *createNewsVC = [[ARFCreateNewsViewController alloc] initWithNibName:NSStringFromClass([ARFBaseNewsEntityViewController class]) bundle:nil];
    [self.navigationController pushViewController:createNewsVC animated:YES];
}

-(void) logout:(id) sender{
    [PFUser logOut];
}

@end