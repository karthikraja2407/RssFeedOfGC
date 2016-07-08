//
//  GDataXMLElement-Extras.h
//  GadgetCongress
//
//  Created by karthik on 12/06/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GDataXMLNode.h"

@interface GDataXMLElement (Extras)

- (GDataXMLElement *)elementForChild:(NSString *)childName;
- (NSString *)valueForChild:(NSString *)childName;

@end
