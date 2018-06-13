///
//  Yahoo.h
//  StockInfo
//
//  Created by Parth Patel on 2018-04-18.
//  Copyright © 2018 Seneca College. All rights reserved.
//
#import <Foundation/Foundation.h>


@protocol yahooSearchDelegate

@required
-(void)yahooDidFinishWithResults :(NSArray*)YahooResults;

@end



@interface Yahoo : NSObject

@property (nonatomic)dispatch_queue_t myQue;


@property (nonatomic)id<yahooSearchDelegate> delegate;
-(void)searchYahooForUserText :(NSString*)text;

@end
