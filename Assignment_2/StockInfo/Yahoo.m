//
//  Yahoo.m
//  StockInfo
//
//  Created by Parth Patel on 2018-04-18.
//  Copyright © 2018 Seneca College. All rights reserved.
//

#import "Yahoo.h"

@implementation Yahoo

-(void)searchYahooForUserText:(NSString *)text{

    
    self.myQue = dispatch_queue_create("myQueue", NULL);
    NSError* error = nil;
    dispatch_async(self.myQue, ^{
        
        
        NSString* stringURL = [NSString stringWithFormat:@"http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=%@&region=1&lang=en&callback=YAHOO.Finance.SymbolSuggest.ssCallback",text];
        NSURL * url = [NSURL URLWithString:stringURL];
        NSString* jsonFromURL = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        if (error == nil){
        
            jsonFromURL = [jsonFromURL substringFromIndex:39];
            jsonFromURL = [jsonFromURL substringToIndex:jsonFromURL.length-2];
            
            NSData* data = [jsonFromURL dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary* jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray* results = [jsonDictionary valueForKeyPath:@"ResultSet.Result"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate yahooDidFinishWithResults:results];
            });
            
        }
        
    });
    
    
}


@end
