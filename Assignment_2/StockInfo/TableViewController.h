//
//  TableViewController.h
//  StockInfo
//
//  Created by Parth Patel on 2018-04-18.
//  Copyright © 2018 Seneca College. All rights reserved.
//
#import <CoreData/CoreData.h>
//#import "Stock+CoreDataProperties.swift"

#import <UIKit/UIKit.h>
#include "AppDelegate.h"

@interface TableViewController : UITableViewController

@property(strong, nonatomic) NSDictionary* item;
@property(strong, nonatomic) NSDictionary* tempItm;
@property (nonatomic, weak) AppDelegate *appDelegate;

@end
