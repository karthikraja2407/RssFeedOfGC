//
//  Item.h
//  GadgetCongress
//
//  Created by karthik on 11/06/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject
@property(strong,nonatomic) NSString *imageUrl;
@property(strong,nonatomic) NSString *date;
@property(strong,nonatomic) NSString *details;
@property(strong,nonatomic) NSString *item_title;
@property(strong,nonatomic) NSString *link;

@end
