//
//  DetailViewController.h
//  GadgetCongress
//
//  Created by karthik on 11/06/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+stripHtml.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;


@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *articleDescription;
@property (strong, nonatomic) NSString *articleTitle;
@property (strong, nonatomic) NSString *link;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight2;

@property (weak, nonatomic) IBOutlet UITextView *tesxtView;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;

- (IBAction)furthurReadingAction:(id)sender;

@end
