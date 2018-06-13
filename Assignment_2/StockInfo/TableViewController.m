//
//  TableViewController.m
//  StockInfo
//
//  Created by Parth Patel on 2018-04-18.
//  Copyright © 2018 Seneca College. All rights reserved.
//

#import "TableViewController.h"
#import "Yahoo.h"
#import "StockInfo-swift.h"

@interface TableViewController ()<yahooSearchDelegate,UISearchBarDelegate>
@property (nonatomic,strong)NSArray* results;
@property (nonatomic) Yahoo* myModel;
@property (nonatomic, weak) NSString* stockNm;
@end
@implementation TableViewController

-(Yahoo*)myModel{

    if (_myModel == nil)
    {
        _myModel = [[Yahoo alloc]init];
        _myModel.delegate = self;
        
        
    }
    return _myModel;
}


-(void)yahooDidFinishWithResults:(NSArray *)YahooResults{
    self.results = YahooResults;
    [self.tableView reloadData];

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.myModel searchYahooForUserText:searchText];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication ]delegate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
    
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    //NSIndexPath *selectedIndexPath = [tableView indexPathForSelectedRow];

    _item = [self.results objectAtIndex:indexPath.row];
    cell.textLabel.text = [_item objectForKey:@"symbol"];
    cell.detailTextLabel.text = [_item objectForKey:@"name"];
    
    _stockNm = [_item objectForKey:@"symbol"];
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //_stockNm = [_item objectForKey:@"symbol"];
    
    //_tempItm = [self.results objectAtIndex:indexPath.row];
    //_stockNm = [_tempItm objectForKey:@"symbol"];
    NSLog(@"selected tableview row is %ld",(long)indexPath.row);
    
    _tempItm = [self.results objectAtIndex:indexPath.row];
    _stockNm = [_tempItm objectForKey:@"symbol"];
    
    
    Stock *sk = [NSEntityDescription insertNewObjectForEntityForName:@"Stock" inManagedObjectContext:_appDelegate.persistentContainer.viewContext];
    sk.symbol = _stockNm;
    [_appDelegate saveContext];
    
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Stock" inManagedObjectContext:_appDelegate.persistentContainer.viewContext];
    [fetch setEntity:entity];
    NSError *err = nil;

    
    NSArray *res = [_appDelegate.persistentContainer.viewContext executeFetchRequest:fetch error:&err];
    
    if(err){
        NSLog(@"ERROR");
    }else{
        NSLog(@"Safe");
    }
    
    NSLog(@"%@", [res valueForKey:@"symbol"]);
    

    
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"stocetail"]){

        ViewController *detail = (ViewController *)segue.destinationViewController;
        
        detail.stock = _stockNm;
        
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
