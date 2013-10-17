//
//  ViewController.m
//  GeoSearch
//
//  Created by Ignacio on 10/17/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//

#import "ViewController.h"
#import "GMPlaceAPI.h"

static NSString *kCellID = @"CellIdentifier";

@interface ViewController ()
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *userLocation;
@end

@implementation ViewController

//AIzaSyBr29w35EVpNZSNy7MU1bqe-6Lp6NgrS78 - Epiclist
//AIzaSyA4izLG3GJiWkMxfXWAmIJOW9Otu1CYvGg - Ignacio

+ (void)initialize
{
    [GMPlaceClient registerClientWithConsumerKey:@"AIzaSyBr29w35EVpNZSNy7MU1bqe-6Lp6NgrS78"];
    [GMPlaceClient sharedClient].sensor = YES;
    [GMPlaceClient sharedClient].radius = 1000;
}

- (id)init
{
    self = [super init];
    if (self) {
        _searchResults = [NSMutableArray new];
        
        _searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsDataSource = self;
        _searchController.searchResultsDelegate = self;
        _searchController.searchResultsTableView.tableHeaderView = [UIView new];
        _searchController.searchResultsTableView.tableFooterView = [UIView new];
        _searchController.displaysSearchBarInNavigationBar = YES;
        [_searchController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellID];
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.distanceFilter = 1.0;
        _locationManager.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_locationManager startUpdatingLocation];
}

#pragma mark - Getter Methods

- (UISearchBar *)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 300.0, 30.0)];
        _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchBar.keyboardType = UIKeyboardTypeAlphabet;
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.placeholder = @"Search";
    }
    return _searchBar;
}


- (void)setSearchResults:(NSArray *)results
{
//    if (_searchResults) {
//        [self setSearchResults:nil];
//    }
    
    _searchResults = [[NSArray alloc] initWithArray:results];
    [_searchController.searchResultsTableView reloadData];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    GMPlace *place = [_searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = place.name;
    
    return cell;
}


#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMPlace *place = [_searchResults objectAtIndex:indexPath.row];
    NSLog(@"%s : %@",__FUNCTION__, place.description);
    
    [self.searchDisplayController setActive:NO animated:YES];
}


#pragma mark - UISearchDisplayDelegate Methods
#pragma mark Search State Change

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    if (searchString.length > 2) {
        [GMPlaceClient sharedClient].userLocation = _userLocation.coordinate;
        [[GMPlaceClient sharedClient] geocodedPlacesForName:searchString
                                                    success:^(NSArray *places){
                                                        [self setSearchResults:places];
                                                    }
                                                    failure:^(NSError *error){
                                                        NSLog(@"%s : %@",__FUNCTION__, error);
                                                    }];
        
//        [[GMPlaceClient sharedClient] searchPlacesForName:searchString
//                                                    success:^(NSArray *places){
//                                                        [self setSearchResults:places];
//                                                    }
//                                                    failure:^(NSError *error){
//                                                        NSLog(@"%s : %@",__FUNCTION__, error);
//                                                    }];
        
        return YES;
    }
    else {
        [self setSearchResults:nil];
        return NO;
    }
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    [controller.searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{

}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    [controller.searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark Loading and Unloading the Table View

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView
{
    
}

#pragma mark Showing and Hiding the Table View

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView
{
    
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView
{
    
}


#pragma mark CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [manager stopUpdatingLocation];
    _userLocation = [locations objectAtIndex:0];
    
    NSLog(@"_userLocation : %@", _userLocation);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [manager stopUpdatingLocation];
    NSLog(@"error : %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
}

@end
