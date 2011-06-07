//
//  SugarPondLoginDelegate.h
//  Vellum for iPad
//
//  Created by Nat Budin on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SugarPondLoginDelegate <NSObject>
-(void)loginSucceeded;
-(void)loginFailedWithError:(NSError*)error;
@end
