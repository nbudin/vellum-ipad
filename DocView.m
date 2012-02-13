//
//  DocView.m
//  Vellum for iPad
//
//  Created by Nat Budin on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DocView.h"
#import "Attr.h"

@implementation DocView

@synthesize doc=_doc;

static NSString *layout = @"<!DOCTYPE html>\
<html>\
<head>\
<style type=\"text/css\">\
body { font-family: sans-serif; background-color: #dde; margin: 10px; }\
.page { border-radius: 10px; border: 2px #88a solid; padding: 5px; background-color: #fff; min-height: 100%; }\
table.attrs { border-collapse: collapse; width: 100%; }\
table.attrs tr { border-top: 1px #aaa solid; }\
table.attrs th { width: 200px; text-align: left; vertical-align: top; }\
table.attrs td, .content { font-family: serif; }\
table.attrs td *:first-child { margin-top: 0; }\
table.attrs td *:last-child { margin-bottom: 0; }\
h1:first-child { margin-top: 0; }\
</style>\
</head>\
<body>\
<div class=\"page\">%@</div>\
</body>\
</html>";

-(void)setDoc:(Doc *)doc {
    _doc = doc;
    
    NSMutableString *html = [NSMutableString stringWithFormat:@"<h1>%@</h1>\n<table class=\"attrs\">", doc.name];
    
    for (Attr *attr in doc.attrs) {
        [html appendString:[NSString stringWithFormat:@"<tr><th>%@</th><td>%@</td></tr>", attr.name, attr.value]];
    }
    
    [html appendString:@"</table>"];
    [html appendString:[NSString stringWithFormat:@"<div class=\"content\">%@</div>", doc.content]];
    
    [self loadHTMLString:[NSString stringWithFormat:layout, html] baseURL:[NSURL URLWithString:@"http://vellum.aegames.org"]];
}

@end
