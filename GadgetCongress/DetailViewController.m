//
//  DetailViewController.m
//  GadgetCongress
//
//  Created by karthik on 11/06/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import "DetailViewController.h"
#import "AsyncImageView.h"
#import "NSString+stripHtml.h"


@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

-(void)viewDidAppear:(BOOL)animated{



    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.titleLbl setText:self.articleTitle];
    NSScanner *scanner = [NSScanner scannerWithString:self.articleDescription];
    
    NSString *desc = [self.articleDescription stringByStrippingHTML];
    //NSLog(@"log details1 :%@",self.articleDescription);
    //NSLog(@"log details2 :%@",desc);
    
    [self.descLbl setText:desc];
//    [self.textView layoutIfNeeded];
//    float height = self.textView.contentSize.height;
//    [self.textViewHeight2 setConstant:height];
    
   // NSLog(@"desc:%@",self.articleDescription);
    NSString *test ;
    if ([scanner scanUpToString:@"<img" intoString:&test]) {
        NSString *imageUrl;
       // NSLog(@"test:%@",test);
        if ([scanner scanUpToString:@"http" intoString:NULL]) {
            if ([scanner scanUpToString:@"\"" intoString:&imageUrl]) {                               
                self.imageView.imageURL = [NSURL URLWithString:imageUrl];
                NSString *descString;
                if ([scanner scanUpToString:@"<" intoString:&descString]) {
                    if ([scanner scanUpToString:@"\n" intoString:&descString]) {
//                        NSString *desc = [self.articleDescription stripHtml];
//                        [self.textView setText:desc];
//                        [self.textView layoutIfNeeded];
////                        
//                       // CGRect frame = self.textView.frame;
//                         float height = self.textView.contentSize.height;
//                        [self.textViewHeight setConstant:height];
                      //  frame.size.height = frame.size.height + 40; //self.textView.contentSize.height;
                      //  self.textView.frame = frame;
//                        NSLog(@"height2:%f",self.textView.frame.size.height);
//                        NSLog(@"scroll2:%f",self.scrollView.frame.size.height);

                        
                        
                    }
                }
                
            }
            else {
                // Do nothing? I think this would be hit on the last time through the loop
            }
        }
        
    }
}






- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLbl.translatesAutoresizingMaskIntoConstraints = NO;
    
}

-(void)viewWillLayoutSubviews{
  //  self.descLbl.preferredMaxLayoutWidth = 1000;

//    [self.textView layoutIfNeeded];
//    [self.scrollView layoutIfNeeded];
//    float height = self.textView.contentSize.height;
//    [self.textViewHeight2 setConstant:height];
  //  self.textViewHeight2. = self.tesxtView.


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)furthurReadingAction:(id)sender {
    NSURL *url = [NSURL URLWithString:self.link];
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"error");
    }
}
@end
