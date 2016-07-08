//
//  MasterViewController.h
//  GadgetCongress
//
//  Created by karthik on 11/06/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface MasterViewController : UITableViewController <NSXMLParserDelegate>
{
    BOOL itemStart;
}
//@property (weak, nonatomic) UILabel *lastUpdatedLbl;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) NSXMLParser *parser;
@property (strong, nonatomic) NSMutableString *item_title;

@property (strong, nonatomic) NSMutableString *link;
@property (strong, nonatomic) NSString *element;
@property (strong, nonatomic) Item *item;
@property (strong, nonatomic) NSMutableArray *feeds;

@property (retain) NSOperationQueue *queue;

@end
