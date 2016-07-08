//
//  MainTableViewCell.m
//  GadgetCongress
//
//  Created by karthik on 18/06/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import "MainTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "AsyncImageView.h"

@implementation MainTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.articleImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.articleImageView.clipsToBounds = YES;
        [self.articleImageView setShowActivityIndicator:YES];
     //   [self.articleImageView.layer.masksToBounds = YES;
        self.articleImageView.layer.cornerRadius = 5.0;
    }
    return self;
}

//-(id)initWithCoder:(NSCoder *)aDecoder {
//    if ( !(self = [super initWithCoder:aDecoder]) ) return nil;
//    
//    // Your code goes here!
//    self.articleImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.articleImageView.clipsToBounds = YES;
//    [self.articleImageView setShowActivityIndicator:YES];
//    self.articleImageView.layer.masksToBounds = YES;
//     
//    self.articleImageView.layer.cornerRadius = 5.0;
//    return self;
//}

-(void)awakeFromNib{
    self.articleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.articleImageView.clipsToBounds = YES;
    [self.articleImageView setShowActivityIndicator:YES];
    self.articleImageView.layer.masksToBounds = YES;
    
    self.articleImageView.layer.cornerRadius = 5.0;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
