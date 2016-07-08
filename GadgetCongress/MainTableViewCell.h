//
//  MainTableViewCell.h
//  GadgetCongress
//
//  Created by karthik on 18/06/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface MainTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet AsyncImageView *articleImageView;

@property (weak, nonatomic) IBOutlet UILabel *articleTitle;

@property (weak, nonatomic) IBOutlet UILabel *articleDate;


@property (weak, nonatomic) IBOutlet UILabel *authorLbl;


@end
