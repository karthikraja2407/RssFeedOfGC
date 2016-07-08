//
//  MainViewController_ipad.m
//  GadgetCongress
//
//  Created by karthik on 29/09/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import "MainViewController_ipad.h"
#import "DetailViewController.h"
#import "GDataXMLNode.h"
#import "GDataXMLElement-Extras.h"
#import "RSSEntry.h"
#import "AsyncImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "MainTableViewCell.h"

@interface MainViewController_ipad (){
    NSMutableArray *_objects;
}

@end

@implementation MainViewController_ipad

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
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
     self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLbl.translatesAutoresizingMaskIntoConstraints = NO;
    self.url = [NSURL URLWithString:@"http://feeds.feedburner.com/gadgetcongress?fmt=xml"];
    self.feeds = [[NSMutableArray alloc] init];
    // [self.navigationController setToolbarHidden:NO];
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction:)];
    
    self.navigationItem.rightBarButtonItem = refresh;//[[NSMutableArray alloc]
    
    [self start];
	// Do any additional setup after loading the view, typically from a nib.
    
}

-(IBAction)refreshAction:(id)sender{
    [self start];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.feeds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    MainTableViewCell *cell = (MainTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.articleImageView];
    
    RSSEntry *rSSEntry = (RSSEntry*)[self.feeds objectAtIndex:indexPath.row];
    cell.articleImageView.imageURL = [NSURL URLWithString:rSSEntry.imageUrl];
    //cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
    cell.articleTitle.text = rSSEntry.articleTitle;
    cell.articleDate.text = rSSEntry.articleDate;
    cell.authorLbl.text = rSSEntry.articleAuthor;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self loadDetailView:indexPath.row];
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


-(void)start {
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:self.url];
	NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[conn start];
}



- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSHTTPURLResponse*)response {
    self.data = nil;
	self.data = [[NSMutableData alloc] init];
    [self.data setLength:0];
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)d {
    [self.data appendData:d];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *str = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    
  
    //    self.parser = [[NSXMLParser alloc] initWithData:self.data];
    //    [self.parser setDelegate:self];
    //    [self.parser setShouldResolveExternalEntities:NO];
    //    [self.parser parse];
    
    _queue = [[NSOperationQueue alloc] init];
    [_queue addOperationWithBlock:^{
        
        NSError *error;
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:self.data
                                                               options:0 error:&error];
        if (doc == nil) {
            NSLog(@"Failed to parse %@", error);
        } else {
            
            //NSMutableArray *entries = [NSMutableArray array];
            self.feeds = [[NSMutableArray alloc] init];
            [self parseFeed:doc.rootElement entries:self.feeds];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableViewIB reloadData];
                [self loadDetailView:0];
                //                for (RSSEntry *entry in self.feeds) {
                //
                //                    int insertIdx = 0;
                //                    [self.feeds insertObject:entry atIndex:insertIdx];
                //                    [self.tableView reloadData];
                //                    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:insertIdx inSection:0]]
                //                                          withRowAnimation:UITableViewRowAnimationRight];
                //
                //                }
                
            }];
            
        }
    }];
    
}


- (void)parseFeed:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries {
    if ([rootElement.name compare:@"rss"] == NSOrderedSame) {
        [self parseRss:rootElement entries:entries];
    } else if ([rootElement.name compare:@"feed"] == NSOrderedSame) {
        [self parseAtom:rootElement entries:entries];
    } else {
        NSLog(@"Unsupported root element: %@", rootElement.name);
    }
}

- (void)parseRss:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries {
    
    NSArray *channels = [rootElement elementsForName:@"channel"];
    for (GDataXMLElement *channel in channels) {
        
        NSString *blogTitle = [channel valueForChild:@"title"];
        
        NSArray *items = [channel elementsForName:@"item"];
        for (GDataXMLElement *item in items) {
            
            NSString *articleTitle = [item valueForChild:@"title"];
            NSString *articleUrl = [item valueForChild:@"link"];
            NSString *articleDate = [item valueForChild:@"pubDate"];
            NSArray *array = [articleDate componentsSeparatedByString:@" "];
            NSString *articleDateString= [articleDate substringToIndex:16];
            
            
            //            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
            //            NSDate *dateFromString ;
            //            NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            //            [dateFormatter setLocale:usLocale];
            //            dateFromString = [dateFormatter dateFromString:articleDate];
            //            NSLog(@"date:%@",dateFromString);
            //            NSString *articleDateString = [dateFromString description];
            
            
            NSString *articleDescription = [item valueForChild:@"description"];
            NSString *articleAuthor = [item valueForChild:@"author"];
            NSArray *medias = [item elementsForName:@"media:thumbnail"];
            NSString *link = [item valueForChild:@"link"];
            NSString *image_url;
            for(GDataXMLElement *media in medias) {
                
                image_url = [[media attributeForName:@"url"] stringValue];
                
            }
            
            
            
            RSSEntry *entry =  [[RSSEntry alloc] init];
            
            entry.articleTitle = articleTitle;
            entry.articleUrl = articleUrl;
            entry.articleDate = articleDateString;
            entry.imageUrl = image_url;
            entry.articleAuthor = articleAuthor;
            entry.description =[self htmlEntityDecode:articleDescription];
            entry.link = link;
            [self.feeds addObject:entry];
            
        }
    }
    
}


- (void)parseAtom:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries {
    
    NSString *blogTitle = [rootElement valueForChild:@"title"];
    
    NSArray *items = [rootElement elementsForName:@"entry"];
    for (GDataXMLElement *item in items) {
        
        NSString *articleTitle = [item valueForChild:@"title"];
        NSString *articleUrl = nil;
        NSArray *links = [item elementsForName:@"link"];
        for(GDataXMLElement *link in links) {
            NSString *rel = [[link attributeForName:@"rel"] stringValue];
            NSString *type = [[link attributeForName:@"type"] stringValue];
            if ([rel compare:@"alternate"] == NSOrderedSame &&
                [type compare:@"text/html"] == NSOrderedSame) {
                articleUrl = [[link attributeForName:@"href"] stringValue];
            }
        }
        
        NSString *articleDateString = [item valueForChild:@"updated"];
        NSDate *articleDate = nil;
        
        RSSEntry *entry = [[RSSEntry alloc] initWithBlogTitle:blogTitle
                                                 articleTitle:articleTitle
                                                   articleUrl:articleUrl
                                                  articleDate:articleDate];
        [self.feeds addObject:entry];
        
    }
    
}


-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *errorMsg = [error localizedDescription];
    if (!error) {
        errorMsg = @"Unknown error";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    self.element = elementName;
    if ([self.element isEqualToString:@"item"]) {
        itemStart = YES;
        self.item    = [[Item alloc] init];
        self.item_title   = [[NSMutableString alloc] init];
        self.link    = [[NSMutableString alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        itemStart = NO;
        self.item.item_title = self.item_title;
        self.item.imageUrl = self.link;
        [self.feeds addObject:self.item];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (itemStart) {
        if ([self.element isEqualToString:@"title"]) {
            [self.item_title appendString:string];
        } else if ([self.element isEqualToString:@"link"]) {
            [self.link appendString:string];
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.tableViewIB reloadData];
    [self loadDetailView:0];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableViewIB indexPathForSelectedRow];
        // NSDate *object = _objects[indexPath.row];
        RSSEntry *rs = (RSSEntry*)[self.feeds objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:rs.articleUrl];
        [[segue destinationViewController] setUrl:url];
        [[segue destinationViewController] setArticleDescription:rs.description];
        [[segue destinationViewController] setArticleTitle:rs.articleTitle];
    }
}


-(NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"nbsp;" withString:@""];
    //NSLog(@"string:%@",string);
    return string;
}

-(void) loadDetailView :(NSInteger)index{
    
    
    RSSEntry *rs = (RSSEntry*)[self.feeds objectAtIndex:index];

    self.articleDescription = rs.description;
    self.articleTitle = rs.articleTitle;
    self.url_link = rs.link;
    
    [self.titleLbl setText:self.articleTitle];
    NSString *desc = [self.articleDescription stringByStrippingHTML];
    [self.descLbl setText:desc];
    
    NSScanner *scanner = [NSScanner scannerWithString:self.articleDescription];
    // NSLog(@"desc:%@",self.articleDescription);
    NSString *test ;
    if ([scanner scanUpToString:@"<img" intoString:&test]) {
        NSString *imageUrl;
        // NSLog(@"test:%@",test);
        if ([scanner scanUpToString:@"http" intoString:NULL]) {
            if ([scanner scanUpToString:@"\"" intoString:&imageUrl]) {
                self.imageView.imageURL = [NSURL URLWithString:imageUrl];
              //  NSLog(@"imageurl :%@",imageUrl);
                NSString *descString;
                if ([scanner scanUpToString:@"<" intoString:&descString]) {
                    //NSLog(@"rest string: %@",descString);
                    if ([scanner scanUpToString:@"\n" intoString:&descString]) {
                      //  NSLog(@"article desc : %@",self.articleDescription);
//                       NSString *desc = [self.articleDescription stringByStrippingHTML];
//                       // NSLog(@"desc :%@",desc);
//                        [self.descLbl setText:desc];
                       // [self.textView layoutIfNeeded];


//                        float height = self.textView.contentSize.height;
//                        [self.textViewHeight setConstant:height];
                        
                    }
                }
                
            }
            else {
                // Do nothing? I think this would be hit on the last time through the loop
            }
        }
        
    }

}

- (IBAction)furthurReadingAction:(id)sender {
    NSURL *url = [NSURL URLWithString:self.url_link];
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"error");
    }
    
}
@end
