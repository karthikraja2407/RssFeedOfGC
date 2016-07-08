//
//  RSSEntry.h
//  GadgetCongress
//
//  Created by karthik on 12/06/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSEntry : NSObject{
}
@property (copy) NSString *blogTitle;
@property (copy) NSString *articleTitle;
@property (copy) NSString *articleUrl;
@property (copy) NSString *articleDate;
@property (copy) NSString *imageUrl;
@property (copy) NSString *description;
@property (copy) NSString *articleAuthor;
@property(copy) NSString *link;

@property (nonatomic,strong) NSMutableArray *allEntries;

- (id)initWithBlogTitle:(NSString*)blogTitle articleTitle:(NSString*)articleTitle articleUrl:(NSString*)articleUrl articleDate:(NSDate*)articleDate;
@end
