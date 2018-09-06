//
//  MainViewController.h
//  FindHorizon
//
//  Created by Michael Dietz on 07.09.14.
//  Copyright (c) 2014 Michael Dietz. All rights reserved.
//

#import "FlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
