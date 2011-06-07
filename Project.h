//
//  Project.h
//  Vellum for iPad
//
//  Created by Nat Budin on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface Project : RKObject {
    NSString *_name;
    NSNumber *_identifier;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSNumber* identifier;

@end
