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
#import "ARFNewsTableViewCell.h"
#import "ARFUser.h"
#import "ARFNewsHeader.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"

static NSString * const cellIdentifier = @"Cell";

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
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ARFNewsTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];;
    
    self.user = [PFUser currentUser];
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];
    self.navigationItem.leftBarButtonItem = logoutButton;
    
    
    UIBarButtonItem *addNewsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNews:)];
    self.navigationItem.rightBarButtonItem = addNewsButton;
    
    ARFNewsHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"ARFNewsHeader" owner:nil options:nil] lastObject];
    [header setDelegate:self];
    [self.tableView setTableHeaderView:header];

    
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




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    //Current new
    ARFNewsEntity *newsEntity =(ARFNewsEntity *) [self objectAtIndexPath:indexPath];
    
    ARFNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell.lblTitle setText:[newsEntity title]];
    [cell.lblAuthor setText:[newsEntity author]];
    NSNumber *average =(NSNumber *) [newsEntity average];
    [cell.lblScore setText:[average stringValue]];
    PFFile *file = [newsEntity photoThumbnail];
    [cell.imgNew setFile:file];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72.0;
}

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

#pragma mark HeaderSegmentDelegate
-(void) didPressSegmentWithIndex:(NSUInteger) index{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Select" action:@"Global Feed" label:@"" value:nil] build]];
    
    if (index == kGlobalFeed) {
        //Feed entero
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Select" action:@"Global Feed" label:@"" value:nil] build]];
    }
    else if (index == kMyPublishedNewsFeed){
        //Mis noticias publicadas
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Select" action:@"My published news Feed" label:@"" value:nil] build]];
    }
    else{
        //Mis noticias no publicadas
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Select" action:@"My unpublished news Feed" label:@"" value:nil] build]];
    }
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