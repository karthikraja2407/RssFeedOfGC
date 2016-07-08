//
//  RSSEntry.m
//  GadgetCongress
//
//  Created by karthik on 12/06/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import "RSSEntry.h"

@implementation RSSEntry

- (id)initWithBlogTitle:(NSString*)blogTitle articleTitle:(NSString*)articleTitle articleUrl:(NSString*)articleUrl articleDate:(NSDate*)articleDate
{
    if ((self = [super init])) {
        _blogTitle = [blogTitle copy];
        _articleTitle = [articleTitle copy];
        _articleUrl = [articleUrl copy];
        _articleDate = [articleDate copy];
        
    }
    return self;
}

@end
