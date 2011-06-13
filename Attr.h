//
//  Attr.h
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import "Doc.h"

@interface Attr : RKObject<NSCoding>

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *value;

@end
