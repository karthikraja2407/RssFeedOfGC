//
//  MainViewController_ipad.h
//  GadgetCongress
//
//  Created by karthik on 29/09/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface MainViewController_ipad : UIViewController{
    BOOL itemStart;
}

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) NSXMLParser *parser;
@property (strong, nonatomic) NSMutableString *item_title;

@property (strong, nonatomic) NSMutableString *link;
@property (strong, nonatomic) NSString *element;
@property (strong, nonatomic) Item *item;
@property (strong, nonatomic) NSMutableArray *feeds;
@property (weak, nonatomic) IBOutlet UITableView *tableViewIB;

@property (retain) NSOperationQueue *queue;

//@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *articleDescription;
@property (strong, nonatomic) NSString *articleTitle;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *descLbl;

- (IBAction)furthurReadingAction:(id)sender;
@property (strong, nonatomic) NSString *url_link;


@end
